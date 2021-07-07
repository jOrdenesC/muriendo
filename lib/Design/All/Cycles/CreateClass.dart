import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Functions/createError.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/retryDio.dart';
import 'package:movitronia/Utils/retryDioConnectivity.dart';
import 'package:sizer/sizer.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:dio/dio.dart';
import '../../../Utils/UrlServer.dart';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Functions/Controllers/ListsController.dart';
import '../../Widgets/Toast.dart';
import '../../../Utils/ConnectionState.dart';

class CreateClass extends StatefulWidget {
  @override
  _CreateClassState createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass>
    with TickerProviderStateMixin {
  ListController listController = ListController();
  var dio = Dio();
  int count = 0;
  bool loading = false;
  Response response;
  // List classObtained = [];
  var args;
  @override
  void initState() {
    super.initState();
    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    Future.delayed(Duration.zero, () {
      setState(() {
        args =
            (ModalRoute.of(context).settings.arguments as RouteArguments).args;
      });
      print(args);
      getClass();
      modifyClass(args);
    });
  }

  getClass() async {
    List calentamiento = [];
    List flexibilidad = [];
    List desarrollo = [];
    List vueltaCalma = [];
    List totalCalentamiento = [];
    List totalFlexibilidad = [];
    List totalDesarrollo = [];
    List totalVueltaCalma = [];

    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dio = Dio();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    setState(() {
      loading = true;
    });
    try {
      if (hasInternet) {
        response = await dio.get(
            "$urlServer/api/mobile/class/${args["level"]}/${args["number"]}?token=$token");
        for (var i = 0;
            i < response.data["exercisesCalentamiento"].length;
            i++) {
          setState(() {
            calentamiento.add(response.data["exercisesCalentamiento"][i]);
          });
        }

        for (var i = 0;
            i < response.data["exercisesFlexibilidad"].length;
            i++) {
          setState(() {
            flexibilidad.add(response.data["exercisesFlexibilidad"][i]);
          });
        }

        for (var i = 0; i < response.data["exercisesDesarrollo"].length; i++) {
          setState(() {
            desarrollo.add(response.data["exercisesDesarrollo"][i]);
          });
        }

        for (var i = 0; i < response.data["exercisesVueltaCalma"].length; i++) {
          setState(() {
            vueltaCalma.add(response.data["exercisesVueltaCalma"][i]);
          });
        }

        for (var i = 0; i < calentamiento.length; i++) {
          if (totalCalentamiento.contains(calentamiento[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              totalCalentamiento.add(calentamiento[i].toString());
            });
          }
        }

        for (var i = 0; i < flexibilidad.length; i++) {
          if (totalFlexibilidad.contains(flexibilidad[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              totalFlexibilidad.add(flexibilidad[i].toString());
            });
          }
        }

        for (var i = 0; i < desarrollo.length; i++) {
          if (totalDesarrollo.contains(desarrollo[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              totalDesarrollo.add(desarrollo[i].toString());
            });
          }
        }

        for (var i = 0; i < vueltaCalma.length; i++) {
          if (totalVueltaCalma.contains(vueltaCalma[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              totalVueltaCalma.add(vueltaCalma[i].toString());
            });
          }
        }

        await ListController().setMaxCalentamiento(
            totalCalentamiento.length, calentamiento.length);

        await ListController()
            .setMaxFlexibilidad(totalFlexibilidad.length, flexibilidad.length);

        await ListController()
            .setMaxDesarrollo(totalDesarrollo.length, desarrollo.length);

        await ListController()
            .setMaxVueltaCalma(totalVueltaCalma.length, vueltaCalma.length);
        // classObtained.add(response.data);
      } else {
        Navigator.pop(context);
        toast(
            context,
            "No se detecta conexión a internet. Conéctate a una red estable.",
            red);
      }
    } catch (e) {
      CreateError().createError(dio, e.toString(), "CreateClass");
      setState(() {
        loading = false;
      });
      Navigator.pop(context);
      toast(
          context,
          "Ha ocurrido un error al intentar crear la clase, inténtalo más tarde.",
          red);
    }
  }

  modifyClass(var args) async {
    List calentamiento = [];
    List flexibilidad = [];
    List desarrollo = [];
    List vueltaCalma = [];
    List totalCalentamiento = [];
    List totalFlexibilidad = [];
    List totalDesarrollo = [];
    List totalVueltaCalma = [];
    var prefs = await SharedPreferences.getInstance();

    var token = prefs.getString("token");
    List classActual = [];
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (args["isNew"] == false) {
      print("INIT MODIFY");
      if (hasInternet) {
        try {
          Response response = await dio.post(
              "$urlServer/api/mobile/professor/customClasses?token=$token",
              data: [args["idCourse"]]);
          for (var i = 0; i < response.data.length; i++) {
            if (response.data[i]["number"].toString() ==
                args["number"].toString()) {
              classActual.add(response.data[i]);
            }
          }

          for (var i = 0;
              i < classActual[0]["exercisesCalentamiento"].length;
              i++) {
            setState(() {
              calentamiento.add(classActual[0]["exercisesCalentamiento"][i]);
            });
          }

          for (var i = 0;
              i < classActual[0]["exercisesFlexibilidad"].length;
              i++) {
            setState(() {
              flexibilidad.add(classActual[0]["exercisesFlexibilidad"][i]);
            });
          }

          for (var i = 0;
              i < classActual[0]["exercisesDesarrollo"].length;
              i++) {
            setState(() {
              desarrollo.add(classActual[0]["exercisesDesarrollo"][i]);
            });
          }

          for (var i = 0;
              i < classActual[0]["exercisesVueltaCalma"].length;
              i++) {
            setState(() {
              vueltaCalma.add(classActual[0]["exercisesVueltaCalma"][i]);
            });
          }

          print(calentamiento.length);
          print(flexibilidad.length);
          print(desarrollo.length);
          print(vueltaCalma.length);

          for (var i = 0; i < calentamiento.length; i++) {
            if (totalCalentamiento.contains(calentamiento[i].toString())) {
              print("ya existe");
            } else {
              setState(() {
                totalCalentamiento.add(calentamiento[i].toString());
              });
            }
          }

          log("total cal = ${totalCalentamiento.length}");

          for (var i = 0; i < flexibilidad.length; i++) {
            if (totalFlexibilidad.contains(flexibilidad[i].toString())) {
              print("ya existe");
            } else {
              setState(() {
                totalFlexibilidad.add(flexibilidad[i].toString());
              });
            }
          }

          log("total flex = ${totalFlexibilidad.length}");

          for (var i = 0; i < desarrollo.length; i++) {
            if (totalDesarrollo.contains(desarrollo[i].toString())) {
              print("ya existe");
            } else {
              setState(() {
                totalDesarrollo.add(desarrollo[i].toString());
              });
            }
          }

          log("total des = ${totalDesarrollo.length}");

          for (var i = 0; i < vueltaCalma.length; i++) {
            if (totalVueltaCalma.contains(vueltaCalma[i].toString())) {
              print("ya existe");
            } else {
              setState(() {
                totalVueltaCalma.add(vueltaCalma[i].toString());
              });
            }
          }

          log("total vue = ${totalVueltaCalma.length}");

          await ListController().setMaxCalentamiento(
              totalCalentamiento.length, calentamiento.length);

          await ListController().setMaxFlexibilidad(
              totalFlexibilidad.length, flexibilidad.length);

          await ListController()
              .setMaxDesarrollo(totalDesarrollo.length, desarrollo.length);

          await ListController()
              .setMaxVueltaCalma(totalVueltaCalma.length, vueltaCalma.length);
          log(classActual.toString());

          List<String> downloadedExercisesCalentamiento = [];
          List<String> downloadedExercisesFlexibilidad = [];
          List<String> downloadedExercisesDesarrollo = [];
          List<String> downloadedExercisesVueltaCalma = [];

          for (var i = 0;
              i < classActual[0]["exercisesCalentamiento"].length;
              i++) {
            if (downloadedExercisesCalentamiento
                .contains(classActual[0]["exercisesCalentamiento"][i])) {
            } else {
              downloadedExercisesCalentamiento
                  .add(classActual[0]["exercisesCalentamiento"][i]);
            }
          }

          for (var i = 0;
              i < classActual[0]["exercisesFlexibilidad"].length;
              i++) {
            if (downloadedExercisesFlexibilidad
                .contains(classActual[0]["exercisesFlexibilidad"][i])) {
            } else {
              downloadedExercisesFlexibilidad
                  .add(classActual[0]["exercisesFlexibilidad"][i]);
            }
          }

          for (var i = 0;
              i < classActual[0]["exercisesDesarrollo"].length;
              i++) {
            if (downloadedExercisesDesarrollo
                .contains(classActual[0]["exercisesDesarrollo"][i])) {
            } else {
              downloadedExercisesDesarrollo
                  .add(classActual[0]["exercisesDesarrollo"][i]);
            }
          }

          for (var i = 0;
              i < classActual[0]["exercisesVueltaCalma"].length;
              i++) {
            if (downloadedExercisesVueltaCalma
                .contains(classActual[0]["exercisesVueltaCalma"][i])) {
            } else {
              downloadedExercisesVueltaCalma
                  .add(classActual[0]["exercisesVueltaCalma"][i]);
            }
          }

          prefs.setStringList(
              "exercisesCalentamiento", downloadedExercisesCalentamiento);
          prefs.setStringList(
              "exercisesFlexibilidad", downloadedExercisesFlexibilidad);
          prefs.setStringList(
              "exercisesDesarrollo", downloadedExercisesDesarrollo);
          prefs.setStringList(
              "exercisesVueltaCalma", downloadedExercisesVueltaCalma);
          prefs.setInt("maxcalentamiento", 0);
          prefs.setInt("maxflexibilidad", 0);
          prefs.setInt("maxdesarrollo", 0);
          prefs.setInt("maxvueltacalma", 0);
        } catch (e) {
          CreateError().createError(dio, e.toString(), "createClass");
          print(e);
          toast(context, "Ha ocurrido un error. Inténtalo más tarde.", red);
        }
      } else {
        if (args["fromCourses"]) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
        }
        toast(context, "Debes estar conectado a internet.", red);
      }
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        bottomNavigationBar: Container(
          width: 100.0.w,
          height: 10.0.h,
          color: cyan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context, func: () async {
                var prefs = await SharedPreferences.getInstance();
                var maxCal = prefs.getInt("maxStaticCalentamiento");
                var maxFle = prefs.getInt("maxStaticFlexibilidad");
                var maxDes = prefs.getInt("maxStaticDesarrollo");
                var maxVue = prefs.getInt("maxStaticVueltaCalma");
                var listCal =
                    prefs.getStringList("exercisesCalentamiento" ?? null);
                var listFle =
                    prefs.getStringList("exercisesFlexibilidad" ?? null);
                var listDes =
                    prefs.getStringList("exercisesDesarrollo" ?? null);
                var listVue =
                    prefs.getStringList("exercisesVueltaCalma" ?? null);

                if (listCal == null) {
                  toast(
                      context,
                      "No puedes dejar la etapa de calentamiento sin ejercicios.",
                      red);
                } else if (maxCal != listCal.length) {
                  toast(context,
                      "Debes agregar más ejercicios en calentamiento.", red);
                } else if (listDes == null) {
                  toast(
                      context,
                      "No puedes dejar la etapa de desarrollo sin ejercicios.",
                      red);
                } else if (maxDes != listDes.length) {
                  toast(context, "Debes agregar más ejercicios en desarrollo.",
                      red);
                } else if (listVue == null) {
                  toast(
                      context,
                      "No puedes dejar la etapa de vuelta a la calma sin ejercicios.",
                      red);
                } else if (maxVue != listVue.length) {
                  toast(
                      context,
                      "Debes agregar más ejercicios en vuelta a la calma.",
                      red);
                } else if (listFle == null) {
                  toast(
                      context,
                      "No puedes dejar la etapa de flexibilidad sin ejercicios.",
                      red);
                } else if (maxFle != listFle.length) {
                  toast(context,
                      "Debes agregar más ejercicios en flexibilidad.", red);
                } else {
                  goToFinishCreateClass(args["level"], args["number"], response,
                      args["isNew"], args["idCourse"]);
                }
              }, text: "   ENVIAR")
            ],
          ),
        ),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
            onPressed: () {
              if (args["fromCourses"]) {
                Navigator.pop(context);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            },
          ),
          backgroundColor: cyan,
          centerTitle: true,
          elevation: 0,
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(args["isNew"]
                      ? "Crear clase ${args["number"]}".toUpperCase()
                      : "MODIFICAR CLASE ${args["number"]}")),
            ],
          ),
        ),
        body: Stack(
          alignment: Alignment.topCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "Assets/images/LogoCompleto.png",
                      width: 20.0.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonRounded(context, func: () {
                  goToExcercisesClass(
                      "CALENTAMIENTO", args["level"], args["number"]);
                },
                    text: "      CALENTAMIENTO",
                    textStyle: TextStyle(color: blue, fontSize: 6.5.w),
                    backgroudColor: cyan,
                    width: 90.0.w,
                    height: 9.0.h,
                    circleRadius: 6.0.w,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: cyan,
                      size: 8.0.w,
                    )),
                SizedBox(
                  height: 4.0.h,
                ),
                buttonRounded(context, func: () {
                  goToExcercisesClass(
                      "FLEXIBILIDAD", args["level"], args["number"]);
                },
                    text: "      FLEXIBILIDAD",
                    textStyle: TextStyle(color: blue, fontSize: 6.5.w),
                    backgroudColor: red,
                    width: 90.0.w,
                    height: 9.0.h,
                    circleRadius: 6.0.w,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: red,
                      size: 8.0.w,
                    )),
                SizedBox(
                  height: 4.0.h,
                ),
                buttonRounded(context, func: () {
                  goToExcercisesClass(
                      "DESARROLLO", args["level"], args["number"]);
                },
                    text: "      DESARROLLO",
                    textStyle: TextStyle(color: blue, fontSize: 6.5.w),
                    backgroudColor: green,
                    width: 90.0.w,
                    height: 9.0.h,
                    circleRadius: 6.0.w,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: green,
                      size: 8.0.w,
                    )),
                SizedBox(
                  height: 4.0.h,
                ),
                buttonRounded(context, func: () {
                  goToExcercisesClass(
                      "VUELTA A LA CALMA", args["level"], args["number"]);
                },
                    text: "      VUELTA A LA CALMA",
                    textStyle: TextStyle(color: blue, fontSize: 5.5.w),
                    backgroudColor: yellow,
                    width: 90.0.w,
                    height: 9.0.h,
                    circleRadius: 6.0.w,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: yellow,
                      size: 8.0.w,
                    )),
              ],
            )
          ],
        ),
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
      listController.finishCreateClass();
      if (args["fromCourses"]) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    } else if (count <= 1) {
      toast(
          context,
          "Si vuelves atrás perderás los datos creados para la clase. \nPresiona nuevamente para salir.",
          cyan);
    }

    return false;
  }
}
