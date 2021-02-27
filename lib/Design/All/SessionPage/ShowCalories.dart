import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowCalories extends StatefulWidget {
  final List mets;
  final List exercises;
  final String idClass;
  final List questionnaire;
  final int number;

  ShowCalories(
      {this.mets,
      this.exercises,
      this.idClass,
      this.questionnaire,
      this.number});

  @override
  _ShowCaloriesState createState() => _ShowCaloriesState();
}

class _ShowCaloriesState extends State<ShowCalories> {
  List args = [];
  double total = 0;
  @override
  void initState() {
    args.add({
      "mets": widget.mets,
      "exercises": widget.exercises,
      "idClass": widget.idClass,
      "questionnaire": widget.questionnaire,
      "number": widget.number
    });
    getData(args);
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
                  // var res = await getData(args);
                  // print(res);
                  // log(args.toString());
                  // var xd =  getTotalKCal(args).toString();
                  // print(xd);
                  goToEvidencesSession(
                      exercises: widget.exercises,
                      questionnaire: widget.questionnaire,
                      kCal: total,
                      number: widget.number,
                      idClass: widget.idClass);
                }, text: "   CONTINUAR")
              ],
            ),
          ),
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
            //   onPressed: () => Navigator.pop(context),
            // ),
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
    var xd = await getTotalKCal(args);
    setState(() {
      total = xd;
    });
    print(xd);
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
