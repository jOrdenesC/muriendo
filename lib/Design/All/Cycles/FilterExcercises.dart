import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../Cycles/AddExcercises.dart';

class FilterExcercises extends StatefulWidget {
  @override
  _FilterExcercisesState createState() => _FilterExcercisesState();
}

class _FilterExcercisesState extends State<FilterExcercises> {
  @override
  Widget build(BuildContext context) {
    final dynamic title =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
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
                child: Text("${title["category"]} | ${title["stage"]}")),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonRounded(context, func: () {
                    Get.to(AddExcercises(
                      level: title["level"],
                      category: title["category"],
                      subCategory: "SOBRE SUELO",
                      stage: title["stage"],
                      number: title["number"],
                      isPie: false,
                    ));
                  },
                      text: "SOBRE SUELO",
                      width: 90.0.w,
                      height: 9.0.h,
                      circleRadius: 6.0.w,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: blue,
                        size: 8.0.w,
                      )),
                ],
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buttonRounded(context, func: () {
                    Get.to(AddExcercises(
                      level: title["level"],
                      category: title["category"],
                      subCategory: "DE PIE",
                      stage: title["stage"],
                      number: title["number"],
                      isPie: false,
                    ));
                  },
                      text: "DE PIE",
                      width: 90.0.w,
                      height: 9.0.h,
                      circleRadius: 6.0.w,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: blue,
                        size: 8.0.w,
                      )),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
