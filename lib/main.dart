import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer_util.dart';
import 'Database/init.dart';
import 'Design/All/splash/splash.dart';
import 'Routes/AppRoutes.dart';
import 'Utils/Colors.dart';
import 'package:sizer/sizer.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  OrientationHelper orientationHelper;
  final Future _init = Init.initialize();
  @override
  void initState() {
    GetStorage box = GetStorage();
    if (box.read("init") != null) {
      log("Value is ${box.read("init")}");
    } else {
      log("No Value Has been set");
    }
    orientationHelper = OrientationHelper(
      routes: AppRoutes.routes,
      defaultOrientation: ScreenOrientation.rotating,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(builder: (context, orientation) {
          SizerUtil().init(constraints, orientation);
          return GetMaterialApp(
            navigatorObservers: [
              orientationHelper.navigatorObserver,
            ],
            onGenerateRoute: orientationHelper.onGenerateRoute,
            title: 'Movitronia',
            theme: ThemeData(
                primaryColor: blue, fontFamily: "Nunito", canvasColor: blue),
            home: FutureBuilder(
              future: _init,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Splash();
                } else {
                  return Material(
                    child: Center(
                      child: Center(
                        child: Image.asset(
                          "Assets/videos/loading.gif",
                          width: 70.0.w,
                          height: 15.0.h,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
            debugShowCheckedModeBanner: false,
          );
        });
      },
    );
  }
}
