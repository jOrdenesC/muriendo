import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_it/get_it.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';
import 'package:get/get.dart';
import '../HomePage/HomepageUser.dart';
import '../../Widgets/Toast.dart';
import 'package:flutter/services.dart';
import '../../../Database/Repository/OfflineRepository.dart';

class ShowCalories extends StatefulWidget {
  final List mets;
  final List exercises;
  final String idClass;
  final List questionnaire;
  final int number;
  final String phase;
  final bool isCustom;

  ShowCalories(
      {this.mets,
      this.exercises,
      this.idClass,
      this.questionnaire,
      this.number,
      this.phase,
      this.isCustom});

  @override
  _ShowCaloriesState createState() => _ShowCaloriesState();
}

class _ShowCaloriesState extends State<ShowCalories> {
  EvidencesRepository sembastEvidenceRepository = GetIt.I.get();

  bool exists = false;
  bool existsOffline = false;
  List args = [];
  double total = 0;
  @override
  void initState() {
    log("IS CUSTOOOM SHOW CALORIES : ${widget.isCustom}");
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    print(widget.mets.toString());
    args.add({
      "mets": widget.mets,
      "exercises": widget.exercises,
      "idClass": widget.idClass,
      "questionnaire": widget.questionnaire,
      "number": widget.number
    });
    getData(args);
    getOfflineData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 10.0.h,
            color: cyan,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonRounded(context, func: () async {
                  OfflineRepository offlineRepository = GetIt.I.get();
                  var res = await offlineRepository.getAll();
                  if (res.isNotEmpty) {
                    print(res[0].idClass);
                  } else {
                    print("a");
                  }
                  print(widget.idClass);

                  if (exists) {
                    toast(
                        context,
                        "Ya has subido los datos de esta sesión. Puedes volver a realizarlas las veces que quieras.",
                        green);
                  } else if (existsOffline) {
                    toast(
                        context,
                        "Tienes esta sesión guardada localmente. Sube los datos una vez te conectes a internet.",
                        green);
                  }

                  exists || existsOffline
                      ? Get.offAll(HomePageUser())
                      : goToEvidencesSession(
                          exercises: widget.exercises,
                          questionnaire: widget.questionnaire,
                          kCal: total,
                          number: widget.number,
                          idClass: widget.idClass,
                          phase: widget.phase,
                          isCustom: widget.isCustom);
                }, text: "   CONTINUAR")
              ],
            ),
          ),
          appBar: AppBar(
            leading: SizedBox.shrink(),
            title: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                FittedBox(fit: BoxFit.fitWidth, child: Text("FIN SESIÓN")),
              ],
            ),
            centerTitle: true,
            backgroundColor: cyan,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "Assets/images/wall3.jpg",
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        """Felicidades
has quemado ${total.toString().substring(0, 4)} KCal""",
                        style: TextStyle(
                          fontSize: 7.0.w,
                          color: blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  getData(args) async {
    var res = await sembastEvidenceRepository.getEvidenceNumber(widget.number);
    if (res.isNotEmpty) {
      if (res[0].finished) {
        setState(() {
          exists = true;
        });
      } else {
        setState(() {
          exists = false;
        });
      }
    }
    var responseCalories = await getTotalKCal(args);
    setState(() {
      total = responseCalories;
    });
    print(responseCalories);
  }

  getOfflineData() async {
    OfflineRepository offlineRepository = GetIt.I.get();
    var res = await offlineRepository.getAll();
    if (res.isNotEmpty) {
      if (res[0].idClass == widget.idClass) {
        setState(() {
          existsOffline = true;
        });
      } else {
        setState(() {
          existsOffline = false;
        });
      }
    }
  }

  Future<double> getTotalKCal(args) async {
    double totalKcalories = 0;
    List<num> kcal = [];
    List<String> totalWithTime = [];
    var prefs = await SharedPreferences.getInstance();
    var weight = prefs.getString("weight");
    for (var i = 0; i < args[0]["mets"].length; i++) {
      var totalXd =
          (args[0]["mets"][i]["mets"] * 0.0175 * double.parse(weight)) / 60;
      kcal.add(totalXd);
      totalWithTime
          .add((kcal[i] * args[0]["mets"][i]["time"]).toStringAsFixed(2));
      totalKcalories = totalKcalories + double.parse(totalWithTime[i]);
    }
    return totalKcalories;
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }
}
