import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Functions/downloadTeacher.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/UrlServer.dart';
import '../../Widgets/Toast.dart';

class Cycles extends StatefulWidget {
  final String courseId;
  Cycles({this.courseId});
  @override
  _CyclesState createState() => _CyclesState();
}

class _CyclesState extends State<Cycles> {
  bool downloaded = false;
  List courses = [];
  bool loaded = false;
  List coursesNumber = [];

  downloadAll() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var down = prefs.getBool("downloaded" ?? false);

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
    var dio = Dio();
    Response responseVideos = await dio.post(
        "https://intranet.movitronia.com/api/mobile/videosZip?token=$token",
        data: {"platform": platform});

    if (downloaded == false || downloaded == null) {
      await DownloadTeacher().downloadFiles(
          url: responseVideos.data,
          platform: platform,
          filename: "videos.zip",
          context: context,
          messageAlert: "Descargando vídeos...",
          route: "videos");
      // await downloadFiles(response.data, "videos.zip");
      // downloadFiles(url, filenames)
    }

    if (downloaded == false) {
      loading(context,
          content: Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            "Creando ejercicios",
            textAlign: TextAlign.center,
          ));
      await DownloadTeacher().getExercises(context);
    }
  }

  getCourses() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dio = Dio();
    Response responseCourses = await dio.get(
        "$urlServer/api/mobile/professor/course/${widget.courseId}?token=$token");
    print(responseCourses.data.toString());
    for (var i = 0; i < responseCourses.data.length; i++) {
      setState(() {
        courses.add(responseCourses.data[i]);
        coursesNumber.add(int.parse(responseCourses.data[i]["number"]));
      });
    }
    setState(() {
      loaded = true;
    });
  }

  @override
  void initState() {
    if (downloaded == false) {
      downloadAll();
    }
    getCourses();
    super.initState();
  }

  Widget build(BuildContext context) {
    return loaded
        ? body()
        : Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
            SizedBox(
              height: 3.0.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.0.h,
                    ),
                    divider(green, "PRIMER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(""),
                        element(
                            green,
                            1,
                            "RO",
                            coursesNumber.contains(1) ? true : false,
                            "primero básico",
                            1),
                        element(
                            green,
                            2,
                            "DO",
                            coursesNumber.contains(2) ? true : false,
                            "segundo básico",
                            1),
                        element(
                            green,
                            3,
                            "RO",
                            coursesNumber.contains(3) ? true : false,
                            "tercero básico",
                            1),
                        element(
                            green,
                            4,
                            "TO",
                            coursesNumber.contains(4) ? true : false,
                            "cuarto básico",
                            1),
                        Text("")
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(red, "SEGUNDO CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(
                            red,
                            5,
                            "TO",
                            coursesNumber.contains(5) ? true : false,
                            "quinto básico",
                            2),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(
                            red,
                            6,
                            "TO",
                            coursesNumber.contains(6) ? true : false,
                            "sexto básico",
                            2),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(yellow, "TERCER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(
                            yellow,
                            7,
                            "TO",
                            coursesNumber.contains(7) ? true : false,
                            "séptimo básico",
                            3),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(
                            yellow,
                            8,
                            "VO",
                            coursesNumber.contains(8) ? true : false,
                            "octavo básico",
                            3),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget element(Color color, int course, String fin, bool check,
      String nameCycle, int cycle) {
    return InkWell(
      onTap: () {
        // print(courses.toString());
        if (check) {
          goToshowCycle(nameCycle, cycle);
        } else {
          toast(context, "No tienes este curso asignado.".toUpperCase(), red);
        }
      },
      child: Container(
        width: 16.0.w,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 8.0.w,
              backgroundColor: check ? color : Colors.grey,
              child: CircleAvatar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$course",
                            style: TextStyle(
                                color: check ? blue : Colors.grey,
                                fontSize: 9.0.w)),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text(
                          "$fin",
                          style: TextStyle(
                            color: check ? blue : Colors.grey,
                            fontSize: 3.0.w,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                radius: 6.5.w,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 65.0.w,
          height: 8.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 7.0.w,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 6.5.w,
                    child: Image.asset(
                      "Assets/images/sessionIcon.png",
                      fit: BoxFit.contain,
                      width: 10.0.w,
                      color: color,
                    )),
              ),
              Center(
                  child: Text(
                "$text ",
                style: TextStyle(color: Colors.white, fontSize: 5.0.w),
              )),
            ],
          ),
        )
      ],
    );
  }
}
