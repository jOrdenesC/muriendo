import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/UrlServer.dart';
import 'package:movitronia/Utils/ConnectionState.dart';

class ApplicationUse extends StatefulWidget {
  final bool isTeacher;
  final List data;
  ApplicationUse({this.isTeacher, this.data});
  @override
  _ApplicationUseState createState() => _ApplicationUseState();
}

class _ApplicationUseState extends State<ApplicationUse> {
  bool loaded = false;

  double phase1Value = 0;
  double phase2Value = 0;
  double phase3Value = 0;
  double phase4Value = 0;
  double phase5Value = 0;
  double phase6Value = 0;
  double phase7Value = 0;
  double phase8Value = 0;
  double phase9Value = 0;
  double phase10Value = 0;

  @override
  void initState() {
    super.initState();
    getDataForPhase();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 6.0.h,
        backgroundColor: cyan,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              size: Device.get().isTablet ? 7.0.w : 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("Uso de aplicación",
                    style: TextStyle(fontSize: 14.0.sp))),
          ],
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: loaded
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                cardPercentage("FASE 1", phase1Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 2", phase2Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 3", phase3Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 4", phase4Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 5", phase5Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 6", phase6Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 7", phase7Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 8", phase8Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 9", phase9Value),
                SizedBox(
                  height: 1.0.h,
                ),
                cardPercentage("FASE 10", phase10Value)
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

  getDataForPhase() async {
    List<dynamic> phase1 = [];
    List<dynamic> phase2 = [];
    List<dynamic> phase3 = [];
    List<dynamic> phase4 = [];
    List<dynamic> phase5 = [];
    List<dynamic> phase6 = [];
    List<dynamic> phase7 = [];
    List<dynamic> phase8 = [];
    List<dynamic> phase9 = [];
    List<dynamic> phase10 = [];
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      if (widget.isTeacher) {
        for (var i = 0; i < widget.data.length; i++) {
          if (widget.data[i]["phase"] == "1") {
            phase1.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "2") {
            phase2.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "3") {
            phase3.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "4") {
            phase4.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "5") {
            phase5.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "6") {
            phase6.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "7") {
            phase7.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "8") {
            phase8.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "9") {
            phase9.add(widget.data[i]);
          } else if (widget.data[i]["phase"] == "10") {
            phase10.add(widget.data[i]);
          } else {
            print("sin fase");
          }
        }
        setState(() {
          phase1Value = double.parse("${phase1.length * 25}");
          phase2Value = double.parse("${phase2.length * 25}");
          phase3Value = double.parse("${phase3.length * 25}");
          phase4Value = double.parse("${phase4.length * 25}");
          phase5Value = double.parse("${phase5.length * 25}");
          phase6Value = double.parse("${phase6.length * 25}");
          phase7Value = double.parse("${phase7.length * 25}");
          phase8Value = double.parse("${phase8.length * 25}");
          phase9Value = double.parse("${phase9.length * 25}");
          phase10Value = double.parse("${phase10.length * 25}");
          loaded = true;
        });
      } else {
        var prefs = await SharedPreferences.getInstance();
        String token = prefs.getString("token");
        var dio = Dio();

        try {
          Response res =
              await dio.get("$urlServer/api/mobile/evidences?token=$token");
          print(res.data);
          if (res.statusCode == 200) {
            for (var i = 0; i < res.data.length; i++) {
              if (res.data[i]["phase"] == "1") {
                phase1.add(res.data[i]);
              } else if (res.data[i]["phase"] == "2") {
                phase2.add(res.data[i]);
              } else if (res.data[i]["phase"] == "3") {
                phase3.add(res.data[i]);
              } else if (res.data[i]["phase"] == "4") {
                phase4.add(res.data[i]);
              } else if (res.data[i]["phase"] == "5") {
                phase5.add(res.data[i]);
              } else if (res.data[i]["phase"] == "6") {
                phase6.add(res.data[i]);
              } else if (res.data[i]["phase"] == "7") {
                phase7.add(res.data[i]);
              } else if (res.data[i]["phase"] == "8") {
                phase8.add(res.data[i]);
              } else if (res.data[i]["phase"] == "9") {
                phase9.add(res.data[i]);
              } else if (res.data[i]["phase"] == "10") {
                phase10.add(res.data[i]);
              } else {
                print("sin fase");
              }
            }
            setState(() {
              phase1Value = double.parse("${phase1.length * 25}");
              phase2Value = double.parse("${phase2.length * 25}");
              phase3Value = double.parse("${phase3.length * 25}");
              phase4Value = double.parse("${phase4.length * 25}");
              phase5Value = double.parse("${phase5.length * 25}");
              phase6Value = double.parse("${phase6.length * 25}");
              phase7Value = double.parse("${phase7.length * 25}");
              phase8Value = double.parse("${phase8.length * 25}");
              phase9Value = double.parse("${phase9.length * 25}");
              phase10Value = double.parse("${phase10.length * 25}");
              loaded = true;
            });
          }
        } catch (e) {
          print(e);
        }
      }
    } else {
      EvidencesRepository evidencesRepository = GetIt.I.get();
      toast(context, "Cargando datos locales...", green);
      var res = await evidencesRepository.getAllEvidences();
      for (var i = 0; i < res.length; i++) {
        if (res[i].phase == "1") {
          phase1.add(res[i]);
        } else if (res[i].phase == "2") {
          phase2.add(res[i]);
        } else if (res[i].phase == "3") {
          phase3.add(res[i]);
        } else if (res[i].phase == "4") {
          phase4.add(res[i]);
        } else if (res[i].phase == "5") {
          phase5.add(res[i]);
        } else if (res[i].phase == "6") {
          phase6.add(res[i]);
        } else if (res[i].phase == "7") {
          phase7.add(res[i]);
        } else if (res[i].phase == "8") {
          phase8.add(res[i]);
        } else if (res[i].phase == "9") {
          phase9.add(res[i]);
        } else if (res[i].phase == "10") {
          phase10.add(res[i]);
        } else {
          print("sin fase");
        }
      }
      setState(() {
        phase1Value = double.parse("${phase1.length * 25}");
        phase2Value = double.parse("${phase2.length * 25}");
        phase3Value = double.parse("${phase3.length * 25}");
        phase4Value = double.parse("${phase4.length * 25}");
        phase5Value = double.parse("${phase5.length * 25}");
        phase6Value = double.parse("${phase6.length * 25}");
        phase7Value = double.parse("${phase7.length * 25}");
        phase8Value = double.parse("${phase8.length * 25}");
        phase9Value = double.parse("${phase9.length * 25}");
        phase10Value = double.parse("${phase10.length * 25}");
        loaded = true;
      });
    }
  }

  Widget cardPercentage(String month, double percentage) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: cyan, borderRadius: BorderRadius.all(Radius.circular(10))),
        height: Device.get().isTablet ? 6.0.h : 4.0.h,
        width: 90.0.w,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Center(
                      child: Container(
                        child: Center(
                            child: Text(
                          month,
                          style:
                              TextStyle(color: Colors.white, fontSize: 7.0.sp),
                        )),
                        decoration: BoxDecoration(
                            color: blue,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        height: Device.get().isTablet ? 6.0.h : 4.0.h,
                        width: 30.0.w,
                      ),
                    ),
                    Center(
                      child: Container(
                          child: Center(
                              child: Text(
                            percentage.toInt().toString() + "%",
                            style: TextStyle(
                                color: Colors.white, fontSize: 7.0.sp),
                          )),
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30),
                                  topRight: Radius.circular(30))),
                          height: Device.get().isTablet ? 4.0.h : 3.0.h,
                          width: percentage == 0
                              ? 0.1.w
                              : percentage == 25
                                  ? 10.0.w
                                  : percentage == 50
                                      ? 20.0.w
                                      : percentage == 75
                                          ? 30.0.w
                                          : Device.get().isTablet
                                              ? 52.0.w
                                              : 40.0.w),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    "100%",
                    style: TextStyle(
                        color: blue.withOpacity(0.7), fontSize: 7.0.sp),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
