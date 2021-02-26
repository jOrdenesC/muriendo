import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

Widget buttonRounded(BuildContext context,
    {Function func,
    double width,
    double height,
    String text,
    Color backgroudColor,
    Widget icon,
    Color circleColor,
    TextStyle textStyle,
    double circleRadius}) {
  return InkWell(
    onTap: func,
    child: Container(
      width: width ?? 60.0.w,
      height: height ?? 6.0.h,
      decoration: BoxDecoration(
          color: backgroudColor ?? blue,
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
                            TextStyle(color: Colors.white, fontSize: 5.5.w),
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
  );
}
