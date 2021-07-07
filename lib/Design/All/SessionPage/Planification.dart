import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/All/SessionPage/excercisePage.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:orientation_helper/orientation_helper.dart';

class Planification extends StatefulWidget {
  @override
  _PlanificationState createState() => _PlanificationState();
}

class _PlanificationState extends State<Planification> {
  @override
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: args["isTeacher"]
          ? SizedBox.shrink()
          : Container(
              width: double.infinity,
              height: 10.0.h,
              color: cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonRounded(context,
                      circleRadius: Device.get().isTablet ? 3.5.w : 4.5.w,
                      func: () async {
                    Get.to(
                      ExcerciseVideo(
                          args['data'].toMap()["classID"].toString(),
                          args["data"].questionnaire,
                          args["number"],
                          args["phase"],
                          args["isCustom"]),
                    );
                  }, text: "   COMENZAR")
                ],
              ),
            ),
      backgroundColor: blue,
      appBar: AppBar(
        toolbarHeight: 6.0.h,
        leading: Device.get().isTablet
            ? IconButton(
                icon: Icon(Icons.arrow_back, size: 7.5.w, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
            : IconButton(
                icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
        backgroundColor: cyan,
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  args["isTeacher"] == true
                      ? "EJECUCIÓN SESIÓN ${args["dataClass"]["session"]}"
                      : "EJECUCIÓN SESIÓN ${args["number"]}",
                  style: TextStyle(fontSize: 12.0.sp),
                )),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Transform.rotate(
                origin: Offset(-3.0.w, -3.0.w),
                angle: pi * 1.5,
                child: SvgPicture.asset("Assets/images/figure2.svg",
                    color: Color.fromRGBO(25, 45, 99, 1), width: 96.0.w),
              ),
            ],
          ),
          ListView(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            children: [
              Text(""),
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Device.get().isTablet
                            ? Image.asset("Assets/images/LogoCompleto.png",
                                width: 10.0.w)
                            : Image.asset("Assets/images/LogoCompleto.png",
                                width: 20.0.w)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            print(args["data"].exerci.toString());
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "calentamiento",
                                  args["dataClass"]["exercisesCalentamiento"],
                                  args["isTeacher"]);
                            } else {
                              List calentamiento = [];
                              for (var i = 0;
                                  i <
                                      args['data']
                                          .excerciseCalentamiento
                                          .length;
                                  i++) {
                                setState(() {
                                  calentamiento.add(
                                      args['data'].excerciseCalentamiento[i]);
                                });
                              }

                              for (var i = 0;
                                  i < args['data'].excerciseFlexibilidad.length;
                                  i++) {
                                setState(() {
                                  calentamiento.add(
                                      args['data'].excerciseFlexibilidad[i]);
                                });
                              }

                              // print(calentamiento);
                              goToExcercisesPage("calentamiento", calentamiento,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 35.0.w,
                                height: 10.0.h,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  color: cyan,
                                ),
                              ),
                              SizedBox(
                                width: 0.04.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_outlined,
                                        color: cyan,
                                        size: 10.0.w,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "CALENTAMIENTO",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 6.0.w),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 2.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "calentamiento",
                                  args["dataClass"]["exercisesCalentamiento"],
                                  args["isTeacher"]);
                            } else {
                              List calentamiento = [];
                              for (var i = 0;
                                  i <
                                      args['data']
                                          .excerciseCalentamiento
                                          .length;
                                  i++) {
                                setState(() {
                                  calentamiento.add(
                                      args['data'].excerciseCalentamiento[i]);
                                });
                              }

                              for (var i = 0;
                                  i < args['data'].excerciseFlexibilidad.length;
                                  i++) {
                                setState(() {
                                  calentamiento.add(
                                      args['data'].excerciseFlexibilidad[i]);
                                });
                              }

                              // print(calentamiento);
                              goToExcercisesPage("calentamiento", calentamiento,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.0.w,
                              ),
                              Image.asset(
                                "Assets/images/boys.png",
                                height: 19.0.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "desarrollo",
                                  args["dataClass"]["exercisesDesarrollo"],
                                  args["isTeacher"]);
                            } else {
                              goToExcercisesPage(
                                  "desarrollo",
                                  args['data'].excerciseDesarrollo,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 35.0.w,
                                height: 10.0.h,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  color: green,
                                ),
                              ),
                              SizedBox(
                                width: 0.04.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_outlined,
                                        color: green,
                                        size: 10.0.w,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "DESARROLLO",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 6.0.w),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 22.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "desarrollo",
                                  args["dataClass"]["exercisesDesarrollo"],
                                  args["isTeacher"]);
                            } else {
                              goToExcercisesPage(
                                  "desarrollo",
                                  args['data'].excerciseDesarrollo,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.0.w,
                              ),
                              Image.asset(
                                "Assets/images/boys.png",
                                height: 19.0.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "vuelta a la calma",
                                  args["dataClass"]["exercisesVueltaCalma"],
                                  args["isTeacher"]);
                            } else {
                              goToExcercisesPage(
                                  "vuelta a la calma",
                                  args['data'].excerciseVueltaCalma,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 35.0.w,
                                height: 10.0.h,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(50),
                                    bottomRight: Radius.circular(50),
                                  ),
                                  color: yellow,
                                ),
                              ),
                              SizedBox(
                                width: 0.04.h,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.arrow_back_outlined,
                                        color: yellow,
                                        size: 10.0.w,
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "VUELTA A LA CALMA",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 5.0.w),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 90, 0, 0),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 42.0.h,
                        ),
                        InkWell(
                          onTap: () {
                            if (args["isTeacher"]) {
                              goToExcercisesPage(
                                  "vuelta a la calma",
                                  args["dataClass"]["exercisesVueltaCalma"],
                                  args["isTeacher"]);
                            } else {
                              goToExcercisesPage(
                                  "vuelta a la calma",
                                  args['data'].excerciseVueltaCalma,
                                  args["isTeacher"]);
                            }
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: 5.0.w,
                              ),
                              Image.asset(
                                "Assets/images/boys.png",
                                height: 19.0.h,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
