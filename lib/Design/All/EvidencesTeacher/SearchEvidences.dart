import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/UrlServer.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
import '../../Widgets/Toast.dart';
import '../../Widgets/Loading.dart' as load;
import '../../../Utils/ConnectionState.dart';

class SearchEvidences extends StatefulWidget {
  final String idCollege;
  final bool isFull;
  SearchEvidences({this.idCollege, this.isFull});
  @override
  _SearchEvidencesState createState() => _SearchEvidencesState();
}

class _SearchEvidencesState extends State<SearchEvidences> {
  String school;
  Map grade;
  bool loading = false;
  List colleges = [];
  List courses = [];
  TextEditingController rut = TextEditingController();

  getData() async {
    var dio = Dio();
    setState(() {
      loading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var resProfessorData =
        await dio.get("$urlServer/api/mobile/user/course?token=$token");
    for (var i = 0; i < resProfessorData.data.length; i++) {
      log(resProfessorData.data[i].toString());
      if (colleges
          .toString()
          .contains(resProfessorData.data[i]["college"]["_id"].toString())) {
        print("Ya existe");
      } else {
        colleges.add({
          "_id": resProfessorData.data[i]["college"]["_id"],
          "name": resProfessorData.data[i]["college"]["name"]
        });
      }
    }

    for (var i = 0; i < resProfessorData.data.length; i++) {
      courses.add({
        "_id": resProfessorData.data[i]["_id"],
        "name": resProfessorData.data[i]["number"] +
            "° " +
            resProfessorData.data[i]["letter"],
        "students": resProfessorData.data[i]["students"]
      });
    }

    print(courses.toList().toString());
    for (var i = 0; i < colleges.length; i++) {
      if (colleges[i]["_id"] == widget.idCollege) {
        setState(() {
          school = colleges[i]["name"].toString().toUpperCase();
        });
      }
    }
    setState(() {
      loading = false;
    });
  }

  searchData() async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    String idStudent;
    var dio = Dio();
    if (hasInternet) {
      try {
        load.loading(context,
            content: Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              "Buscando datos de alumno...",
              textAlign: TextAlign.center,
            ));
        for (var i = 0; i < courses.length; i++) {
          for (var j = 0; j < courses[i]["students"].length; j++) {
            print(courses[i]["students"][j]["rut"]);
            if (courses[i]["students"][j]["rut"] == rut.text &&
                courses[i]["_id"] == grade["_id"]) {
              print(courses[i]["students"][j]["rut"].toString());
              setState(() {
                idStudent = courses[i]["students"][j]["_id"];
              });
            }
          }
        }
        print(idStudent);
        if (idStudent == null) {
          toast(context, "El alumno buscado no corresponde al curso.", red);
          Navigator.pop(context);
        } else {
          var data = {"student": idStudent, "course": grade["_id"]};
          print(data.toString());
          var prefs = await SharedPreferences.getInstance();
          var token = prefs.getString("token");
          var res = await dio.post(
              "$urlServer/api/mobile/studentEvidences?token=$token",
              data: data);
          print(res.data.toString());
          Navigator.pop(context);
          if (res.data.length == 0) {
            toast(context, "Este alumno aún no tiene evidencias creadas", red);
          } else {
            goToMenuEvidences(res.data);
          }
        }
      } catch (e) {
        Navigator.pop(context);
        toast(context, "Ha ocurrido un error, inténtalo más tarde", red);
        log(e.toString());
      }
    } else {
      toast(context, "Debes contar con conexión a internet.", red);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              // goToMenuEvidences();
              searchData();
            }, text: "   CONTINUAR")
          ],
        ),
      ),
      appBar: widget.isFull
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  FittedBox(fit: BoxFit.fitWidth, child: Text("EVIDENCIAS")),
                ],
              ),
              backgroundColor: cyan,
              elevation: 0,
              centerTitle: true,
            )
          : null,
      body: loading
          ? Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            )
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: Column(
                children: [
                  SizedBox(
                    height: 10.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Center(
                          child: Text(
                            "EVIDENCIA ALUMNO",
                            style: TextStyle(color: blue, fontSize: 6.5.w),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        width: 80.0.w,
                        height: 6.0.h,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("COLEGIO",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.0.w)),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            child: Center(
                                child: Text(
                              "$school",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 5.0.w),
                            )),
                            width: 80.0.w,
                            height: 6.0.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("CURSO",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.0.w)),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            child: Center(
                              child: DropdownButton<dynamic>(
                                iconEnabledColor: Colors.white,
                                underline: SizedBox.shrink(),
                                hint: grade == null
                                    ? Text(
                                        "Selecciona tu curso",
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : Text(
                                        grade["name"].toString().toUpperCase(),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                items: courses.map((dynamic value) {
                                  return DropdownMenuItem<dynamic>(
                                    value: value,
                                    child: Text(
                                      value["name"].toString().toUpperCase(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  );
                                }).toList(),
                                onChanged: (val) {
                                  setState(() {
                                    grade = val;
                                  });
                                },
                              ),
                            ),
                            width: 80.0.w,
                            height: 6.0.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text("RUT ALUMNO",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 7.0.w)),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Container(
                            child: Center(
                              child: TextField(
                                controller: rut,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 6.0.w),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Rut sin puntos ni guión",
                                    hintStyle: TextStyle(
                                        color: Colors.white, fontSize: 5.5.w)),
                              ),
                            ),
                            width: 80.0.w,
                            height: 6.0.h,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
    );
  }
}
