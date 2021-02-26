import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class MenuEvidences extends StatefulWidget {
  @override
  _MenuEvidencesState createState() => _MenuEvidencesState();
}

class _MenuEvidencesState extends State<MenuEvidences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: Container(
      //   width: double.infinity,
      //   height: 10.0.h,
      //   color: cyan,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [buttonRounded(context, func: () {}, text: "   CONTINUAR")],
      //   ),
      // ),
      appBar: AppBar(
        backgroundColor: cyan,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 12.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        title: Column(
          children: [
            SizedBox(
                height: 2.0.h,
              ),
            FittedBox(fit: BoxFit.fitWidth, child:Text("EVIDENCIAS")),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 80.0.w,
                height: 8.0.h,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: red),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: red,
                      radius: 7.0.w,
                      child: CircleAvatar(
                          backgroundColor: red,
                          radius: 6.5.w,
                          child: Icon(
                            Icons.camera_alt,
                            color: blue,
                            size: 10.0.w,
                          )),
                    ),
                    Center(
                        child: Text(
                      "  CLASE CREADA",
                      style: TextStyle(color: red, fontSize: 6.0.w),
                    )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 3.0.h,
          ),
          InkWell(
            onTap: () {
              goToShowPhases(2, "VIDEOS", true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80.0.w,
                  height: 8.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 7.0.w,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6.5.w,
                            child: Icon(
                              Icons.camera_alt,
                              color: blue,
                              size: 10.0.w,
                            )),
                      ),
                      Center(
                          child: Text(
                        "  VIDEOS",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          InkWell(
            onTap: () {
              goToShowPhases(2, "CUESTIONARIOS", true);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80.0.w,
                  height: 8.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 7.0.w,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6.5.w,
                            child: Icon(
                              Icons.camera_alt,
                              color: blue,
                              size: 10.0.w,
                            )),
                      ),
                      Center(
                          child: Text(
                        "  CUESTIONARIOS",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          InkWell(
            onTap: () {
              goToReports(false);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80.0.w,
                  height: 8.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 7.0.w,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6.5.w,
                            child: Icon(
                              Icons.camera_alt,
                              color: blue,
                              size: 10.0.w,
                            )),
                      ),
                      Center(
                          child: Text(
                        "  REPORTES",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "DESCARGA LAS EVIDENCIAS \nINGRESANDO A INTRANET DESDE \nTU COMPUTADORA",
                style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                textAlign: TextAlign.center,
              )
            ],
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context,
                  text: "TU CLAVE: 342452",
                  icon: Icon(
                    Icons.lock_open_rounded,
                    color: Colors.white,
                    size: 10.0.w,
                  ),
                  circleColor: blue,
                  circleRadius: 7.0.w,
                  backgroudColor: Colors.white,
                  width: 90.0.w,
                  height: 8.0.h,
                  textStyle: TextStyle(color: blue, fontSize: 6.0.w))
            ],
          ),
        ],
      ),
    );
  }
}
