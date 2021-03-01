import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class CreateClass extends StatefulWidget {
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 9.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        backgroundColor: cyan,
        centerTitle: true,
        elevation: 0,
        title: Column(
          children: [
            SizedBox(
                height: 2.0.h,
              ),
            FittedBox(fit: BoxFit.fitWidth, child:Text("Crear clase")),
          ],
        ),
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/images/LogoCompleto.png",
                    width: 20.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 5.0.h,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context, func: () {
                goToExcercisesClass("CALENTAMIENTO");
              },
                  text: "      CALENTAMIENTO",
                  textStyle: TextStyle(color: blue, fontSize: 6.5.w),
                  backgroudColor: cyan,
                  width: 90.0.w,
                  height: 9.0.h,
                  circleRadius: 8.0.w,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: cyan,
                    size: 10.0.w,
                  )),
              SizedBox(
                height: 4.0.h,
              ),
              buttonRounded(context, func: () {
                goToExcercisesClass("DESARROLLO");
              },
                  text: "      DESARROLLO",
                  textStyle: TextStyle(color: blue, fontSize: 6.5.w),
                  backgroudColor: green,
                  width: 90.0.w,
                  height: 9.0.h,
                  circleRadius: 8.0.w,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: green,
                    size: 10.0.w,
                  )),
              SizedBox(
                height: 4.0.h,
              ),
              buttonRounded(context, func: () {
                goToExcercisesClass("VUELTA A LA CALMA");
              },
                  text: "      VUELTA A LA CALMA",
                  textStyle: TextStyle(color: blue, fontSize: 5.5.w),
                  backgroudColor: yellow,
                  width: 90.0.w,
                  height: 9.0.h,
                  circleRadius: 8.0.w,
                  icon: Icon(
                    Icons.arrow_forward_ios,
                    color: yellow,
                    size: 10.0.w,
                  )),
            ],
          )
        ],
      ),
    );
  }
}
