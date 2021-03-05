import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Functions/downloadData.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  ClassDataRepository classDataRepository = GetIt.I.get();
  EvidencesRepository evidencesRepository = GetIt.I.get();
  bool loaded = false;
  bool noData = false;
  List dataClasses = [];
  int phasePhone;
  List<bool> evidences = [];
  bool downloaded = false;

  Future getEvidence() async {
    var all = await evidencesRepository.getAllEvidences();
    for (var i = 0; i < all.length; i++) {
      if (all.isNotEmpty) {
        setState(() {
          evidences.add(all[i].finished);
        });
      } else {
        setState(() {
          evidences.add(false);
        });
      }
    }
    print(evidences.toString());
    print("AAAAA " + evidences[0].toString());
    return true;
  }

  Future getClasses() async {
    var res = await classDataRepository.getAllClassLevel();
    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        dataClasses.add(res[i]);
      }
      setState(() {
        loaded = true;
      });
    } else {
      setState(() {
        noData = true;
      });
    }
    return true;
  }

  Future getPhase() async {
    var prefs = await SharedPreferences.getInstance();
    int phase = prefs.getInt("phase");
    setState(() {
      phasePhone = phase;
    });
    return true;
  }

  Future getData() async {
    await DownloadData().getUserData(context);
    var prefs = await SharedPreferences.getInstance();
    var down = prefs.getBool("downloaded" ?? false);
    var token = prefs.getString("token" ?? false);
    String level;
    CourseDataRepository courseDataRepository = GetIt.I.get();

    var course = await courseDataRepository.getAllCourse();
    if (course.isNotEmpty) {
      setState(() {
        level = course[0].number;
      });
    }
    setState(() {
      downloaded = down;
    });

    String platform = "";
    if (Platform.isAndroid) {
      setState(() {
        platform = "android";
      });
    } else if (Platform.isIOS) {
      setState(() {
        platform = "ios";
      });
    }

    Response responseVideos = await Dio().post(
        "https://intranet.movitronia.com/api/mobile/videosZip?token=$token",
        data: {"platform": platform});
    print("RESPONSE VIDEOS " + responseVideos.data);
    Response responseAudiosExercise = await Dio().get(
        "https://intranet.movitronia.com/api/mobile/audiosExercisesZip?token=$token");
    print("RESPONSE AUDIOS EXERCISE " + responseAudiosExercise.data);
    Response responseAudiosLevel = await Dio().get(
        "https://intranet.movitronia.com/api/mobile/audiosLevelZip/$level?token=$token");
    print("RESPONSE AUDIOS TIPS ${responseAudiosLevel.data}");

    if (downloaded == false || downloaded == null) {
      await DownloadData().downloadAll(
          context: context,
          level: level,
          url1: responseVideos.data,
          platform: platform,
          filename1: "videos.zip",
          url2: responseAudiosExercise.data,
          filename2: "audiosExercise.zip",
          url3: responseAudiosLevel.data,
          filename3: "audiosLevel.zip");
      // await downloadFiles(response.data, "videos.zip");
      // downloadFiles(url, filenames)
    }
    return true;
  }

  void _restartApp() async {
    FlutterRestart.restartApp();
  }

  @override
  void initState() {
    getAll();
    // getData();
    super.initState();
  }

  getAll() async {
    var prefs = await SharedPreferences.getInstance();
    var downloaded = prefs.getBool("downloaded" ?? false);
    if (downloaded == null || downloaded == false) {
      try {
        await getData();
        await getClasses();
        await getPhase();
        setState(() {
          loaded = false;
        });
        await getEvidence();
        setState(() {
          loaded = true;
        });
        prefs.setBool("downloaded", true);
        _restartApp();
      } catch (e) {
        print(e);
      }
    } else {
      try {
        await getClasses();
        await getPhase();
        setState(() {
          loaded = false;
        });
        await getEvidence();
        setState(() {
          loaded = true;
        });
      } catch (e) {
        print(e);
      }
    }
  }

  Widget build(BuildContext context) {
    return noData
        ? Center(
            child: Text(
              "No existen clases aún.",
              style: TextStyle(color: Colors.white, fontSize: 7.0.w),
            ),
          )
        : loaded
            ? body()
            : Center(
                child: Image.asset(
                  "Assets/videos/loading.gif",
                  fit: BoxFit.contain,
                  width: 30.0.w,
                ),
              );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.0.w,
                ),
                Image.asset(
                  "Assets/images/LogoCompleto.png",
                  width: 18.0.w,
                )
              ],
            ),
            Flexible(
              flex: 1,
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    divider(yellow, "FASE 1"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 1
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[0],
                          dataClasses[0].number,
                          true),
                      //fourth
                      item(
                          phasePhone >= 1 && evidences[2]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[3],
                          dataClasses[3].number,
                          evidences[2] == true ? true : false),
                      //second
                      item(
                          phasePhone >= 1 && evidences[0]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[1],
                          dataClasses[1].number,
                          evidences[0] ? true : false),
                      //third
                      item(
                          phasePhone >= 1 && evidences[1]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[2],
                          dataClasses[2].number,
                          evidences[1] ? true : false),
                    ]),
                    divider(green, "FASE 2"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 2 && evidences[3]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[4],
                          dataClasses[4].number,
                          evidences[3] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 2 && evidences[6]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[7],
                          dataClasses[7].number,
                          evidences[6] ? true : false),
                      //second
                      item(
                          phasePhone >= 2 && evidences[4]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[5],
                          dataClasses[5].number,
                          evidences[4] ? true : false),
                      //third
                      item(
                          phasePhone >= 2 && evidences[5]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[6],
                          dataClasses[6].number,
                          evidences[5] ? true : false),
                    ]),
                    divider(red, "FASE 3"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 3 && evidences[7]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[8],
                          dataClasses[8].number,
                          evidences[7] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 3 && evidences[10]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[11],
                          dataClasses[11].number,
                          evidences[10] ? true : false),
                      //second
                      item(
                          phasePhone >= 3 && evidences[8]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[9],
                          dataClasses[9].number,
                          evidences[8] ? true : false),
                      //third
                      item(
                          phasePhone >= 3 && evidences[9]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[10],
                          dataClasses[10].number,
                          evidences[9] ? true : false),
                    ]),
                    divider(yellow, "FASE 4"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 4 && evidences[11]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[12],
                          dataClasses[12].number,
                          evidences[11] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 4 && evidences[14]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[15],
                          dataClasses[15].number,
                          evidences[14] ? true : false),
                      //second
                      item(
                          phasePhone >= 4 && evidences[12]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[13],
                          dataClasses[13].number,
                          evidences[12] ? true : false),
                      //third
                      item(
                          phasePhone >= 4 && evidences[13]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[14],
                          dataClasses[14].number,
                          evidences[13] ? true : false),
                    ]),
                    divider(green, "FASE 5"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 5 && evidences[15]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[16],
                          dataClasses[16].number,
                          evidences[15] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 5 && evidences[18]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[19],
                          dataClasses[19].number,
                          evidences[18] ? true : false),
                      //second
                      item(
                          phasePhone >= 5 && evidences[16]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[17],
                          dataClasses[17].number,
                          evidences[16] ? true : false),
                      //third
                      item(
                          phasePhone >= 5 && evidences[17]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[18],
                          dataClasses[18].number,
                          evidences[17] ? true : false),
                    ]),
                    divider(red, "FASE 6"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 6 && evidences[19]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[20],
                          dataClasses[20].number,
                          evidences[19] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 6 && evidences[22]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[23],
                          dataClasses[23].number,
                          evidences[22] ? true : false),
                      //second
                      item(
                          phasePhone >= 6 && evidences[20]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[21],
                          dataClasses[21].number,
                          evidences[20] ? true : false),
                      //third
                      item(
                          phasePhone >= 6 && evidences[21]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[22],
                          dataClasses[22].number,
                          evidences[21] ? true : false),
                    ]),
                    divider(yellow, "FASE 7"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 7 && evidences[23]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[24],
                          dataClasses[24].number,
                          evidences[23] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 7 && evidences[26]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[27],
                          dataClasses[27].number,
                          evidences[26] ? true : false),
                      //second
                      item(
                          phasePhone >= 7 && evidences[24]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[25],
                          dataClasses[25].number,
                          evidences[24] ? true : false),
                      //third
                      item(
                          phasePhone >= 7 && evidences[25]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[26],
                          dataClasses[26].number,
                          evidences[25] ? true : false),
                    ]),
                    divider(green, "FASE 8"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 8 && evidences[27]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[28],
                          dataClasses[28].number,
                          evidences[27] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 8 && evidences[30]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[31],
                          dataClasses[31].number,
                          evidences[30] ? true : false),
                      //second
                      item(
                          phasePhone >= 8 && evidences[28]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[29],
                          dataClasses[29].number,
                          evidences[28] ? true : false),
                      //third
                      item(
                          phasePhone >= 8 && evidences[29]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[30],
                          dataClasses[30].number,
                          evidences[29] ? true : false),
                    ]),
                    divider(red, "FASE 9"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 9 && evidences[31]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[32],
                          dataClasses[32].number,
                          evidences[31] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 9 && evidences[34]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[35],
                          dataClasses[35].number,
                          evidences[34] ? true : false),
                      //second
                      item(
                          phasePhone >= 9 && evidences[32]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[33],
                          dataClasses[33].number,
                          evidences[32] ? true : false),
                      //third
                      item(
                          phasePhone >= 9 && evidences[33]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[34],
                          dataClasses[34].number,
                          evidences[33] ? true : false),
                    ]),
                    divider(yellow, "FASE 10"),
                    createPhase([
                      //first
                      item(
                          phasePhone >= 10 && evidences[35]
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[36],
                          dataClasses[36].number,
                          evidences[35] ? true : false),
                      //fourth
                      item(
                          phasePhone >= 10 && evidences[38]
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[39],
                          dataClasses[39].number,
                          evidences[38] ? true : false),
                      //second
                      item(
                          phasePhone >= 10 && evidences[36]
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[37],
                          dataClasses[37].number,
                          evidences[36] ? true : false),
                      //third
                      item(
                          phasePhone >= 10 && evidences[37]
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[38],
                          dataClasses[38].number,
                          evidences[37] ? true : false),
                    ]),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25.0.w,
          height: 10.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Center(
              child: Text(
            "$text",
            style: TextStyle(color: Colors.white, fontSize: 5.0.w),
          )),
        )
      ],
    );
  }

  Widget item(String route, bool phase, var data, int number, bool lock) {
    return InkWell(
      onTap: () {
        print(evidences.toString());
        print(lock);
        if (lock == true) {
          goToPlanification(data, number, false, null);
        } else {
          print(lock);
          Toast.show("Debes completar las clases anteriores.", context,
              duration: Toast.LENGTH_LONG,
              gravity: Toast.CENTER,
              backgroundColor: red);
        }
      },
      child: Container(
        child: Image.asset(
          route,
          width: 28.0.w,
        ),
      ),
    );
  }

  Widget circularActivity(
      String title, double percentage, String img, String number, bool lock) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                width: 35.0.w,
                // color: red,
                child: CircularPercentIndicator(
                  percent: percentage,
                  progressColor: green,
                  lineWidth: 7,
                  radius: 29.0.w,
                  center: CircleAvatar(
                    radius: 12.8.w,
                    backgroundColor: lock ? Colors.grey : yellow,
                    child: ColorFiltered(
                      colorFilter: lock
                          ? ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            )
                          : ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            ),
                      child: Container(
                        margin: lock ? EdgeInsets.all(6.5) : EdgeInsets.all(0),
                        color: Colors.transparent,
                        child: Image.asset(
                          "$img",
                          fit: lock ? BoxFit.contain : BoxFit.cover,
                          width: lock ? 14.0.w : 20.0.w,
                          height: lock ? 20.0.h : 20.0.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0.w,
                left: 22.0.w,
                child: CircularPercentIndicator(
                  lineWidth: 7,
                  radius: 9.0.w,
                  center: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                        child: lock
                            ? Image.asset(
                                "Assets/images/lock.png",
                                width: 4.0.w,
                              )
                            : Image.asset(
                                "Assets/images/unlock.png",
                                width: 5.0.w,
                              )),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget createPhase(List sessions) {
    return Container(
      height: 50.0.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              sessions[0],
              // item("Assets/images/buttons/2unlock.png"),
              SizedBox(
                height: 7.0.h,
              ),
              sessions[1],
              // item("Assets/images/buttons/2lock.png"),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  sessions[2],
                  // item("Assets/images/buttons/1lock.png"),
                  SizedBox(
                    width: 35.0.w,
                  ),
                  sessions[3],
                  // item("Assets/images/buttons/4lock.png"),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

extension MyIterable<E> on Iterable<E> {
  Iterable<E> sortedBy(Comparable key(E e)) =>
      toList()..sort((a, b) => key(a).compareTo(key(b)));
}
