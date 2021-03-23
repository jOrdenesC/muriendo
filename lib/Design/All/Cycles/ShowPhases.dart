import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import '../../Widgets/Loading.dart';
import '../../../Utils/UrlServer.dart';
import '../../../Utils/ConnectionState.dart';
import '../../Widgets/Toast.dart';

class ShowPhases extends StatefulWidget {
  @override
  _ShowPhasesState createState() => _ShowPhasesState();
}

class _ShowPhasesState extends State<ShowPhases> {
  bool loadingData = false;
  double currentindex = 0;
  bool isDefault;
  String title;
  dynamic arguments;
  String level;
  int numberClass = 0;
  List classes = [];
  List classesCourses = [];
  List courses = [];
  List phases = [
    {"numberClass": 1},
    {"numberClass": 2},
    {"numberClass": 3},
    {"numberClass": 4},
    {"numberClass": 5},
    {"numberClass": 6},
    {"numberClass": 7},
    {"numberClass": 8},
    {"numberClass": 9},
    {"numberClass": 10}
  ];
  @override
  void initState() {
    super.initState();
    getDataClasses();
  }

  getDataClasses() async {
    setState(() {
      loadingData = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dio = Dio();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      try {
        var coursesData = [];
        for (var i = 0; i < courses.length; i++) {
          coursesData.add(courses[i]["_id"]);
        }
        Response response = await dio.post(
            "$urlServer/api/mobile/professor/customClasses?token=$token",
            data: coursesData);
        if (response.data.length != 0) {
          for (var i = 0; i < response.data.length; i++) {
            classes.add(response.data[i]);
            classesCourses.add({
              "course": response.data[i]["course"].toString(),
              "number": response.data[i]["number"].toString()
            }.toString());
          }
        }
      } catch (e) {
        print(e);
        toast(context, "Ha ocurrido un error, inténtalo más tarde.", red);
      }
      setState(() {
        loadingData = false;
      });
    } else {
      Navigator.pop(context);
      toast(context, "Debes estar conectado a internet.", red);
    }
  }

  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    setState(() {
      title = args["title"];
      arguments = args;
      isDefault = args["isDefault"];
      level = args["level"];
      courses = args["courses"];
    });
    return Scaffold(
        backgroundColor: args["cycle"] == 1
            ? green
            : args["cycle"] == 2
                ? red
                : yellow,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: cyan,
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(fit: BoxFit.fitWidth, child: Text(args["title"])),
            ],
          ),
          centerTitle: true,
        ),
        body: loadingData
            ? Center(
                child: Image.asset(
                  "Assets/videos/loading.gif",
                  width: 70.0.w,
                  height: 15.0.h,
                  fit: BoxFit.contain,
                ),
              )
            : Column(
                children: [
                  SizedBox(
                    height: 5.0.h,
                  ),
                  arguments["isEvidence"]
                      ? Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "NOMBRE APELLIDO _8° A",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 5.5.w),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    "COLEGIO SANTO TOMAS, CURICO",
                                    style:
                                        TextStyle(color: blue, fontSize: 5.5.w),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                  SizedBox(
                    height: 3.0.h,
                  ),
                  Container(
                    height: 60.0.h,
                    child: PageView.builder(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return phase(phases[index]["numberClass"], isDefault);
                      },
                      itemCount: phases.length,
                      onPageChanged: (index) {
                        setState(() {
                          currentindex = (index).toDouble();
                        });
                      },
                    ),
                  ),
                  DotsIndicator(
                    dotsCount: phases.length,
                    position: currentindex,
                    decorator: DotsDecorator(
                        color: Colors.white,
                        activeColor: blue,
                        size: Size(15, 15),
                        activeSize: Size(20, 20)),
                  )
                ],
              ));
  }

  Widget phase(int index, bool isDefault) {
    return Column(
      children: [
        buttonRounded(context,
            width: 90.0.w,
            text: "FASE",
            textStyle: TextStyle(fontSize: 8.0.w, color: Colors.white),
            height: 9.0.h,
            circleRadius: 6.0.w,
            icon: Center(
                child: Text(
              "$index",
              style: TextStyle(color: blue, fontSize: 8.0.w),
            ))),
        SizedBox(height: 3.0.h),
        InkWell(
            onTap: () async {
              if (isDefault) {
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
                      "Buscando datos...",
                      textAlign: TextAlign.center,
                    ));

                if (index == 1) {
                  setState(() {
                    numberClass = 1;
                  });
                } else if (index == 2) {
                  setState(() {
                    numberClass = 5;
                  });
                } else if (index == 3) {
                  setState(() {
                    numberClass = 9;
                  });
                } else if (index == 4) {
                  setState(() {
                    numberClass = 13;
                  });
                } else if (index == 5) {
                  setState(() {
                    numberClass = 17;
                  });
                } else if (index == 6) {
                  setState(() {
                    numberClass = 21;
                  });
                } else if (index == 7) {
                  setState(() {
                    numberClass = 25;
                  });
                } else if (index == 8) {
                  setState(() {
                    numberClass = 31;
                  });
                } else if (index == 9) {
                  setState(() {
                    numberClass = 33;
                  });
                } else if (index == 9) {
                  setState(() {
                    numberClass = 37;
                  });
                }

                ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
                var prefs = await SharedPreferences.getInstance();
                var token = prefs.getString("token");
                List exerciseCalentamiento = [];
                List exerciseDesarrollo = [];
                List exerciseVueltaCalma = [];
                Response response = await Dio().get(
                    "https://intranet.movitronia.com/api/mobile/class/$level/$numberClass?token=$token");
                for (var i = 0;
                    i < response.data["exercisesCalentamiento"].length;
                    i++) {
                  var exercise = await excerciseDataRepository.getExerciseById(
                      response.data["exercisesCalentamiento"][i]);
                  setState(() {
                    exerciseCalentamiento.add(exercise[0].nameExcercise);
                  });
                }

                for (var i = 0;
                    i < response.data["exercisesFlexibilidad"].length;
                    i++) {
                  var exercise = await excerciseDataRepository.getExerciseById(
                      response.data["exercisesFlexibilidad"][i]);
                  setState(() {
                    exerciseCalentamiento.add(exercise[0].nameExcercise);
                  });
                }

                for (var i = 0;
                    i < response.data["exercisesDesarrollo"].length;
                    i++) {
                  var exercise = await excerciseDataRepository
                      .getExerciseById(response.data["exercisesDesarrollo"][i]);
                  setState(() {
                    exerciseDesarrollo.add(exercise[0].nameExcercise);
                  });
                }

                for (var i = 0;
                    i < response.data["exercisesVueltaCalma"].length;
                    i++) {
                  var exercise = await excerciseDataRepository.getExerciseById(
                      response.data["exercisesVueltaCalma"][i]);
                  setState(() {
                    exerciseVueltaCalma.add(exercise[0].nameExcercise);
                  });
                }

                Navigator.pop(context);
                var dataClass = {
                  "session": numberClass,
                  "exercisesCalentamiento": exerciseCalentamiento,
                  "exercisesDesarrollo": exerciseDesarrollo,
                  "exercisesVueltaCalma": exerciseVueltaCalma
                };
                goToPlanification(null, index, true, dataClass, null, false);
              } else {
                List exists = [];
                if (index == 1) {
                  setState(() {
                    numberClass = 1;
                  });
                } else if (index == 2) {
                  setState(() {
                    numberClass = 5;
                  });
                } else if (index == 3) {
                  setState(() {
                    numberClass = 9;
                  });
                } else if (index == 4) {
                  setState(() {
                    numberClass = 13;
                  });
                } else if (index == 5) {
                  setState(() {
                    numberClass = 17;
                  });
                } else if (index == 6) {
                  setState(() {
                    numberClass = 21;
                  });
                } else if (index == 7) {
                  setState(() {
                    numberClass = 25;
                  });
                } else if (index == 8) {
                  setState(() {
                    numberClass = 31;
                  });
                } else if (index == 9) {
                  setState(() {
                    numberClass = 33;
                  });
                } else if (index == 9) {
                  setState(() {
                    numberClass = 37;
                  });
                }
                for (var i = 0; i < classes.length; i++) {
                  if (classes[i]["number"] == numberClass) {
                    exists.add(classes[i]);
                  }
                }
                if (exists.isNotEmpty) {
                  showCourses(classesCourses, arguments["level"], numberClass);
                } else {
                  goToCreateClass(level.toString(), numberClass.toString(),
                      true, false, null);
                }
              }
            },
            child: buttonRounded(context,
                backgroudColor: Colors.white,
                circleColor: title == "POR DEFECTO"
                    ? blue
                    : arguments["cycle"] == 1
                        ? green
                        : arguments["cycle"] == 2
                            ? red
                            : yellow,
                width: 90.0.w,
                text: index == 1
                    ? "CLASE 1"
                    : index == 2
                        ? "CLASE 5"
                        : index == 3
                            ? "CLASE 9"
                            : index == 4
                                ? "CLASE 13"
                                : index == 5
                                    ? "CLASE  17"
                                    : index == 6
                                        ? "CLASE 21"
                                        : index == 7
                                            ? "CLASE 25"
                                            : index == 8
                                                ? "CLASE 29"
                                                : index == 9
                                                    ? "CLASE 33"
                                                    : index == 10
                                                        ? "CLASE 37"
                                                        : "CLASE",
                textStyle: TextStyle(fontSize: 8.0.w, color: blue),
                height: 9.0.h,
                circleRadius: isDefault ? 6.0.w : 0.0.w,
                icon: isDefault
                    ? Center(
                        child: Icon(
                        Icons.check,
                        color: arguments["cycle"] == 1
                            ? green
                            : arguments["cycle"] == 2
                                ? red
                                : yellow,
                        size: 12.0.w,
                      ))
                    : SizedBox.shrink())),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () async {
            if (isDefault) {
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
                    "Buscando datos...",
                    textAlign: TextAlign.center,
                  ));

              if (index == 1) {
                setState(() {
                  numberClass = 2;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 6;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 10;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 14;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 18;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 22;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 26;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 30;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 34;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 38;
                });
              }

              ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
              var prefs = await SharedPreferences.getInstance();
              var token = prefs.getString("token");
              List exerciseCalentamiento = [];
              List exerciseDesarrollo = [];
              List exerciseVueltaCalma = [];
              Response response = await Dio().get(
                  "https://intranet.movitronia.com/api/mobile/class/$level/$numberClass?token=$token");
              for (var i = 0;
                  i < response.data["exercisesCalentamiento"].length;
                  i++) {
                var exercise = await excerciseDataRepository.getExerciseById(
                    response.data["exercisesCalentamiento"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesFlexibilidad"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesFlexibilidad"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesDesarrollo"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesDesarrollo"][i]);
                setState(() {
                  exerciseDesarrollo.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesVueltaCalma"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesVueltaCalma"][i]);
                setState(() {
                  exerciseVueltaCalma.add(exercise[0].nameExcercise);
                });
              }

              Navigator.pop(context);
              var dataClass = {
                "session": numberClass,
                "exercisesCalentamiento": exerciseCalentamiento,
                "exercisesDesarrollo": exerciseDesarrollo,
                "exercisesVueltaCalma": exerciseVueltaCalma
              };
              goToPlanification(null, index, true, dataClass, null, false);
            } else {
              List exists = [];
              if (index == 1) {
                setState(() {
                  numberClass = 2;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 6;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 10;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 14;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 18;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 22;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 26;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 30;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 34;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 38;
                });
              }
              for (var i = 0; i < classes.length; i++) {
                if (classes[i]["number"] == numberClass) {
                  exists.add(classes[i]);
                }
              }
              if (exists.isNotEmpty) {
                showCourses(classesCourses, arguments["level"], numberClass);
              } else {
                goToCreateClass(level.toString(), numberClass.toString(), true,
                    false, null);
              }
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : arguments["cycle"] == 1
                      ? green
                      : arguments["cycle"] == 2
                          ? red
                          : yellow,
              width: 90.0.w,
              text: index == 1
                  ? "CLASE 2"
                  : index == 2
                      ? "CLASE 6"
                      : index == 3
                          ? "CLASE 10"
                          : index == 4
                              ? "CLASE 14"
                              : index == 5
                                  ? "CLASE  18"
                                  : index == 6
                                      ? "CLASE 22"
                                      : index == 7
                                          ? "CLASE 26"
                                          : index == 8
                                              ? "CLASE 30"
                                              : index == 9
                                                  ? "CLASE 34"
                                                  : index == 10
                                                      ? "CLASE 38"
                                                      : "CLASE",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: isDefault ? 6.0.w : 0.0.w,
              icon: isDefault
                  ? Center(
                      child: Icon(
                      Icons.check,
                      color: arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow,
                      size: 12.0.w,
                    ))
                  : SizedBox.shrink()),
        ),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () async {
            if (isDefault) {
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
                    "Buscando datos...",
                    textAlign: TextAlign.center,
                  ));
              if (index == 1) {
                setState(() {
                  numberClass = 3;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 7;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 11;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 15;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 19;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 23;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 27;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 31;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 35;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 39;
                });
              }

              ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
              var prefs = await SharedPreferences.getInstance();
              var token = prefs.getString("token");
              List exerciseCalentamiento = [];
              List exerciseDesarrollo = [];
              List exerciseVueltaCalma = [];
              Response response = await Dio().get(
                  "https://intranet.movitronia.com/api/mobile/class/$level/$numberClass?token=$token");
              for (var i = 0;
                  i < response.data["exercisesCalentamiento"].length;
                  i++) {
                var exercise = await excerciseDataRepository.getExerciseById(
                    response.data["exercisesCalentamiento"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesFlexibilidad"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesFlexibilidad"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesDesarrollo"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesDesarrollo"][i]);
                setState(() {
                  exerciseDesarrollo.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesVueltaCalma"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesVueltaCalma"][i]);
                setState(() {
                  exerciseVueltaCalma.add(exercise[0].nameExcercise);
                });
              }

              Navigator.pop(context);
              var dataClass = {
                "session": numberClass,
                "exercisesCalentamiento": exerciseCalentamiento,
                "exercisesDesarrollo": exerciseDesarrollo,
                "exercisesVueltaCalma": exerciseVueltaCalma
              };
              goToPlanification(null, index, true, dataClass, null, false);
            } else {
              List exists = [];
              if (index == 1) {
                setState(() {
                  numberClass = 3;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 7;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 11;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 15;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 19;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 23;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 27;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 31;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 35;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 39;
                });
              }
              for (var i = 0; i < classes.length; i++) {
                if (classes[i]["number"] == numberClass) {
                  exists.add(classes[i]);
                }
              }
              if (exists.isNotEmpty) {
                showCourses(classesCourses, arguments["level"], numberClass);
              } else {
                goToCreateClass(level.toString(), numberClass.toString(), true,
                    false, null);
              }
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : arguments["cycle"] == 1
                      ? green
                      : arguments["cycle"] == 2
                          ? red
                          : yellow,
              width: 90.0.w,
              text: index == 1
                  ? "CLASE 3"
                  : index == 2
                      ? "CLASE 7"
                      : index == 3
                          ? "CLASE 11"
                          : index == 4
                              ? "CLASE 15"
                              : index == 5
                                  ? "CLASE  19"
                                  : index == 6
                                      ? "CLASE 23"
                                      : index == 7
                                          ? "CLASE 27"
                                          : index == 8
                                              ? "CLASE 31"
                                              : index == 9
                                                  ? "CLASE 35"
                                                  : index == 10
                                                      ? "CLASE 39"
                                                      : "CLASE",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: isDefault ? 6.0.w : 0.0.w,
              icon: isDefault
                  ? Center(
                      child: Icon(
                      Icons.check,
                      color: arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow,
                      size: 12.0.w,
                    ))
                  : SizedBox.shrink()),
        ),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () async {
            if (isDefault) {
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
                    "Buscando datos...",
                    textAlign: TextAlign.center,
                  ));
              if (index == 1) {
                setState(() {
                  numberClass = 4;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 8;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 12;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 16;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 20;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 24;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 28;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 32;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 36;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 40;
                });
              }

              ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
              var prefs = await SharedPreferences.getInstance();
              var token = prefs.getString("token");
              List exerciseCalentamiento = [];
              List exerciseDesarrollo = [];
              List exerciseVueltaCalma = [];
              Response response = await Dio().get(
                  "https://intranet.movitronia.com/api/mobile/class/$level/$numberClass?token=$token");
              for (var i = 0;
                  i < response.data["exercisesCalentamiento"].length;
                  i++) {
                var exercise = await excerciseDataRepository.getExerciseById(
                    response.data["exercisesCalentamiento"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesFlexibilidad"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesFlexibilidad"][i]);
                setState(() {
                  exerciseCalentamiento.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesDesarrollo"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesDesarrollo"][i]);
                setState(() {
                  exerciseDesarrollo.add(exercise[0].nameExcercise);
                });
              }

              for (var i = 0;
                  i < response.data["exercisesVueltaCalma"].length;
                  i++) {
                var exercise = await excerciseDataRepository
                    .getExerciseById(response.data["exercisesVueltaCalma"][i]);
                setState(() {
                  exerciseVueltaCalma.add(exercise[0].nameExcercise);
                });
              }

              Navigator.pop(context);
              var dataClass = {
                "session": numberClass,
                "exercisesCalentamiento": exerciseCalentamiento,
                "exercisesDesarrollo": exerciseDesarrollo,
                "exercisesVueltaCalma": exerciseVueltaCalma
              };
              goToPlanification(null, index, true, dataClass, null, false);
            } else {
              List exists = [];
              if (index == 1) {
                setState(() {
                  numberClass = 4;
                });
              } else if (index == 2) {
                setState(() {
                  numberClass = 8;
                });
              } else if (index == 3) {
                setState(() {
                  numberClass = 12;
                });
              } else if (index == 4) {
                setState(() {
                  numberClass = 16;
                });
              } else if (index == 5) {
                setState(() {
                  numberClass = 20;
                });
              } else if (index == 6) {
                setState(() {
                  numberClass = 24;
                });
              } else if (index == 7) {
                setState(() {
                  numberClass = 28;
                });
              } else if (index == 8) {
                setState(() {
                  numberClass = 32;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 36;
                });
              } else if (index == 9) {
                setState(() {
                  numberClass = 40;
                });
              }
              for (var i = 0; i < classes.length; i++) {
                if (classes[i]["number"] == numberClass) {
                  exists.add(classes[i]);
                }
              }
              if (exists.isNotEmpty) {
                showCourses(classesCourses, arguments["level"], numberClass);
              } else {
                goToCreateClass(level.toString(), numberClass.toString(), true,
                    false, null);
              }
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : arguments["cycle"] == 1
                      ? green
                      : arguments["cycle"] == 2
                          ? red
                          : yellow,
              width: 90.0.w,
              text: index == 1
                  ? "CLASE 4"
                  : index == 2
                      ? "CLASE 8"
                      : index == 3
                          ? "CLASE 12"
                          : index == 4
                              ? "CLASE 16"
                              : index == 5
                                  ? "CLASE  20"
                                  : index == 6
                                      ? "CLASE 24"
                                      : index == 7
                                          ? "CLASE 28"
                                          : index == 8
                                              ? "CLASE 32"
                                              : index == 9
                                                  ? "CLASE 36"
                                                  : index == 10
                                                      ? "CLASE 40"
                                                      : "CLASE",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: isDefault ? 6.0.w : 0.0.w,
              icon: isDefault
                  ? Center(
                      child: Icon(
                      Icons.check,
                      color: arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow,
                      size: 12.0.w,
                    ))
                  : SizedBox.shrink()),
        ),
        SizedBox(height: 3.0.h),
      ],
    );
  }

  showCourses(List classesCourses, String level, int numberClass) async {
    print(classesCourses.toString());
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
                            "CURSOS ASIGNADOS",
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
                                  padding: const EdgeInsets.only(
                                      bottom: 15.0, left: 10, right: 10),
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        print({
                                          "course": courses[index]["_id"],
                                          "number": numberClass.toString()
                                        });
                                        goToCreateClass(
                                            arguments["level"],
                                            numberClass.toString(),
                                            classesCourses.contains({
                                              "course": courses[index]["_id"],
                                              "number": numberClass.toString()
                                            }.toString())
                                                ? false
                                                : true,
                                            true,
                                            courses[index]["_id"]);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          classesCourses.contains({
                                            "course": courses[index]["_id"],
                                            "number": numberClass.toString()
                                          }.toString())
                                              ? Icon(
                                                  Icons.check,
                                                  color: green,
                                                  size: 10.0.w,
                                                )
                                              : SizedBox.shrink(),
                                          SizedBox(
                                            width: 15.0.w,
                                          ),
                                          Text(
                                            courses[index]["number"] +
                                                courses[index]["letter"]
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
                                                print({
                                                  "course": courses[index]
                                                      ["_id"],
                                                  "number":
                                                      numberClass.toString()
                                                });
                                                goToCreateClass(
                                                    arguments["level"],
                                                    numberClass.toString(),
                                                    classesCourses.contains({
                                                      "course": courses[index]
                                                          ["_id"],
                                                      "number":
                                                          numberClass.toString()
                                                    }.toString())
                                                        ? false
                                                        : true,
                                                    true,
                                                    courses[index]["_id"]);
                                              },
                                              child: Center(
                                                  child: Icon(
                                                Icons.arrow_forward,
                                                color: blue,
                                                size: 12.0.w,
                                              )))
                                        ],
                                      ),
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
}
