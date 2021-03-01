import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class AssignCreatedClass extends StatefulWidget {
  @override
  _AssignCreatedClassState createState() => _AssignCreatedClassState();
}

class _AssignCreatedClassState extends State<AssignCreatedClass> {
  List selected = [];
  List selectedUsers = [];

  List grade = [
    {"id": 1, "name": "Primero A", "add": false},
    {"id": 2, "name": "Primero B", "add": false},
    {"id": 3, "name": "Primero C", "add": false},
    {"id": 4, "name": "Primero D", "add": false},
    {"id": 5, "name": "Primero E", "add": false},
  ];

  List users = [
    {"id": 1, "name": "Alumno 1", "add": false},
    {"id": 2, "name": "Alumno 2", "add": false},
    {"id": 3, "name": "Alumno 3", "add": false},
    {"id": 4, "name": "Alumno 4", "add": false},
    {"id": 5, "name": "Alumno 5", "add": false},
    {"id": 6, "name": "Alumno 6", "add": false},
    {"id": 7, "name": "Alumno 7", "add": false},
    {"id": 8, "name": "Alumno 8", "add": false},
    {"id": 9, "name": "Alumno 9", "add": false},
    {"id": 10, "name": "Alumno 10", "add": false},
    {"id": 11, "name": "Alumno 11", "add": false},
    {"id": 12, "name": "Alumno 12", "add": false},
    {"id": 13, "name": "Alumno 13", "add": false},
  ];

  @override
  void initState() {
    super.initState();
    selected.clear();
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
              goToMessageUploadData();
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
      body: Column(
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
                    style: TextStyle(color: Colors.white, fontSize: 7.0.w),
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
                                            selected[index]["name"]
                                                .toString()
                                                .toUpperCase(),
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    ),
                                    onPressed: () {},
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
                                // return Container(
                                //   width: 100,
                                //   color: green,
                                //   height: 4.0.h,
                                //                                   child: Chip(
                                //   materialTapTargetSize:
                                //       MaterialTapTargetSize.shrinkWrap,
                                //   deleteIcon: Icon(Icons.close),
                                //   deleteIconColor: Colors.white,
                                //   onDeleted: () {
                                //     selected.removeAt(index);
                                //     setState(() {});
                                //   },
                                //   backgroundColor: green,
                                //   label: Text(
                                //     selected[index]["name"],
                                //     style: TextStyle(color: Colors.white),
                                //   ),
                                // ),
                                // );
                              },
                              itemCount: selected.length,
                            ),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
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
                    style: TextStyle(color: Colors.white, fontSize: 7.0.w),
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
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    ),
                  )
                ],
              )
            ],
          )
        ],
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
                                          grade[index]["name"],
                                          style: TextStyle(
                                              color: blue, fontSize: 6.0.w),
                                        ),
                                        SizedBox(
                                          width: 19.0.w,
                                        ),
                                        InkWell(
                                            onTap: () {
                                              print("A");
                                              setState(() {
                                                grade[index]["add"] =
                                                    !grade[index]["add"];
                                              });
                                              print(grade[index]["add"]);
                                            },
                                            child: CircleAvatar(
                                              child: Center(
                                                child: grade[index]["add"]
                                                    ? Icon(
                                                        Icons.check,
                                                        color: blue,
                                                        size: 12.0.w,
                                                      )
                                                    : SizedBox.shrink(),
                                              ),
                                              backgroundColor: grade[index]
                                                      ["add"]
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

                                // CheckboxListTile(
                                //   checkColor: Colors.white,
                                //   activeColor: green,
                                //   value: grade[index]["add"],
                                //   onChanged: (value) {
                                //     setState(() {
                                //       grade[index]["add"] = value;
                                //     });
                                //   },
                                //   title: Text(
                                //     grade[index]["name"].toString().toUpperCase(),
                                //     style: TextStyle(
                                //         color: grade[index]["add"]
                                //             ? green
                                //             : Colors.white),
                                //   ),
                                // );
                              },
                              itemCount: grade.length,
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
                                    for (var i = 0; i < grade.length; i++) {
                                      if (grade[i]["add"]) {
                                        selected.add(grade[i]);
                                      } else {
                                        print("nada");
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
                                    left: 20.0, right: 20, bottom: 10),
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
                                            setState(() {
                                              users[index]["add"] =
                                                  !users[index]["add"];
                                            });
                                            print(users[index]["add"]);
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
                              // return CheckboxListTile(
                              //   checkColor: Colors.white,
                              //   activeColor: green,
                              //   value: users[index]["add"],
                              //   onChanged: (value) {
                              //     setState(() {
                              //       users[index]["add"] = value;
                              //     });
                              //   },
                              //   title: Text(
                              //     users[index]["name"].toString().toUpperCase(),
                              //     style: TextStyle(
                              //         color: users[index]["add"]
                              //             ? green
                              //             : Colors.white),
                              //   ),
                              // );
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
                                  selectedUsers.clear();
                                  for (var i = 0; i < users.length; i++) {
                                    if (users[i]["add"]) {
                                      selectedUsers.add(users[i]);
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
