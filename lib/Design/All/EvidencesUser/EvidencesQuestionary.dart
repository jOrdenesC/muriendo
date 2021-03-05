import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';
import 'package:get_it/get_it.dart';
import '../../Widgets/Toast.dart';

class EvidencesQuestionary extends StatefulWidget {
  @override
  _EvidencesQuestionaryState createState() => _EvidencesQuestionaryState();
}

class _EvidencesQuestionaryState extends State<EvidencesQuestionary> {
  EvidencesRepository evidencesRepository = GetIt.I.get();
  List<bool> evidences = [];
  List questionnaires = [];
  bool loading = false;
  @override
  void initState() {
    getEvidence();
    super.initState();
  }

  getEvidence() async {
    setState(() {
      loading = true;
    });
    var all = await evidencesRepository.getAllEvidences();
    for (var i = 0; i < all.length; i++) {
      if (all.isNotEmpty) {
        setState(() {
          evidences.add(all[i].finished);
          questionnaires.add(all[i].questionnaire);
        });
      } else {
        setState(() {
          evidences.add(false);
          questionnaires.add(null);
        });
      }
    }
    print(evidences.toString());
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: red,
      appBar: AppBar(
        backgroundColor: cyan,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "Evidencias Cuestionario".toUpperCase(),
                style: TextStyle(fontSize: 5.0.w),
              ),
            ),
          ],
        ),
        centerTitle: true,
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
          : body(),
    );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Transform.rotate(
                  origin: Offset(-3.0.w, -3.0.w),
                  angle: pi * 1,
                  child: SvgPicture.asset("Assets/images/figure2.svg",
                      color: Color.fromRGBO(167, 71, 66, 1), width: 70.0.w),
                ),
              ],
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 5.0.w,
                ),
                Image.asset(
                  "Assets/images/LogoCompleto.png",
                  width: 18.0.w,
                )
              ],
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.0.h,
                    ),
                    divider(yellow, "FASE 1"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[0], questionnaires[0]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[1],
                              questionnaires[1]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[2],
                              questionnaires[2]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[3], questionnaires[3]),
                      ],
                    ),
                    divider(green, "FASE 2"),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[4], questionnaires[4]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[5],
                              questionnaires[5]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[6],
                              questionnaires[6]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[7], questionnaires[7]),
                      ],
                    ),
                    divider(cyan, "FASE 3"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[8], questionnaires[8]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[9],
                              questionnaires[9]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[10],
                              questionnaires[10]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[11], questionnaires[11]),
                      ],
                    ),
                    divider(yellow, "FASE 4"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[12], questionnaires[12]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[13],
                              questionnaires[13]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[14],
                              questionnaires[14]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[15], questionnaires[15]),
                      ],
                    ),
                    divider(green, "FASE 5"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[16], questionnaires[16]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[17],
                              questionnaires[17]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[18],
                              questionnaires[18]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[19], questionnaires[19]),
                      ],
                    ),
                    divider(cyan, "FASE 6"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[20], questionnaires[20]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[21],
                              questionnaires[21]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[22],
                              questionnaires[22]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[23], questionnaires[23]),
                      ],
                    ),
                    divider(yellow, "FASE 7"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[24], questionnaires[24]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[25],
                              questionnaires[25]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[26],
                              questionnaires[26]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[27], questionnaires[27]),
                      ],
                    ),
                    divider(green, "FASE 8"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[28], questionnaires[28]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[29],
                              questionnaires[28]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[30],
                              questionnaires[30]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[31], questionnaires[31]),
                      ],
                    ),
                    divider(cyan, "FASE 9"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[32], questionnaires[32]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[33],
                              questionnaires[33]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[34],
                              questionnaires[34]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[35], questionnaires[35]),
                      ],
                    ),
                    divider(yellow, "FASE 10"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[36], questionnaires[36]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[37],
                              questionnaires[37]),
                          circularActivity(
                              "title",
                              "Assets/images/docImage.png",
                              "1",
                              evidences[38],
                              questionnaires[38]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity("title", "Assets/images/docImage.png",
                            "1", evidences[39], questionnaires[39]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25.0.w,
          height: 10.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Center(
              child: Text(
            "$text",
            style: TextStyle(color: Colors.white, fontSize: 5.5.w),
          )),
        )
      ],
    );
  }

  Widget circularActivity(
      String title, String img, String number, bool lock, var questionnaire) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {
            if (lock == true) {
              List corrects = [];
              int total = questionnaire.length;
              var quest = questionnaire;
              for (var i = 0; i < quest.length; i++) {
                if (quest[i]["type"] == "vf") {
                  if (quest[i]["correctVf"] == quest[i]["studentResponseVf"]) {
                    setState(() {
                      corrects.add(quest[i]);
                    });
                  }
                } else {
                  if (quest[i]["correctAl"] == quest[i]["studentResponseAl"]) {
                    setState(() {
                      corrects.add(quest[i]);
                    });
                  }
                }
              }
              toast(
                  context,
                  "Respondiste ${corrects.length} correctamente de $total en este cuestionario",
                  green);
              // goToPlanification();
            } else {
              Toast.show("No has subido evidencias de esta sesión.", context,
                  duration: Toast.LENGTH_LONG,
                  gravity: Toast.CENTER,
                  backgroundColor: red);
            }
          },
          child: Stack(
            children: [
              Container(
                width: 35.0.w,
                // color: red,
                child: CircularPercentIndicator(
                  percent: 0.0,
                  progressColor: green,
                  lineWidth: 7,
                  radius: 29.0.w,
                  center: CircleAvatar(
                    radius: 12.8.w,
                    backgroundColor: lock == false ? Colors.grey : yellow,
                    child: Container(
                      margin: lock == false
                          ? EdgeInsets.all(6.5)
                          : EdgeInsets.all(0),
                      color: Colors.transparent,
                      child: Image.asset(
                        "$img",
                        color: lock == false ? Colors.white : blue,
                        fit: lock == false ? BoxFit.contain : BoxFit.contain,
                        width: lock == false ? 14.0.w : 16.0.w,
                        height: lock == false ? 20.0.h : 20.0.h,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0.w,
                left: 22.0.w,
                child: CircularPercentIndicator(
                  lineWidth: 7,
                  radius: 9.0.w,
                  center: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                        child: lock == false
                            ? Icon(
                                Icons.close,
                                color: red,
                                size: 8.0.w,
                              )
                            : Icon(
                                Icons.check,
                                color: green,
                                size: 8.0.w,
                              )),
                  ),
                ),
              )
            ],
          )),
    );
  }
}
