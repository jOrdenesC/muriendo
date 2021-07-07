import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import '../../../Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../../../Utils/ConnectionState.dart';
import 'package:dio/dio.dart';
import '../../../Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get_storage/get_storage.dart';

class DetailsEvidence extends StatefulWidget {
  final dataEvidence;
  final dataClass;
  DetailsEvidence({this.dataEvidence, this.dataClass});
  @override
  _DetailsEvidenceState createState() => _DetailsEvidenceState();
}

class _DetailsEvidenceState extends State<DetailsEvidence> {
  List corrects = [];
  bool loading = false;
  var dio = Dio();

  getCorrects() async {
    setState(() {
      loading = true;
    });
    for (var i = 0; i < widget.dataEvidence["questionnaire"].length; i++) {
      if (widget.dataEvidence["questionnaire"][i]["type"] == "vf") {
        if (widget.dataEvidence["questionnaire"][i]["correctVf"] ==
            widget.dataEvidence["questionnaire"][i]["studentResponseVf"]) {
          setState(() {
            corrects.add(widget.dataEvidence["questionnaire"][i]);
          });
        }
      } else {
        if (widget.dataEvidence["questionnaire"][i]["correctAl"] ==
            widget.dataEvidence["questionnaire"][i]["studentResponseAl"]) {
          setState(() {
            corrects.add(widget.dataEvidence["questionnaire"][i]);
          });
        }
      }
    }
    setState(() {
      loading = false;
    });
  }

  markAsReviewed() async {
    final box = GetStorage();
    var count = box.read("evidencesNumber");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      try {
        Response response = await dio.get(
            "$urlServer/api/mobile/evidence/markAsStudentReviewed/${widget.dataEvidence["_id"]}?token=$token");
        if (response.statusCode == 200) {
          print("evidencia marcada como vista");
          if (count != 0) {
            box.write("evidencesNumber", count - 1);
          }
        } else {
          print("Error ${response.data.toString()}");
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      toast(
          context,
          "Necesitas conexión a internet para que se marque como visto.",
          yellow);
    }
  }

  @override
  void initState() {
    super.initState();
    markAsReviewed();
    getCorrects();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detalles de revisión"),
          centerTitle: true,
          backgroundColor: cyan,
          elevation: 0,
        ),
        body: loading
            ? Center(
                child: Image.asset(
                  "Assets/videos/loading.gif",
                  width: 70.0.w,
                  height: 15.0.h,
                  fit: BoxFit.contain,
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                child: Column(
                  children: [
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: Center(
                              child: Text(
                            "OBSERVACIONES",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 5.0.w,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          )),
                          decoration: BoxDecoration(
                              color: green,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          width: 70.0.w,
                          height: 6.0.h,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                          minWidth: 90.0.w,
                          maxWidth: 90.0.w,
                          minHeight: 20.0.h),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              "${widget.dataEvidence["observations"] == null ? "No se agregaron comentarios a esta evidencia" : widget.dataEvidence["observations"]}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      // width: 80.0.w,
                      // child: Text(widget.dataEvidence["observations"]),
                      // margin: EdgeInsets.all(20),
                      // color: Colors.white,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Divider(
                      color: Colors.white,
                      indent: 10.0.w,
                      endIndent: 10.0.w,
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 40.0.w,
                          height: 7.0.h,
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))),
                          child: Center(
                            child: AutoSizeText(
                              "Fase: ${widget.dataEvidence["phase"]}",
                              maxLines: 1,
                              maxFontSize: Device.get().isTablet ? 35 : 25,
                              minFontSize: Device.get().isTablet ? 18 : 8,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 5.0.w),
                            ),
                          ),
                        ),
                        Container(
                          width: 40.0.w,
                          height: 7.0.h,
                          decoration: BoxDecoration(
                              color: red,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  bottomLeft: Radius.circular(50))),
                          child: Center(
                            child: AutoSizeText(
                              "Clase N°: ${widget.dataClass["number"]}",
                              maxLines: 1,
                              maxFontSize: Device.get().isTablet ? 35 : 25,
                              minFontSize: Device.get().isTablet ? 18 : 8,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 5.0.w),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.local_fire_department,
                              color: cyan,
                              size: 15.0.w,
                            ),
                            Container(
                              width: 70.0.w,
                              child: Center(
                                child: AutoSizeText(
                                  "${widget.dataEvidence["totalKilocalories"].toInt()} kcal. quemadas aprox.",
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  maxFontSize: Device.get().isTablet ? 35 : 25,
                                  minFontSize: Device.get().isTablet ? 18 : 8,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 5.0.w),
                                ),
                              ),
                            ),
                          ],
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
                            Icon(
                              Icons.check,
                              color: green,
                              size: 15.0.w,
                            ),
                            Center(
                              child: Container(
                                width: 70.0.w,
                                child: AutoSizeText(
                                  "Respondiste ${corrects.length} preguntas correctamente de un total de ${widget.dataEvidence["questionnaire"].length} preguntas.",
                                  maxLines: 3,
                                  textAlign: TextAlign.center,
                                  maxFontSize: Device.get().isTablet ? 35 : 25,
                                  minFontSize: Device.get().isTablet ? 18 : 8,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 5.0.w),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ));
  }
}
