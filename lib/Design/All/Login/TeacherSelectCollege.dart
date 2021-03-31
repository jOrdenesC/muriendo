import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import '../HomePage/HomePageTeacher.dart';
import 'dart:developer';

class TeacherSelectCollege extends StatefulWidget {
  @override
  _TeacherSelectCollegeState createState() => _TeacherSelectCollegeState();
}

class _TeacherSelectCollegeState extends State<TeacherSelectCollege> {
  Map collegeSelected;
  List colleges = [];
  bool loading = false;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var resProfessorData =
        await dio.get("$urlServer/api/mobile/user/course?token=$token");
    log(resProfessorData.data.toString());
    for (var i = 0; i < resProfessorData.data.length; i++) {
      print(resProfessorData.data[i].toString());
      if (colleges
          .toString()
          .contains(resProfessorData.data[i]["college"]["_id"].toString())) {
        print("Ya existe");
      } else {
        colleges.add({
          "_id": resProfessorData.data[i]["college"]["_id"],
          "name": resProfessorData.data[i]["college"]["name"],
          "selected": false
        });
      }
    }
    print(colleges.toList().toString());
    
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blue,
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              loading == true
                  ? toast(context, "Debes seleccionar un colegio.", red)
                  : collegeSelected.isNotEmpty && loading == false
                      ? Get.to(HomePageTeacher(
                          nameCollege: collegeSelected["name"],
                          classId: collegeSelected["_id"],
                        ))

                      // goToHome("teacher", collegeSelected)
                      : toast(context, "Debes seleccionar un colegio.", red);
            }, text: "   CONTINUAR")
          ],
        ),
      ),
      body: loading
          ? Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 25.0.h,
                fit: BoxFit.contain,
              ),
            )
          : Column(
              children: [
                SizedBox(height: 9.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      width: 80.0.w,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Posees más de un colegio asignado. \n\n¿A cuál deseas ingresar?",
                          style: TextStyle(color: blue, fontSize: 6.0.w),
                          textAlign: TextAlign.center,
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                Container(
                  width: 80.0.w,
                  height: 50.0.h,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              for (var i = 0; i < colleges.length; i++) {
                                if (index != i) {
                                  setState(() {
                                    colleges[i]["selected"] = false;
                                  });
                                } else {
                                  setState(() {
                                    colleges[index]["selected"] = true;
                                    collegeSelected = colleges[i];
                                    print(collegeSelected);
                                  });
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: colleges[index]["selected"]
                                      ? green
                                      : Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              width: 75.0.w,
                              height: 8.0.h,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${colleges[index]["name"]}"
                                            .toUpperCase(),
                                        style: TextStyle(
                                            color: colleges[index]["selected"]
                                                ? Colors.white
                                                : blue,
                                            fontSize: 7.0.w),
                                      ),
                                      CircleAvatar(
                                        backgroundColor: colleges[index]
                                                ["selected"]
                                            ? Colors.white
                                            : blue,
                                        radius: 5.0.w,
                                        child: Center(
                                            child: colleges[index]["selected"]
                                                ? Icon(
                                                    Icons.check,
                                                    color: blue,
                                                    size: 8.0.w,
                                                  )
                                                : SizedBox.shrink()),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          )
                        ],
                      );
                    },
                    itemCount: colleges.length,
                  ),
                )
              ],
            ),
    );
  }

  getColleges() async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    var prefs = await SharedPreferences.getInstance();
    String teacherId = prefs.getString("userId");
    if (hasInternet) {
      var dio = Dio();
      try {
        var response = await dio.get("path/$teacherId");
        if (response.statusCode == 200) {
          for (var i = 0; i < response.data.length; i++) {
            colleges.add({"name": response.data[i].name, "selected": false});
          }
        }
      } catch (e) {
        toast(context, "Ha ocurrido un error, inténtalo más tarde.", red);
      }
    } else {
      toast(
          context,
          "Necesitas tener una conexión estable a internet. Por favor conéctate a una red e inténtalo nuevamente.",
          red);
    }
  }
}
