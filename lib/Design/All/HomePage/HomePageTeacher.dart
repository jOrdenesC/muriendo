import 'dart:math';
import 'package:flutter/services.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Design/All/Cycles/Cycles.dart';
import 'package:movitronia/Design/All/EvidencesTeacher/SearchEvidences.dart';
import 'package:movitronia/Design/All/Support/Support.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class HomePageTeacher extends StatefulWidget {
  @override
  _HomePageTeacherState createState() => _HomePageTeacherState();
}

class _HomePageTeacherState extends State<HomePageTeacher> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  List<Widget> _screens = [];
  int count = 0;

  @override
  void initState() {
    super.initState();
    _screens.add(Cycles());
    _screens.add(SearchEvidences());
    _screens.add(Support());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(),
        backgroundColor: blue,
        key: _scaffoldKey,
        drawer: _drawerTeacher(),
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
                        ? "CICLOS"
                        : _currentIndex == 1
                            ? "EVIDENCIAS"
                            : _currentIndex == 2
                                ? "SOPORTE"
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -1.0.w),
                    angle: pi * 0.5,
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
                  width: 20.0.w,
                ),
                Text("CICLOS", style: TextStyle(color: blue, fontSize: 4.0.w))
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
                  width: 20.0.w,
                ),
                Text("EVIDENCIAS",
                    style: TextStyle(color: blue, fontSize: 4.0.w))
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
                  "Assets/images/buttonShop.png",
                  width: 20.0.w,
                ),
                Text("SOPORTE", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: cyan),
    );
  }

  Widget _drawerTeacher() {
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: 100.0.w,
      height: h,
      decoration: BoxDecoration(
        color: blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Text(
            "MENÚ",
            style: TextStyle(color: Colors.white, fontSize: 10.0.w),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          buttonRounded(context,
              icon: Image.asset("Assets/images/sessionIcon.png", width: 9.0.w),
              circleRadius: 7.0.w, func: () {
            Navigator.pop(context);
            setState(() {
              _currentIndex = 0;
            });
          },
              height: 8.0.h,
              width: 80.0.w,
              textStyle: TextStyle(color: blue, fontSize: 6.0.w),
              text: "CICLOS",
              circleColor: blue,
              backgroudColor: Colors.white),
          SizedBox(
            height: 2.0.h,
          ),
          buttonRounded(context,
              icon: Image.asset("Assets/images/reportIcon.png", width: 8.0.w),
              circleRadius: 7.0.w,
              func: () {},
              height: 8.0.h,
              width: 80.0.w,
              textStyle: TextStyle(color: blue, fontSize: 6.0.w),
              text: "    CLASES PROPIAS",
              circleColor: blue,
              backgroudColor: Colors.white),
          SizedBox(
            height: 2.0.h,
          ),
          buttonRounded(context,
              icon:
                  Image.asset("Assets/images/evidenciaIcon.png", width: 9.0.w),
              circleRadius: 7.0.w, func: () {
            goToSearchEvidences(true);
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
          buttonRounded(context,
              icon: Image.asset("Assets/images/shopIcon.png", width: 9.0.w),
              circleRadius: 7.0.w, func: () {
            goToManuals(true);
          },
              height: 8.0.h,
              width: 80.0.w,
              textStyle: TextStyle(color: blue, fontSize: 6.0.w),
              text: "MANUALES",
              circleColor: blue,
              backgroudColor: Colors.white),
          SizedBox(
            height: 2.0.h,
          ),
          buttonRounded(context,
              icon: Image.asset("Assets/images/settingsIcon.png", width: 9.0.w),
              circleRadius: 7.0.w, func: () {
            goToSupport(true);
          },
              height: 8.0.h,
              width: 80.0.w,
              textStyle: TextStyle(color: blue, fontSize: 6.0.w),
              text: "SOPORTE",
              circleColor: blue,
              backgroudColor: Colors.white),
          SizedBox(
            height: 2.0.h,
          ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 9.0.w,
                  child: CircleAvatar(
                    radius: 8.0.w,
                    backgroundColor: blue,
                    child: Center(
                      child: Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 15.0.w,
                      ),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
