import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
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
        elevation: 0,
        centerTitle: true,
        title: Text("AJUSTES"),
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
                  icon: Icon(
                    Icons.person,
                    size: 10.0.w,
                    color: Colors.white,
                  ),
                  circleRadius: 7.0.w, func: () {
                Get.to(ProfilePage(isMenu: false));
              },
                  height: 8.0.h,
                  width: 80.0.w,
                  textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                  text: "MI PERFIL",
                  circleColor: blue,
                  backgroudColor: Colors.white),
            ],
          ),
        ],
      ),
    );
  }
}
