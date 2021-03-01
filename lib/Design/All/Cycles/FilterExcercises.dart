import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

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
            icon: Icon(
              Icons.arrow_back,
              size: 9.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        backgroundColor: cyan,
        title: Column(
          children: [
            SizedBox(
                height: 2.0.h,
              ),
            FittedBox(fit: BoxFit.fitWidth, child:Text(title)),
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
                    goToAddExcercises("SOBRE EL SUELO");
                  },
                      text: "SOBRE EL SUELO",
                      width: 90.0.w,
                      height: 9.0.h,
                      circleRadius: 8.0.w,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: blue,
                        size: 10.0.w,
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
                    goToAddExcercises("DE PIE");
                  },
                      text: "DE PIE",
                      width: 90.0.w,
                      height: 9.0.h,
                      circleRadius: 8.0.w,
                      icon: Icon(
                        Icons.arrow_forward_ios,
                        color: blue,
                        size: 10.0.w,
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
