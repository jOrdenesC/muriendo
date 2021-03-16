import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Design/All/Reports/reports.dart';
import 'package:movitronia/Design/All/Sessions/Sessions.dart';
import 'package:movitronia/Design/All/Settings/ProfilePage.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import '../../../Database/Repository/OfflineRepository.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  List<Widget> _screens = [];
  int count = 0;

  List dataClasses = [];

  @override
  void initState() {
    super.initState();
    _screens.add(Sessions());
    _screens.add(Reports(drawerMenu: false, isTeacher: false, data: null));
    _screens.add(ProfilePage(isMenu: true));
  }

  getClasses() async {
    ClassDataRepository classDataRepository = GetIt.I.get();
    var res = await classDataRepository.getAllClassLevel();
    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        dataClasses.add(res[i]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(),
        backgroundColor: blue,
        key: _scaffoldKey,
        drawer: _drawerUser(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 9.0.w,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: cyan,
          elevation: 0,
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _currentIndex == 0
                        ? "SESIONES"
                        : _currentIndex == 1
                            ? "REPORTES"
                            : _currentIndex == 2
                                ? "PERFIL"
                                : "Error al cargar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 6.0.w),
                  )),
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: Color.fromRGBO(25, 45, 99, 1), width: 70.0.w),
                  ),
                ],
              ),
            ],
          ),
          _screens[_currentIndex]
        ]),
      ),
    );
  }

  Future<bool> pop() async {
    setState(() {
      count++;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            count = 0;
          });
        }
      });
    });
    if (count == 2) {
      SystemNavigator.pop();
    } else if (count <= 1) {
      toast(
          context, "Vuelve atrás dos veces para salir de la aplicación.", red);
    }

    return false;
  }

  Widget bottomNavBar() {
    return Container(
      height: 13.0.h,
      width: 100.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonSessions.png",
                  width: 14.0.w,
                ),
                Text("SESIONES", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonReports.png",
                  width: 14.0.w,
                ),
                Text("REPORTES", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonProfile.png",
                  width: 14.0.w,
                ),
                Text("PERFIL", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: cyan),
    );
  }

  Widget _drawerUser() {
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: 100.0.w,
      height: h,
      decoration: BoxDecoration(
        color: blue,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0.h,
            ),
            InkWell(
              child: Text(
                "MENÚ",
                style: TextStyle(color: Colors.white, fontSize: 10.0.w),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            buttonRounded(context,
                icon:
                    Image.asset("Assets/images/sessionIcon.png", width: 8.0.w),
                circleRadius: 6.0.w, func: () {
              Navigator.pop(context);
              setState(() async {
                CourseDataRepository courseDataRepository = GetIt.I.get();
                ClassDataRepository classDataRepository = GetIt.I.get();
                var res = await classDataRepository.getAllClassLevel();
                var resCourse = await courseDataRepository.getAllCourse();
                var prefs = await SharedPreferences.getInstance();
                var res1 = prefs.getString("token");
                print(res1);
                print(resCourse[0].toMap().toString());
                _currentIndex = 0;
              });
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "SESIONES",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            buttonRounded(context,
                icon: Image.asset("Assets/images/reportIcon.png", width: 7.0.w),
                circleRadius: 6.0.w, func: () {
              Get.to(Reports(
                drawerMenu: true,
              ));
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "REPORTES",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/reportIcon.png", width: 7.5.w),
            //     circleRadius: 6.0.w, func: () async {
            //   String level;
            //   CourseDataRepository courseDataRepository = GetIt.I.get();
            //   var course = await courseDataRepository.getAllCourse();
            //   if (course.isNotEmpty) {
            //     setState(() {
            //       level = course[0].number;
            //     });
            //   }
            //   await DownloadData().downloadAll(context, level);
            //   // await DownloadData().getHttp(context, level);
            //   setState(() {
            //     _currentIndex = 0;
            //   });
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "      DESCARGAR DATOS",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            buttonRounded(context,
                icon: Image.asset("Assets/images/evidenciaIcon.png",
                    width: 8.0.w),
                circleRadius: 6.0.w, func: () {
              goToAllEvidences();
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "EVIDENCIAS",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/shopIcon.png", width: 9.0.w),
            //     circleRadius: 7.0.w, func: () {
            //   Navigator.pop(context);
            //   setState(() {
            //     _currentIndex = 2;
            //   });
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "TIENDA",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/settingsIcon.png", width: 9.0.w),
            //     circleRadius: 7.0.w, func: () {
            //   goToSettingsPage("user");
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "AJUSTES",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            InkWell(
              onTap: () {
                closeSession();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0.w,
                    height: 8.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Colors.white, width: 3)),
                    child: Center(
                      child: Text(
                        "CERRAR SESIÓN",
                        style: TextStyle(color: Colors.white, fontSize: 6.5.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0.h,
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // InkWell(
                //   onTap: () async {
                //     var dio = Dio();
                //     OfflineRepository offlineRepository = GetIt.I.get();
                //     print("Download Data");
                //   },
                //   child: CircleAvatar(
                //     backgroundColor: Colors.white,
                //     radius: 9.0.w,
                //     child: CircleAvatar(
                //       radius: 8.0.w,
                //       backgroundColor: blue,
                //       child: Center(
                //         child: Icon(
                //           Icons.file_download,
                //           color: Colors.white,
                //           size: 15.0.w,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                InkWell(
                  onTap: () async {
                    var dio = Dio();
                    OfflineRepository offlineRepository = GetIt.I.get();
                    var res = await offlineRepository.getAll();
                    dev.log(res.toString());
                    print("UploadData");
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 9.0.w,
                    child: CircleAvatar(
                      radius: 8.0.w,
                      backgroundColor: blue,
                      child: Center(
                        child: Icon(
                          Icons.file_upload,
                          color: Colors.white,
                          size: 15.0.w,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 5.0.h,
            ),
            Text(
              "Versión: 1.0.7",
              style: TextStyle(color: Colors.white, fontSize: 5.0.w),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
