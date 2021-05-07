import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/All/Settings/offlineDataList.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

import 'ProfilePage.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            FittedBox(fit: BoxFit.fitWidth, child: Text("AJUSTES")),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context,
                  icon: SizedBox.shrink(),
                  // icon: Icon(
                  //   Icons.person,
                  //   size: 10.0.w,
                  //   color: Colors.white,
                  // ),
                  circleRadius: 0.0.w, func: () {
                Get.to(ProfilePage(isMenu: false));
              },
                  height: 8.0.h,
                  width: 80.0.w,
                  textStyle: TextStyle(color: blue, fontSize: 5.0.w),
                  text: "MODIFICAR MI PERFIL",
                  circleColor: blue,
                  backgroudColor: Colors.white),
            ],
          ),
          SizedBox(
            height: 5.0.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context,
                  icon: SizedBox.shrink(),
                  // icon: Icon(
                  //   Icons.person,
                  //   size: 10.0.w,
                  //   color: Colors.white,
                  // ),
                  circleRadius: 0.0.w, func: () {
                goToChangePass();
              },
                  height: 8.0.h,
                  width: 80.0.w,
                  textStyle: TextStyle(color: blue, fontSize: 5.0.w),
                  text: "CAMBIAR MI CONTRASEÑA",
                  circleColor: blue,
                  backgroudColor: Colors.white),
            ],
          ),
          SizedBox(
            height: 5.0.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context,
                  icon: SizedBox.shrink(),
                  // icon: Icon(
                  //   Icons.person,
                  //   size: 10.0.w,
                  //   color: Colors.white,
                  // ),
                  circleRadius: 0.0.w, func: () {
                Get.to(OfflineDataList());
              },
                  height: 8.0.h,
                  width: 80.0.w,
                  textStyle: TextStyle(color: blue, fontSize: 5.0.w),
                  text: "DATOS LOCALES",
                  circleColor: blue,
                  backgroudColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
