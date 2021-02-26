import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class TeacherSelectCollege extends StatefulWidget {
  @override
  _TeacherSelectCollegeState createState() => _TeacherSelectCollegeState();
}

class _TeacherSelectCollegeState extends State<TeacherSelectCollege> {
  String collegeSelected;
  List colleges = [];
  bool loading = false;

  @override
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
              loading == false
                  ? toast(context, "Debes seleccionar un colegio.", red)
                  : goToHome("teacher");
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
                    Container(
                      width: 80.0.w,
                      height: 50.0.h,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              for (var i = 0; i < colleges.length; i++) {
                                if (index != i) {
                                  setState(() {
                                    colleges[i].selected = false;
                                  });
                                } else {
                                  setState(() {
                                    colleges[index].selected = true;
                                  });
                                }
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              width: 75.0.w,
                              height: 8.0.h,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(colleges[index].name),
                                    CircleAvatar(
                                      backgroundColor: colleges[index].selected
                                          ? Colors.white
                                          : blue,
                                      radius: 2.0.w,
                                      child: Center(
                                          child: colleges[index].selected
                                              ? Icon(
                                                  Icons.check,
                                                  color: blue,
                                                )
                                              : SizedBox.shrink()),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: colleges.length,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                ),
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
        Response response = await dio.get("path/$teacherId");
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
