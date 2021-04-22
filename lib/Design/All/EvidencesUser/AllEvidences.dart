import 'dart:math';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AllEvidences extends StatefulWidget {
  @override
  _AllEvidencesState createState() => _AllEvidencesState();
}

class _AllEvidencesState extends State<AllEvidences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            FittedBox(fit: BoxFit.fitWidth, child: Text("EVIDENCIAS")),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: green, width: 45.0.w),
                  ),
                  SizedBox(
                    width: 10.0.w,
                  )
                ],
              ),
              SizedBox(
                height: 30.0.h,
              ),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
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
              ),
              SizedBox(
                height: 5.0.h,
              ),
              InkWell(
                onTap: () {
                  goToEvidencesVideos();
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
                              radius: 5.0.w,
                              child: Icon(
                                Icons.camera_alt,
                                color: blue,
                                size: 9.0.w,
                              )
                              // Image.asset(
                              //   "Assets/images/docImage.png",
                              //   color: blue,
                              //   width: 8.0.w,
                              // ),
                              ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text("Vídeos".toUpperCase(),
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
                  goToEvidencesQuestionary();
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
                            radius: 5.0.w,
                            child: Image.asset(
                              "Assets/images/docImage.png",
                              color: blue,
                              width: 5.0.w,
                            ),
                          ),
                          SizedBox(
                            width: 2.0.w,
                          ),
                          Text("Cuestionarios".toUpperCase(),
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
