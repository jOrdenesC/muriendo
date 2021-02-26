import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  ClassDataRepository classDataRepository = GetIt.I.get();
  bool loaded = false;
  bool noData = false;
  List dataClasses = [];
  int phasePhone;

  getClasses() async {
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
  }

  getPhase() async {
    var prefs = await SharedPreferences.getInstance();
    int phase = prefs.getInt("phase");
    setState(() {
      phasePhone = phase;
    });
  }

  @override
  void initState() {
    getClasses();
    getPhase();
    super.initState();
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
                          phasePhone == 1
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[0],
                          dataClasses[0].number),
                      //fourth
                      item(
                          phasePhone == 1
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[3],
                          dataClasses[3].number),
                      //second
                      item(
                          phasePhone == 1
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[1],
                          dataClasses[1].number),
                      //third
                      item(
                          phasePhone == 1
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 1 ? false : true,
                          dataClasses[2],
                          dataClasses[2].number),
                    ]),
                    divider(green, "FASE 2"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 2
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[4],
                          dataClasses[4].number),
                      //fourth
                      item(
                          phasePhone == 2
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[7],
                          dataClasses[7].number),
                      //second
                      item(
                          phasePhone == 2
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[5],
                          dataClasses[5].number),
                      //third
                      item(
                          phasePhone == 2
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 2 ? false : true,
                          dataClasses[6],
                          dataClasses[6].number),
                    ]),
                    divider(red, "FASE 3"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 3
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[8],
                          dataClasses[8].number),
                      //fourth
                      item(
                          phasePhone == 3
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[11],
                          dataClasses[11].number),
                      //second
                      item(
                          phasePhone == 3
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[9],
                          dataClasses[9].number),
                      //third
                      item(
                          phasePhone == 3
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 3 ? false : true,
                          dataClasses[10],
                          dataClasses[10].number),
                    ]),
                    divider(yellow, "FASE 4"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 4
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[12],
                          dataClasses[12].number),
                      //fourth
                      item(
                          phasePhone == 4
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[15],
                          dataClasses[15].number),
                      //second
                      item(
                          phasePhone == 4
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[13],
                          dataClasses[13].number),
                      //third
                      item(
                          phasePhone == 4
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 4 ? false : true,
                          dataClasses[14],
                          dataClasses[14].number),
                    ]),
                    divider(green, "FASE 5"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 5
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[16],
                          dataClasses[16].number),
                      //fourth
                      item(
                          phasePhone == 5
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[19],
                          dataClasses[19].number),
                      //second
                      item(
                          phasePhone == 5
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[17],
                          dataClasses[17].number),
                      //third
                      item(
                          phasePhone == 5
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 5 ? false : true,
                          dataClasses[18],
                          dataClasses[18].number),
                    ]),
                    divider(red, "FASE 6"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 6
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[20],
                          dataClasses[20].number),
                      //fourth
                      item(
                          phasePhone == 6
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[23],
                          dataClasses[23].number),
                      //second
                      item(
                          phasePhone == 6
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[21],
                          dataClasses[21].number),
                      //third
                      item(
                          phasePhone == 6
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 6 ? false : true,
                          dataClasses[22],
                          dataClasses[22].number),
                    ]),
                    divider(yellow, "FASE 7"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 7
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[24],
                          dataClasses[24].number),
                      //fourth
                      item(
                          phasePhone == 7
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[27],
                          dataClasses[27].number),
                      //second
                      item(
                          phasePhone == 7
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[25],
                          dataClasses[25].number),
                      //third
                      item(
                          phasePhone == 7
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 7 ? false : true,
                          dataClasses[26],
                          dataClasses[26].number),
                    ]),
                    divider(green, "FASE 8"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 8
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[28],
                          dataClasses[28].number),
                      //fourth
                      item(
                          phasePhone == 8
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[31],
                          dataClasses[31].number),
                      //second
                      item(
                          phasePhone == 8
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[29],
                          dataClasses[29].number),
                      //third
                      item(
                          phasePhone == 8
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 8 ? false : true,
                          dataClasses[30],
                          dataClasses[30].number),
                    ]),
                    divider(red, "FASE 9"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 9
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[32],
                          dataClasses[32].number),
                      //fourth
                      item(
                          phasePhone == 9
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[35],
                          dataClasses[35].number),
                      //second
                      item(
                          phasePhone == 9
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[33],
                          dataClasses[33].number),
                      //third
                      item(
                          phasePhone == 9
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 9 ? false : true,
                          dataClasses[34],
                          dataClasses[34].number),
                    ]),
                    divider(yellow, "FASE 10"),
                    createPhase([
                      //first
                      item(
                          phasePhone == 10
                              ? "Assets/images/buttons/2unlock.png"
                              : "Assets/images/buttons/2lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[36],
                          dataClasses[36].number),
                      //fourth
                      item(
                          phasePhone == 10
                              ? "Assets/images/buttons/3unlock.png"
                              : "Assets/images/buttons/3lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[39],
                          dataClasses[39].number),
                      //second
                      item(
                          phasePhone == 10
                              ? "Assets/images/buttons/1unlock.png"
                              : "Assets/images/buttons/1lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[37],
                          dataClasses[37].number),
                      //third
                      item(
                          phasePhone == 10
                              ? "Assets/images/buttons/4unlock.png"
                              : "Assets/images/buttons/4lock.png",
                          phasePhone == 10 ? false : true,
                          dataClasses[38],
                          dataClasses[38].number),
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

  Widget item(String route, bool lock, var data, int number) {
    return InkWell(
      onTap: () {
        if (lock == false) {
          goToPlanification(data, number);
        } else {
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
                height: 5.0.h,
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
