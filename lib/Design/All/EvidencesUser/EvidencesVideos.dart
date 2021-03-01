import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:toast/toast.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';
import 'package:get_it/get_it.dart';

class EvidencesVideos extends StatefulWidget {
  @override
  _EvidencesVideosState createState() => _EvidencesVideosState();
}

class _EvidencesVideosState extends State<EvidencesVideos> {
  EvidencesRepository evidencesRepository = GetIt.I.get();
  List<bool> evidences = [];
  @override
  void initState() {
    super.initState();
    getEvidence();
  }

  getEvidence() async {
    var all = await evidencesRepository.getAllEvidences();
    for (var i = 0; i < all.length; i++) {
      if (all.isNotEmpty) {
        setState(() {
          evidences.add(all[i].finished);
        });
      } else {
        setState(() {
          evidences.add(false);
        });
      }
    }
    print(evidences.toString());
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
                child: Text("Evidencias Videos".toUpperCase())),
          ],
        ),
        centerTitle: true,
      ),
      body: body(),
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
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: blue,
                            ),
                            "1",
                            evidences[0]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: blue,
                              ),
                              "2",
                              evidences[1]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: blue,
                              ),
                              "3",
                              evidences[2]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: blue,
                            ),
                            "4",
                            evidences[3]),
                      ],
                    ),
                    divider(green, "FASE 2"),
                    Text(""),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "5",
                            evidences[4]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "6",
                              evidences[5]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "7",
                              evidences[6]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "8",
                            evidences[7]),
                      ],
                    ),
                    divider(cyan, "FASE 3"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[8]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[9]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[10]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[11]),
                      ],
                    ),
                    divider(yellow, "FASE 4"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[12]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[13]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[14]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[15]),
                      ],
                    ),
                    divider(green, "FASE 5"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[16]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[17]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[18]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[19]),
                      ],
                    ),
                    divider(cyan, "FASE 6"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[20]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[21]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[22]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[23]),
                      ],
                    ),
                    divider(yellow, "FASE 7"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[24]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[25]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[26]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[27]),
                      ],
                    ),
                    divider(green, "FASE 8"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[28]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[29]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[30]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[31]),
                      ],
                    ),
                    divider(cyan, "FASE 9"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[32]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[33]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[34]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[35]),
                      ],
                    ),
                    divider(yellow, "FASE 10"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "9",
                            evidences[36]),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "10",
                              evidences[37]),
                          circularActivity(
                              "title",
                              0,
                              Icon(
                                Icons.camera_alt,
                                size: 20.0.w,
                                color: Colors.white,
                              ),
                              "11",
                              evidences[38]),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        circularActivity(
                            "title",
                            0,
                            Icon(
                              Icons.camera_alt,
                              size: 20.0.w,
                              color: Colors.white,
                            ),
                            "12",
                            evidences[39]),
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
      String title, double percentage, Icon img, String number, bool lock) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {
            if (lock == true) {
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
                // color: blue,
                child: CircularPercentIndicator(
                  percent: percentage,
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
                        child: img),
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
