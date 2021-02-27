import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/QuestionDataRepository/QuestionDataRepository.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import '../../Widgets/Toast.dart';
import 'package:get_it/get_it.dart';
import '../../../Database/Models/QuestionaryData.dart';
import '../../../Database/Repository/QuestionaryRepository.dart';
import '../../../Database/Repository/TipsDataRepository/TipsDataRepository.dart';
import 'package:uuid/uuid.dart';
import 'package:get/get.dart';
import '../../../Routes/RoutePageControl.dart';
import '../SessionPage/VideosToRecord.dart';

class Questionary extends StatefulWidget {
  final int number;
  final String classId;
  final double kCal;
  final List exercises;


  Questionary({this.number, this.classId, this.exercises, this.kCal});
  @override
  _QuestionaryState createState() => _QuestionaryState();
}

class _QuestionaryState extends State<Questionary> {

  List tips = [];
  List questionary = [];
  double countDots = 0.0;
  List responses = [];
  Color color;
  bool allResponsed = false;
  ClassDataRepository classDataRepository = GetIt.I.get();
  TipsDataRepository tipsDataRepository = GetIt.I.get();
  QuestionDataRepository questionDataRepository = GetIt.I.get();
  List dataClasses = [];
  bool loaded = false;
  bool noData = false;
  List idTips = [];
  List questions = [];
  PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
    eo();
    
  }

  eo() async {
    questions = await getData();
    for (var i = 0; i < tips.length; i++) {
      responses.add({"number": i, "response": null});
    }
  }

  Future getData() async {
    var res = await classDataRepository.getClassID(widget.classId);
    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        questionary = (res[i].questionnaire);
      }
      for (var i = 0; i < questionary.length; i++) {
        idTips.add(questionary[i]["id"]);
      }
      for (var i = 0; i < idTips.length; i++) {
        var res = await tipsDataRepository.getTips(idTips[i]);
        var res2 = await questionDataRepository.getQuestion(idTips[i]);
        if (res.isNotEmpty) {
          tips.add(res[0].toMap());
        }
        if (res2.isNotEmpty) {
          questions.add(res2[0].toMap());
        }
      }
      setState(() {
        loaded = true;
      });
    } else {
      setState(() {
        noData = true;
      });
    }
    print(questions);
    return questions;
  }

  validate() async {
    int notResponsed = 0;
    for (var i = 0; i < responses.length; i++) {
      if (responses[i]["response"] == null) {
        setState(() {
          notResponsed++;
        });
      }
    }
    if (notResponsed != 0) {
      setState(() {
        allResponsed = false;
      });
    } else {
      setState(() {
        allResponsed = true;
      });
    }
    print(notResponsed);
    if (notResponsed == 0) {
      var uuid = Uuid().v4();
      await save(uuid);
      Get.to(VideosToRecord(
        uuidQuestionary: uuid,
          kCal: widget.kCal,
          exercises: widget.exercises,
          number: widget.number,
          idClass: widget.classId
      ));
      // Get.back(result: uuid.toString());
    } else {
      toast(context, "Te falta responder $notResponsed preguntas.", red);
    }
  }

  Future save(String uuid) async {
    var responsedUser = [];
    for (var i = 0; i < tips.length; i++) {
      var obj = {};
      obj = {
        "tip": tips[i]["tip"].toString(),
        "type": questionary[i]["type"].toString().toLowerCase(),
        questionary[i]["type"] == "VF" ? "questionVf" : "questionAl":
            questionary[i]["type"] == "VF"
                ? questions[i]["questionVf"].toString()
                : questions[i]["questionAl"].toString(),
        questionary[i]["type"] == "VF" ? "correctVf" : "correctAl":
            questionary[i]["type"] == "VF"
                ? questions[i]["correctVf"].toString()
                : questions[i]["correctAl"].toString(),
        "alternatives": questionary[i]["type"] == "VF"
            ? {}
            : questions[i]["alternatives"],
        questionary[i]["type"] == "VF"
                ? 'studentResponseVf'
                : "studentResponseAl":
            questionary[i]["type"] == "VF" && responses[i]["response"] == true
                ? "verdadero"
                : questionary[i]["type"] == "VF" &&
                        responses[i]["response"] == false
                    ? "falso"
                    : responses[i]["response"].toString(),
      };
      responsedUser.add(obj);
    }
    QuestionaryRepository offlineRepository = GetIt.I.get();
    QuestionaryData offlineData =
        QuestionaryData(uuid: uuid.toString(), questionary: responsedUser);
    await offlineRepository.insert(offlineData);
    return true;
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonRounded(context,
                    width: 70.0.w,
                    circleRadius: 6.0.w,
                    height: 7.0.h,
                    func: () => validate(),
                    text: "Finalizar",
                    textStyle: TextStyle(fontSize: 7.0.w, color: Colors.white),
                    icon: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: blue,
                      size: 9.0.w,
                    ))
              ],
            ),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: cyan,
            leading: SizedBox.shrink(),
            elevation: 0,
            centerTitle: true,
            title: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                        "CUESTIONARIO SESIÓN ${widget.number}".toUpperCase())),
              ],
            ),
          ),
          body: noData
              ? Text(
                  "No se han encontrado datos, contacta a soporte por favor.",
                  style: TextStyle(color: Colors.white, fontSize: 7.0.w),
                )
              : loaded
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 70.0.h,
                          child: PageView.builder(
                            onPageChanged: (val) {
                              setState(() {
                                countDots = val.toDouble();
                              });
                            },
                            controller: pageController,
                            itemCount: tips.length,
                            itemBuilder: (context, index) {
                              if (questionary[index]["type"] == "AL") {
                                return card(questions[index]["questionAl"],
                                    index + 1, index + 1, "AL");
                              } else {
                                return card(questions[index]["questionVf"],
                                    index + 1, index + 1, "vf");
                              }
                            },
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  pageController.previousPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.linear);
                                },
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_back_ios_rounded,
                                  color: blue,
                                  size: 10.0.w,
                                )),
                              ),
                              DotsIndicator(
                                decorator: DotsDecorator(
                                  color: Colors.grey,
                                  activeColor: blue,
                                  activeSize: Size(5.0.w, 5.0.w),
                                ),
                                dotsCount: tips.length,
                                position: countDots,
                              ),
                              InkWell(
                                onTap: () {
                                  pageController.nextPage(
                                      duration: Duration(seconds: 1),
                                      curve: Curves.linear);
                                },
                                child: Center(
                                    child: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  color: blue,
                                  size: 10.0.w,
                                )),
                              )
                            ],
                          ),
                        ),
                        Text("")
                      ],
                    )
                  : Center(
                      child: Image.asset(
                        "Assets/videos/loading.gif",
                        fit: BoxFit.contain,
                        width: 30.0.w,
                      ),
                    )),
    );
  }

  insertData(args) async {
    List tipsV2 = [];
    for (var i = 0; i < args["questionnaire"].length; i++) {
      TipsDataRepository offlineRepository = GetIt.I.get();
      var res = await offlineRepository.getTips(args["questionnaire"][i]["id"]);
      tipsV2.add(res);
    }
    setState(() {
      questionary = args["questionnaire"];
    });
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }

  Widget card(String question, int number, int pageNumber, String type) {
    return Stack(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ScrollPhysics(parent: BouncingScrollPhysics()),
          child: Column(
            children: [
              type == "vf"
                  ? Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "$number.- $question".toUpperCase(),
                            style: TextStyle(color: blue, fontSize: 6.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          InkWell(
                            onTap: () {
                              for (var e = 0; e < responses.length; e++) {
                                if (responses[e]["number"] == (number - 1)) {
                                  responses[e] = {
                                    "number": e,
                                    "response": true
                                  };
                                  print(responses
                                      .where((element) =>
                                          element["number"].toString() ==
                                          "${number - 1}")
                                      .toList());
                                  setState(() {});
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: responses
                                                      .where((element) =>
                                                          element["number"]
                                                              .toString() ==
                                                          "${number - 1}")
                                                      .toList()
                                                      .toString() ==
                                                  "[]"
                                              ? red
                                              : responses
                                                          .where((element) =>
                                                              element["number"]
                                                                  .toString() ==
                                                              "${number - 1}")
                                                          .toList()[0]
                                                              ["response"]
                                                          .toString() ==
                                                      "true"
                                                  ? green
                                                  : red,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(90),
                                              bottomRight:
                                                  Radius.circular(90))),
                                      width: 45.0.w,
                                      height: 15.0.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.check_circle_outline_outlined,
                                          color: Colors.white,
                                          size: 25.0.w,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " Verdadero",
                                      style: TextStyle(
                                        fontSize: 8.0.w,
                                        color: responses
                                                    .where((element) =>
                                                        element["number"]
                                                            .toString() ==
                                                        "${number - 1}")
                                                    .toList()[0]["response"] ==
                                                true
                                            ? green
                                            : red,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              for (var i = 0; i < responses.length; i++) {
                                if (responses[i]["number"] == number - 1) {
                                  responses[i] = {
                                    "number": i,
                                    "response": false
                                  };
                                  setState(() {});
                                }
                              }
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          color: responses
                                                          .where((element) =>
                                                              element["number"]
                                                                  .toString() ==
                                                              "${number - 1}")
                                                          .toList()[0]
                                                      ["response"] ==
                                                  false
                                              ? green
                                              : red,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(90),
                                              bottomLeft: Radius.circular(90))),
                                      width: 45.0.w,
                                      height: 15.0.h,
                                      child: Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 25.0.w,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      " Falso",
                                      style: TextStyle(
                                        fontSize: 8.0.w,
                                        color: responses
                                                    .where((element) =>
                                                        element["number"]
                                                            .toString() ==
                                                        "${number - 1}")
                                                    .toList()[0]["response"] ==
                                                false
                                            ? green
                                            : red,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 3.0.h,
                          ),
                          Text(
                            "$number.- $question".toUpperCase(),
                            style: TextStyle(color: blue, fontSize: 6.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Container(
                            height: 60.0.h,
                            child: ListView.builder(
                                itemCount: questions[0]
                                        ["alternatives"]
                                    .length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    for (var i = 0;
                                                        i < responses.length;
                                                        i++) {
                                                      if (responses[i]["number"]
                                                              .toString() ==
                                                          "${number - 1}") {
                                                        setState(() {
                                                          responses[i] = {
                                                            "number":
                                                                "${number - 1}",
                                                            "response": questions[0][
                                                                    "alternatives"]
                                                                .keys
                                                                .toList()[index]
                                                                .toString()
                                                          };
                                                        });
                                                      }
                                                    }
                                                  },
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: questions[0][
                                                                        "alternatives"]
                                                                    .keys
                                                                    .toList()[
                                                                        index]
                                                                    .toString() ==
                                                                responses.where((element) => element["number"].toString() == "${number - 1}").toList()[0]
                                                                    ["response"]
                                                            ? green
                                                            : red,
                                                        borderRadius: BorderRadius.only(
                                                            topRight:
                                                                Radius.circular(
                                                                    90),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    90))),
                                                    width: 25.0.w,
                                                    height: 10.0.h,
                                                    child: Center(
                                                        child: Text(
                                                            questions[0][
                                                                    "alternatives"]
                                                                .keys
                                                                .toList()[index]
                                                                .toString()
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    10.0.w,
                                                                color: Colors
                                                                    .white))),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 1.0.w,
                                            ),
                                            Text(
                                                questions[number -1]
                                                        ["alternatives"]
                                                    .values
                                                    .toList()[index]
                                                    .toString()
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 7.0.w,
                                                    color: blue))
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2.0.h,
                                      ),
                                    ],
                                  );
                                }),
                          )
                        ],
                      ),
                    ),
              Text(""),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //     number - 1 == 0
              //         ? SizedBox.shrink()
              //         : ConstrainedBox(
              //             constraints: BoxConstraints(maxWidth: 50),
              //             child: RaisedButton(
              //               color: Colors.white,
              //               padding: EdgeInsets.symmetric(
              //                 vertical: 12,
              //               ),
              //               shape: StadiumBorder(),
              //               child: Icon(
              //                 Icons.arrow_back_ios,
              //                 color: blue,
              //               ),
              //               onPressed: () {
              //                 pageController.previousPage(
              //                     duration: Duration(milliseconds: 1000),
              //                     curve: Curves.elasticOut);
              //               },
              //             ),
              //           ),
              //     Text(
              //       "$number de ${dataJson["sessions"][0]["questionary"].length}",
              //       style: TextStyle(color: Colors.white, fontSize: 20),
              //     ),
              //     number == dataJson["sessions"][0]["questionary"].length
              //         ? SizedBox.shrink()
              //         : ConstrainedBox(
              //             constraints: BoxConstraints(maxWidth: 50),
              //             child: RaisedButton(
              //               color: Colors.white,
              //               padding: EdgeInsets.symmetric(
              //                 vertical: 12,
              //               ),
              //               shape: StadiumBorder(),
              //               child: Icon(
              //                 Icons.arrow_forward_ios,
              //                 color: blue,
              //               ),
              //               onPressed: () {
              //                 print(number - 1);
              //                 print(dataJson["sessions"][0]["questionary"].length);
              //                 pageController.nextPage(
              //                     duration: Duration(milliseconds: 1000),
              //                     curve: Curves.elasticOut);
              //               },
              //             ),
              //           ),
              //   ],
              // )
            ],
          ),
        ),
      ],
    );
  }
}
