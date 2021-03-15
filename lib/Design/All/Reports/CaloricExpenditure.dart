import 'package:chart_components/bar_chart_component.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/Testing/DataGraphics.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import '../../../Utils/UrlServer.dart';
import 'dart:developer';
import '../../../Database/Models/evidencesSend.dart';

class CaloricExpenditure extends StatefulWidget {
  final bool isTeacher;
  final List data;
  CaloricExpenditure({this.isTeacher, this.data});
  @override
  _CaloricExpenditureState createState() => _CaloricExpenditureState();
}

class _CaloricExpenditureState extends State<CaloricExpenditure> {
  List<double> data = [];
  List<String> labels = [];
  bool loaded = false;
  bool noData = false;
  bool errorServer = false;
  double totalKcal = 0;

  @override
  void initState() {
    super.initState();
    DataRepository.clearData();
    _loadData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text("REPORTES")),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: errorServer
          ? Center(
              child: Text(
                "Ha ocurrido un error en el servidor. Inténtalo más tarde.",
                style: TextStyle(color: blue, fontSize: 6.0.w),
                textAlign: TextAlign.center,
              ),
            )
          : noData
              ? Center(
                  child: Text(
                    "No se han encontrado datos. Recuerda subir tus sesiones cuando estés conectado a internet.",
                    style: TextStyle(color: blue, fontSize: 6.0.w),
                    textAlign: TextAlign.center,
                  ),
                )
              : loaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.0.h,
                        ),
                        widget.isTeacher
                            ? Text(
                                "Evidencias de ${widget.data[0]["student"]["name"]}",
                                style: TextStyle(color: blue, fontSize: 5.0.w),
                                textAlign: TextAlign.center,
                              )
                            : SizedBox.shrink(),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text(
                          "GASTO CALÓRICO (KCal)",
                          style: TextStyle(color: blue, fontSize: 7.0.w),
                        ),
                        Expanded(
                          flex: 30,
                          child: Container(
                            margin: EdgeInsets.all(16),
                            padding: EdgeInsets.only(
                                bottom: 0, left: 8, right: 8, top: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(color: blue, width: 2),
                            ),
                            child: BarChart(
                              data: data,
                              labels: labels,
                              labelStyle: TextStyle(fontSize: 3.2.w),
                              valueStyle: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                              displayValue: true,
                              reverse: true,
                              getColor: DataRepository.getColor,
                              getIcon: DataRepository.getIcon,
                              barWidth: 15.0.w,
                              barSeparation: 7.0.w,
                              animationDuration: Duration(milliseconds: 1000),
                              animationCurve: Curves.easeInOutSine,
                              itemRadius: 10.0.w,
                              iconHeight: 24,
                              footerHeight: 24,
                              headerValueHeight: 16,
                              roundValuesOnText: false,
                              lineGridColor: Colors.transparent,
                            ),
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total".toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 6.0.w),
                                ),
                                Container(
                                  child: Center(
                                    child: Text(
                                      "${totalKcal.roundToDouble().toString().length > 5 ? totalKcal.roundToDouble().toString().substring(0, 4) : totalKcal.roundToDouble().toString()} KCal",
                                      style: TextStyle(
                                          fontSize: 5.0.w, color: blue),
                                    ),
                                  ),
                                  height: 6.0.h,
                                  width: 30.0.w,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50))),
                                )
                              ],
                            ),
                          ),
                          height: 7.0.h,
                          width: 80.0.w,
                          decoration: BoxDecoration(
                              color: blue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                        ),
                        SizedBox(
                          height: 5.0.h,
                        )
                      ],
                    )
                  : Center(
                      child: Image.asset(
                        "Assets/videos/loading.gif",
                        fit: BoxFit.contain,
                        width: 30.0.w,
                      ),
                    ),
    );
  }

  void _loadData() async {
    List<double> kCal = [];
    List<String> namesClass = [];
    EvidencesRepository evidencesRepository = GetIt.I.get();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet == false) {
      setState(() {
        noData = true;
      });
      toast(context, "Cargando datos locales...", green);
      var res = await evidencesRepository.getAllEvidences();
      log(res.toList()[1].toMap().toString());
      if (res.isEmpty) {
        setState(() {
          noData = true;
        });
      } else {
        for (var i = 0; i < res.length; i++) {
          namesClass.add("Sesión ${res[i].number}".toString());
          kCal.add(double.parse(res[i].kilocalories.toString()));
        }
        setState(() {
          if (!loaded) {
            DataRepository.data = kCal;
            DataRepository.labels = namesClass;
            data = DataRepository.getData();
            loaded = true;
          }
          labels = DataRepository.getLabels();
        });
      }
    } else {
      if (widget.isTeacher) {
        for (var i = 0; i < widget.data.length; i++) {
          namesClass
              .add("Sesión ${widget.data[i]["class"]["number"]}".toString());
          kCal.add(double.parse(
              widget.data[i]["totalKilocalories"].toStringAsFixed(2)));
        }
        for (var i = 0; i < kCal.length; i++) {
          totalKcal = totalKcal + kCal[i];
        }
        setState(() {
          if (!loaded) {
            DataRepository.data = kCal;
            DataRepository.labels = namesClass;
            data = DataRepository.getData();
            loaded = true;
          }
          labels = DataRepository.getLabels();
        });
        if (widget.data.length == 0) {
          setState(() {
            noData = true;
          });
        }
      } else {
        var dio = Dio();
        var prefs = await SharedPreferences.getInstance();
        var token = prefs.getString("token");
        try {
          Response res =
              await dio.get("$urlServer/api/mobile/evidences?token=$token");
          print(res.data);
          if (res.statusCode == 200) {
            for (var i = 0; i < res.data.length; i++) {
              namesClass
                  .add("Sesión ${res.data[i]["class"]["number"]}".toString());
              kCal.add(double.parse(
                  res.data[i]["totalKilocalories"].toStringAsFixed(2)));
              EvidencesSend evidencesSend = EvidencesSend(
                  number: res.data[i]["class"]["number"],
                  idEvidence: res.data[i]["class"]["_id"],
                  phase: res.data[i]["phase"],
                  classObject: res.data[i]["class"],
                  finished: true,
                  questionnaire: res.data[i]["questionnaire"],
                  kilocalories: res.data[i]["totalKilocalories"].toString());
              evidencesRepository.updateEvidence(evidencesSend);
            }
            for (var i = 0; i < kCal.length; i++) {
              totalKcal = totalKcal + kCal[i];
            }
            setState(() {
              if (!loaded) {
                DataRepository.data = kCal;
                DataRepository.labels = namesClass;
                data = DataRepository.getData();
                loaded = true;
              }
              labels = DataRepository.getLabels();
            });
            if (res.data.length == 0) {
              setState(() {
                noData = true;
              });
            }
          } else {
            setState(() {
              noData = true;
            });
            print("no data");
          }
        } catch (e) {
          setState(() {
            errorServer = true;
          });
          print(e);
        }
      }
    }
  }
}
