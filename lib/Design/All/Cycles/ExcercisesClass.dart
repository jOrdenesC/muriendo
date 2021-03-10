import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import './AddExcercises.dart';

class ExcercisesClass extends StatefulWidget {
  @override
  _ExcercisesClassState createState() => _ExcercisesClassState();
}

class _ExcercisesClassState extends State<ExcercisesClass> {
  @override
  Widget build(BuildContext context) {
    final dynamic title =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: cyan,
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text(title["title"])),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/images/logo.png",
                    width: 20.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 2.0.h,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("ABDOMINAL CORE", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        ABDOMINAL CORE",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CUERPO SUPERIOR", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CUERPO SUPERIOR",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CUERPO INFERIOR", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CUERPO INFERIOR",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CARDIO", title["title"], title["level"],
                    title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CARDIO",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("FLEXIBILIDAD", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        FLEXIBILIDAD",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                Get.to(AddExcercises(
                  level: title["level"],
                  category: "ADAPTADOS NIÑOS PIE",
                  subCategory: "ADAPTADOS NIÑOS PIE",
                  stage: title["title"],
                  number: title["number"],
                  isPie: true,
                ));
                // goToFilterExcercises("ADAPTADOS NIÑOS PIE", title["title"],
                //     title["level"], title["number"], true);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        ADAPTADOS NIÑOS PIE",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
            ],
          )
        ],
      ),
    );
  }

  Widget button(Function func, double width, double height, double circleRadius,
      String text, Widget icon, Color circleColor, TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: func,
          child: Container(
            width: width ?? 60.0.w,
            height: height ?? 6.0.h,
            decoration: BoxDecoration(
                border: Border.all(color: circleColor, width: 3),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Ink(
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: circleRadius ?? 5.0.w,
                                backgroundColor: circleColor ?? Colors.white,
                                child: Center(
                                    child: icon ??
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: blue,
                                          size: 7.0.w,
                                        )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$text",
                              style: textStyle ??
                                  TextStyle(
                                      color: Colors.white, fontSize: 5.5.w),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
