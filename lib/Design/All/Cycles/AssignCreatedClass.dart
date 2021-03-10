import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/UrlServer.dart';
import 'dart:developer';
import 'package:orientation_helper/orientation_helper.dart';
import '../../Widgets/Loading.dart';

class AssignCreatedClass extends StatefulWidget {
  @override
  _AssignCreatedClassState createState() => _AssignCreatedClassState();
}

class _AssignCreatedClassState extends State<AssignCreatedClass> {
  List selected = [];
  List selectedUsers = [];
  bool loaded = true;

  List grade = [];

  List users = [];

  List courses = [];

  var args;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        args =
            (ModalRoute.of(context).settings.arguments as RouteArguments).args;
      });
      log(args.toString());
      selected.clear();
      getDataUsers();
    });
  }

  getDataUsers() async {
    print("LEVELLLL ${args['level']}");
    setState(() {
      loaded = false;
    });
    var dio = Dio();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    Response response =
        await dio.get("$urlServer/api/mobile/user/course?token=$token");
    for (var i = 0; i < response.data.length; i++) {
      if (response.data[i]["number"] == args["level"]) {
        setState(() {
          courses.add(response.data[i]);
          grade.add({
            "name": response.data[i]["number"] + response.data[i]["letter"],
            "id": response.data[i]["_id"],
            "students": response.data[i]["students"],
            "status": false
          });
        });
      } else {
        print("no sirve");
      }
    }

    log(courses.length.toString());

    for (var i = 0; i < courses.length; i++) {
      for (var j = 0; j < courses[i]["students"].length; j++) {
        print("entra a if");
        setState(() {
          users.add({
            "add": false,
            "_id": courses[i]["students"][j]["_id"],
            "name": courses[i]["students"][j]["name"]
          });
        });
      }
    }
    log(courses.toString());
    log(users.toString());
    setState(() {
      loaded = true;
    });
  }

  sendData() async {
    List exercisesCalentamiento = [];
    List exercisesFlexibilidad = [];
    List exercisesDesarrollo = [];
    List exercisesVueltaCalma = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var maxCal = prefs.getInt("maxTotalCalentamiento");
    var maxFle = prefs.getInt("maxTotalFlexibilidad");
    var maxDes = prefs.getInt("maxTotalDesarrollo");
    var maxVue = prefs.getInt("maxTotalVueltaCalma");
    var exercisesCal = prefs.getStringList("exercisesCalentamiento");
    var exercisesFle = prefs.getStringList("exercisesFlexibilidad");
    var exercisesDes = prefs.getStringList("exercisesDesarrollo");
    var exercisesVue = prefs.getStringList("exercisesVueltaCalma");

    for (var i = 0; i < maxCal; i++) {
      if (exercisesCalentamiento.length != maxCal) {
        for (var j = 0; j < exercisesCal.length; j++) {
          setState(() {
            exercisesCalentamiento.add(exercisesCal[j]);
          });
        }
      }
    }

    for (var i = 0; i < maxFle; i++) {
      if (exercisesFlexibilidad.length != maxFle) {
        for (var j = 0; j < exercisesFle.length; j++) {
          setState(() {
            exercisesFlexibilidad.add(exercisesFle[j]);
          });
        }
      }
    }

    for (var i = 0; i < maxDes; i++) {
      if (exercisesDesarrollo.length != maxDes) {
        for (var j = 0; j < exercisesDes.length; j++) {
          setState(() {
            exercisesDesarrollo.add(exercisesDes[j]);
          });
        }
      }
    }

    for (var i = 0; i < maxVue; i++) {
      if (exercisesVueltaCalma.length != maxVue) {
        for (var j = 0; j < exercisesVue.length; j++) {
          setState(() {
            exercisesVueltaCalma.add(exercisesVue[j]);
          });
        }
      }
    }

    loading(context,
        content: Center(
          child: Image.asset(
            "Assets/videos/loading.gif",
            width: 70.0.w,
            height: 15.0.h,
            fit: BoxFit.contain,
          ),
        ),
        title: Text(
          "Enviando clase creada...",
          textAlign: TextAlign.center,
        ));

    var dio = Dio();
    try {
      var data = {
        "students": selectedUsers,
        "originalClass": args["response"].data["_id"],
        "number": args["number"],
        "level": args["level"],
        "exercisesCalentamiento": exercisesCalentamiento,
        "exercisesFlexibilidad": exercisesFlexibilidad,
        "exercisesDesarrollo": exercisesDesarrollo,
        "exercisesVueltaCalma": exercisesVueltaCalma,
        "times": args["response"].data["times"],
        "questionnaire": args["response"].data["questionnaire"],
        "tips": args["response"].data["tips"],
        "pauses": args["response"].data["pauses"],
        // "course":
      };
      Response response = await dio
          .post("$urlServer/api/mobile/customClass?token=$token", data: data);
      print(response.data);
    } catch (e) {
      log(e.response.toString());
    }
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
              // goToMessageUploadData();
              sendData();
              // log(args["response"].data["_id"].toString());
              // log(args["response"].toString());
            }, text: "   ENVIAR")
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text("CLASE CREADA")),
          ],
        ),
        elevation: 0,
        backgroundColor: cyan,
        centerTitle: true,
      ),
      body: loaded
          ? Column(
              children: [
                SizedBox(
                  height: selected.isEmpty ? 25.0.h : 10.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.0.w,
                      height: 5.0.h,
                      child: Center(
                          child: Text(
                        "CLASE CREADA",
                        style: TextStyle(color: blue, fontSize: 6.0.w),
                      )),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "ENVIAR AL CURSO",
                          style:
                              TextStyle(color: Colors.white, fontSize: 7.0.w),
                        ),
                        Text(""),
                        InkWell(
                          onTap: () {
                            addGrade();
                          },
                          child: Container(
                            width: 80.0.w,
                            height: selected.isEmpty ? 5.0.h : 25.0.h,
                            child: selected.isEmpty
                                ? Center(
                                    child: Text(
                                    "Oprime aquí para agregar cursos",
                                    style: TextStyle(color: Colors.white),
                                  ))
                                : ListView.builder(
                                    physics: ScrollPhysics(
                                        parent: BouncingScrollPhysics()),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20),
                                        child: RaisedButton.icon(
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))),
                                          color: green,
                                          icon: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SizedBox(width: 12.0.w),
                                              Text(
                                                  selected[index]
                                                      .toString()
                                                      .toUpperCase(),
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                            ],
                                          ),
                                          onPressed: () {
                                            print("remove");
                                            selected.removeAt(index);
                                            setState(() {
                                              grade[index]["status"] = false;
                                            });
                                            print(grade.toString());
                                          },
                                          label: Expanded(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                Icon(
                                                  Icons.close_sharp,
                                                  color: Colors.white,
                                                  size: 10.0.w,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: selected.length,
                                  ),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 6.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          "ENVIAR A ALUMNO",
                          style:
                              TextStyle(color: Colors.white, fontSize: 7.0.w),
                        ),
                        Text(""),
                        InkWell(
                          onTap: () {
                            addUsers();
                          },
                          child: Container(
                            width: 80.0.w,
                            height: 5.0.h,
                            child: selectedUsers.isEmpty
                                ? Center(
                                    child: Text(
                                    "Oprime aquí para agregar alumnos",
                                    style: TextStyle(color: Colors.white),
                                  ))
                                : Center(
                                    child: Text(
                                      "Seleccionaste ${selectedUsers.length} alumnos.",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                            decoration: BoxDecoration(
                                color: selectedUsers.isEmpty
                                    ? Colors.transparent
                                    : green,
                                border: Border.all(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            )
          : Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            ),
    );
  }

  addGrade() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox.expand(
                    child: Container(
                      color: blue,
                      child: Column(
                        children: [
                          Container(
                            height: 8.0.h,
                            width: 100.0.w,
                            color: cyan,
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 10.0.w,
                                      ),
                                      onPressed: () => Navigator.pop(context)),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 6.0.w),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: blue,
                            child: SizedBox(
                              height: 5.0.h,
                            ),
                          ),
                          Text(
                            "SUBCICLOS",
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.0.h,
                          ),
                          Container(
                            height: 65.0.h,
                            width: 80.0.w,
                            color: blue,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 15.0.w,
                                        ),
                                        Text(
                                          grade[index]["name"]
                                              .toString()
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: blue, fontSize: 6.0.w),
                                        ),
                                        SizedBox(
                                          width: 19.0.w,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                grade[index]["status"] =
                                                    !grade[index]["status"];
                                              });
                                              print(grade.toString());
                                            },
                                            child: CircleAvatar(
                                              child: Center(
                                                child: grade[index]["status"]
                                                    ? Icon(
                                                        Icons.check,
                                                        color: blue,
                                                        size: 12.0.w,
                                                      )
                                                    : SizedBox.shrink(),
                                              ),
                                              backgroundColor: grade[index]
                                                      ["status"]
                                                  ? green
                                                  : blue,
                                              radius: 7.0.w,
                                            ))
                                      ],
                                    ),
                                    width: 80.0.w,
                                    height: 8.0.h,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(50))),
                                  ),
                                );
                              },
                              itemCount: courses.length,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 12.0.h,
                              color: cyan,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  buttonRounded(context, text: "AGREGAR",
                                      func: () {
                                    selected.clear();
                                    print(grade.toString());
                                    for (var i = 0; i < grade.length; i++) {
                                      if (grade[i]["status"]) {
                                        selected.add(grade[i]["name"]);
                                        for (var k = 0;
                                            k < grade[i]["students"].length;
                                            k++) {
                                          if (selectedUsers.contains(
                                              grade[i]["students"][k]["_id"])) {
                                            print("ya existe");
                                          } else {
                                            selectedUsers.add(
                                                grade[i]["students"][k]["_id"]);
                                          }
                                        }
                                      } else {
                                        print("nada");
                                      }
                                    }
                                    for (var i = 0; i < users.length; i++) {
                                      for (var j = 0;
                                          j < selectedUsers.length;
                                          j++) {
                                        if (users[i]["_id"] ==
                                            selectedUsers[j]) {
                                          users[i]["add"] = true;
                                        }
                                      }
                                    }
                                    print(selected);
                                    Navigator.pop(context);
                                    refresh();
                                  })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  addUsers() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox.expand(
                    child: Column(
                      children: [
                        Container(
                          height: 8.0.h,
                          width: 100.0.w,
                          color: cyan,
                          child: Center(
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                      size: 12.0.w,
                                    ),
                                    onPressed: () => Navigator.pop(context)),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      "  LISTADO DE ALUMNOS",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 6.0.w),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 77.0.h,
                          width: 100.0.w,
                          color: blue,
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20, bottom: 10, top: 10),
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: 15.0.w,
                                      ),
                                      Text(
                                        users[index]["name"],
                                        style: TextStyle(
                                            color: users[index]["add"]
                                                ? Colors.white
                                                : blue,
                                            fontSize: 5.0.w),
                                      ),
                                      SizedBox(
                                        width: 19.0.w,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            print("A");
                                            for (var i = 0;
                                                i < users.length;
                                                i++) {
                                              for (var j = 0;
                                                  j < selectedUsers.length;
                                                  j++) {
                                                if (users[i]["_id"] ==
                                                    selectedUsers[j]) {
                                                  setState(() {
                                                    users[index]["add"] =
                                                        !users[index]["add"];
                                                    if (users[index]["add"] ==
                                                        false) {
                                                      selectedUsers
                                                          .removeAt(index);
                                                    }
                                                  });
                                                }
                                              }
                                            }
                                          },
                                          child: CircleAvatar(
                                            child: Center(
                                              child: users[index]["add"]
                                                  ? Icon(
                                                      Icons.check,
                                                      color: blue,
                                                      size: 10.0.w,
                                                    )
                                                  : SizedBox.shrink(),
                                            ),
                                            backgroundColor: users[index]["add"]
                                                ? Colors.white
                                                : blue,
                                            radius: 5.5.w,
                                          ))
                                    ],
                                  ),
                                  width: 60.0.w,
                                  height: 6.0.h,
                                  decoration: BoxDecoration(
                                      color: users[index]["add"]
                                          ? green
                                          : Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                ),
                              );
                            },
                            itemCount: users.length,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 12.0.h,
                            color: cyan,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                buttonRounded(context, text: "AGREGAR",
                                    func: () {
                                  for (var i = 0; i < users.length; i++) {
                                    if (users[i]["add"]) {
                                      if (selectedUsers
                                          .contains(users[i]["_id"])) {
                                        print("ya existe");
                                      } else {
                                        selectedUsers.add(users[i]["_id"]);
                                      }
                                    } else {
                                      print("nada");
                                    }
                                  }
                                  print(selectedUsers);
                                  Navigator.pop(context);
                                  refresh();
                                })
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  refresh() {
    setState(() {});
  }
}
