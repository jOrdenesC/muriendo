import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

class FinishCreateClass extends StatefulWidget {
  @override
  _FinishCreateClassState createState() => _FinishCreateClassState();
}

class _FinishCreateClassState extends State<FinishCreateClass> {
  var args;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      setState(() {
        args =
            (ModalRoute.of(context).settings.arguments as RouteArguments).args;
      });
      print(args);
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToAssignCreatedClass(args["level"], args["number"],
                  args["response"], args["courseId"], args["isNew"]);
            }, text: "   SUBE AQUÍ")
          ],
        ),
      ),
      backgroundColor: Colors.white,
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
            FittedBox(fit: BoxFit.fitWidth, child: Text("FIN SESIÓN")),
          ],
        ),
        backgroundColor: cyan,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Image.asset("Assets/images/wall4.png")],
          ),
          Column(
            children: [
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¡FELICITACIONES!",
                    style: TextStyle(color: blue, fontSize: 10.0.w),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: args["isNew"] ? 70.0.w : 85.0.w,
                    height: args["isNew"] ? 5.0.h : 7.0.h,
                    child: Center(
                      child: Text(
                        args["isNew"]
                            ? "Has finalizado tu clase"
                            : "Has finalizado de modificar tu clase",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10.0.h,
              ),
              InkWell(
                onTap: () {
                  viewClass();
                },
                child: Container(
                  width: args["isNew"] ? 70.0.w : 90.0.w,
                  height: 5.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.remove_red_eye,
                          color: Colors.white, size: 8.0.w),
                      Text(
                        args["isNew"]
                            ? "Ver clase creada".toUpperCase()
                            : "Ver clase modificada".toUpperCase(),
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  viewClass() async {
    ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
    List exercisesCalentamiento = [];
    List exercisesFlexibilidad = [];
    List exercisesDesarrollo = [];
    List exercisesVueltaCalma = [];
    List finalListCalentamiento = [];
    List finalListDesarrollo = [];
    List finalListVueltaCalma = [];

    exercisesCalentamiento.clear();
    exercisesFlexibilidad.clear();
    exercisesDesarrollo.clear();
    exercisesVueltaCalma.clear();
    var prefs = await SharedPreferences.getInstance();
    var exercisesLocalCalentamiento =
        prefs.getStringList("exercisesCalentamiento");
    var exercisesLocalFlexibilidad =
        prefs.getStringList("exercisesFlexibilidad");
    var exercisesLocalDesarrollo = prefs.getStringList("exercisesDesarrollo");
    var exercisesLocalVueltaCalma = prefs.getStringList("exercisesVueltaCalma");
    var maxCalentamiento = prefs.getInt("maxTotalCalentamiento");
    var maxFlexibilidad = prefs.getInt("maxTotalFlexibilidad");
    var maxDesarrollo = prefs.getInt("maxTotalDesarrollo");
    var maxVueltaCalma = prefs.getInt("maxTotalVueltaCalma");

    await addAll(
        exercisesLocalCalentamiento, exercisesCalentamiento, maxCalentamiento);
    await addAll(
        exercisesLocalFlexibilidad, exercisesFlexibilidad, maxFlexibilidad);
    await addAll(exercisesLocalDesarrollo, exercisesDesarrollo, maxDesarrollo);
    await addAll(
        exercisesLocalVueltaCalma, exercisesVueltaCalma, maxVueltaCalma);

    for (var i = 0; i < exercisesCalentamiento.length; i++) {
      var exercise = await excerciseDataRepository
          .getExerciseById(exercisesCalentamiento[i]);
      setState(() {
        finalListCalentamiento.add(exercise[0].nameExcercise);
      });
    }

    for (var i = 0; i < exercisesFlexibilidad.length; i++) {
      var exercise = await excerciseDataRepository
          .getExerciseById(exercisesFlexibilidad[i]);
      setState(() {
        finalListCalentamiento.add(exercise[0].nameExcercise);
      });
    }

    for (var i = 0; i < exercisesDesarrollo.length; i++) {
      var exercise =
          await excerciseDataRepository.getExerciseById(exercisesDesarrollo[i]);
      setState(() {
        finalListDesarrollo.add(exercise[0].nameExcercise);
      });
    }

    for (var i = 0; i < exercisesVueltaCalma.length; i++) {
      var exercise = await excerciseDataRepository
          .getExerciseById(exercisesVueltaCalma[i]);
      setState(() {
        finalListVueltaCalma.add(exercise[0].nameExcercise);
      });
    }
    var dataClass = {
      "session": args["number"],
      "exercisesCalentamiento": finalListCalentamiento,
      "exercisesDesarrollo": finalListDesarrollo,
      "exercisesVueltaCalma": finalListVueltaCalma
    };
    goToPlanification(null, int.parse(args["number"]), true, dataClass, null);
  }

  Future addAll(List exercisesLocal, List exercisesAdd, int total) {
    for (var i = 0; i < total; i++) {
      for (var j = 0; j < exercisesLocal.length; j++) {
        if (exercisesAdd.length == total) {
        } else {
          setState(() {
            exercisesAdd.add(exercisesLocal[j]);
          });
        }
      }
    }
    return null;
  }
}
