import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class ShowCycle extends StatefulWidget {
  @override
  _ShowCycleState createState() => _ShowCycleState();
}

class _ShowCycleState extends State<ShowCycle> {
  @override
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      backgroundColor: args["cycle"] == 1
          ? green
          : args["cycle"] == 2
              ? red
              : yellow,
      appBar: AppBar(
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
                child: Text(args["nameCourse"].toString().toUpperCase())),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -1.0.w),
                    angle: pi,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: args["cycle"] == 1
                            ? Color.fromRGBO(20, 123, 83, 1)
                            : args["cycle"] == 2
                                ? Color.fromRGBO(167, 71, 66, 1)
                                : Color.fromRGBO(174, 142, 16, 1),
                        width: 70.0.w),
                  ),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(
                height: 3.0.h,
              )
            ],
          ),
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 20.0.h,
                  ),
                  InkWell(
                    onTap: () {
                      goToShowPhases(args["cycle"], "POR DEFECTO", false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 10.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.arrow_forward,
                                  color: Colors.white,
                                  size: 13.0.w,
                                ),
                              ],
                            ),
                            Text(
                              "POR DEFECTO",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 6.0.w),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 2.0.w,
                        ),
                        card(false, cyan),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Column(
                children: [
                  SizedBox(
                    height: 45.0.h,
                  ),
                  InkWell(
                    onTap: () {
                      goToShowPhases(args["cycle"], "CREAR CLASES", false);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        card(
                          true,
                          args["cycle"] == 1
                              ? yellow
                              : args["cycle"] == 2
                                  ? yellow
                                  : green,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.0.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                  size: 13.0.w,
                                ),
                              ],
                            ),
                            Text(
                              "CREAR CLASES",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 6.0.w),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 2.0.w,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          // card()
        ],
      ),
    );
  }

  Widget card(bool left, Color color) {
    return Container(
      height: 25.0.h,
      width: 45.0.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 5),
                  borderRadius: left == false
                      ? BorderRadius.only(
                          topLeft: Radius.circular(50),
                          bottomLeft: Radius.circular(50),
                        )
                      : BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                  color: color,
                ),
                width: 45.0.w,
                height: 14.0.h,
              ),
            ],
          ),
          Column(
            children: [
              Image.asset(
                "Assets/images/boys.png",
                height: 24.0.h,
              ),
              SizedBox(
                height: 1.0.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
