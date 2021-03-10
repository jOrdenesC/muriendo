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

class ShowPhases extends StatefulWidget {
  @override
  _ShowPhasesState createState() => _ShowPhasesState();
}

class _ShowPhasesState extends State<ShowPhases> {
  double currentindex = 0;
  bool isDefault;
  String title;
  dynamic arguments;
  String level;
  int numberClass = 0;
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
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    setState(() {
      title = args["title"];
      arguments = args;
      isDefault = args["isDefault"];
      level = args["level"];
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
        body: Column(
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
                              style: TextStyle(color: blue, fontSize: 5.5.w),
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

              print("numberClass CLAAAAAAAS $numberClass");

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
              goToPlanification(null, index, true, dataClass, null);
            } else {
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
              goToCreateClass(level.toString(), numberClass.toString());
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: blue,
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
              circleRadius: 6.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 12.0.w,
              ))),
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

              print("numberClass CLAAAAAAAS $numberClass");

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
              goToPlanification(null, index, true, dataClass, null);
            } else {
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

              goToCreateClass(arguments["level"], numberClass.toString());
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
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
              circleRadius: 6.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 12.0.w,
              ))),
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

              print("numberClass CLAAAAAAAS $numberClass");

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
              goToPlanification(null, index, true, dataClass, null);
            } else {
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
              goToCreateClass(arguments["level"], numberClass.toString());
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
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
              circleRadius: 6.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 12.0.w,
              ))),
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

              print("numberClass CLAAAAAAASs $numberClass");

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
              goToPlanification(null, index, true, dataClass, null);
            } else {
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
              goToCreateClass(arguments["level"], numberClass.toString());
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
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
              circleRadius: 6.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 12.0.w,
              ))),
        ),
        SizedBox(height: 3.0.h),
      ],
    );
  }
}
