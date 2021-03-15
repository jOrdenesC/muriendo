import 'dart:math';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Reports extends StatefulWidget {
  final bool drawerMenu;
  final bool isTeacher;
  final List data;
  Reports({this.drawerMenu, this.isTeacher, this.data});
  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: widget.drawerMenu
          ? AppBar(
              backgroundColor: cyan,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  FittedBox(fit: BoxFit.fitWidth, child: Text("REPORTES")),
                ],
              ),
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: widget.drawerMenu
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: green, width: 45.0.w),
                  ),
                  widget.drawerMenu
                      ? SizedBox.shrink()
                      : Image.asset(
                          "Assets/images/logo.png",
                          width: 30.0.w,
                        ),
                  SizedBox(
                    width: widget.drawerMenu ? 10.0.w : 0,
                  )
                ],
              ),
              // SizedBox(height: 10.0.h
              //     // widget.drawerMenu ? 20.0.h : 0,
              //     ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset("Assets/images/figure2.svg",
                      color: Color.fromRGBO(25, 45, 99, 1), width: 45.0.w),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 17.0.h
                  //  widget.drawerMenu ? 10.0.h : 0.0.h,
                  ),
              widget.drawerMenu
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          "Assets/images/logo.png",
                          width: 30.0.w,
                        ),
                        SizedBox(
                          width: 15.0.w,
                        ),
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(height: 10.0.h
                  // widget.drawerMenu ? 10.0.h : 0.0.h,
                  ),
              InkWell(
                onTap: () {
                  goToCaloricExpenditure(widget.isTeacher, null);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 1.0.w,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 5.5.w,
                            child: Image.asset(
                              "Assets/images/reportIcon.png",
                              color: blue,
                              width: 6.0.w,
                            ),
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text("Gasto calórico",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 5.0.w))
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              bottomLeft: Radius.circular(70))),
                      width: 70.0.w,
                      height: 8.0.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.h,
              ),
              InkWell(
                onTap: () {
                  goToApplicationUse(widget.isTeacher, widget.data);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 1.0.w,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 5.5.w,
                            child: Image.asset(
                              "Assets/images/reportIcon.png",
                              color: blue,
                              width: 6.0.w,
                            ),
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text("Uso de app",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 5.0.w))
                        ],
                      ),
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              bottomLeft: Radius.circular(70))),
                      width: 70.0.w,
                      height: 8.0.h,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
