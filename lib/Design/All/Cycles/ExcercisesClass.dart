import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import './AddExcercises.dart';
import 'package:flutter/cupertino.dart';
import '../../../Database/Models/ExcerciseData.dart';

class ExcercisesClass extends StatefulWidget {
  @override
  _ExcercisesClassState createState() => _ExcercisesClassState();
}

class _ExcercisesClassState extends State<ExcercisesClass> {
  List<ExcerciseData> exercisesAll = [];
  @override
  Widget build(BuildContext context) {
    final dynamic title =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //     icon: Icon(
        //       Icons.search_sharp,
        //       size: 7.0.w,
        //     ),
        //     onPressed: () {
        //       addExercises(title);
        //     },
        //   )
        // ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: cyan,
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text(title["title"])),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "Assets/images/logo.png",
                    width: 20.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 2.0.h,
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("ABDOMINAL CORE", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        ABDOMINAL CORE",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CUERPO SUPERIOR", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CUERPO SUPERIOR",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CUERPO INFERIOR", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CUERPO INFERIOR",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("CARDIO", title["title"], title["level"],
                    title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        CARDIO",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                goToFilterExcercises("FLEXIBILIDAD", title["title"],
                    title["level"], title["number"], false);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        FLEXIBILIDAD",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
              SizedBox(
                height: 2.0.h,
              ),
              button(() {
                Get.to(AddExcercises(
                  level: title["level"],
                  category: "ADAPTADOS NIÑOS PIE",
                  subCategory: "ADAPTADOS NIÑOS PIE",
                  stage: title["title"],
                  number: title["number"],
                  isPie: true,
                ));
                // goToFilterExcercises("ADAPTADOS NIÑOS PIE", title["title"],
                //     title["level"], title["number"], true);
              },
                  90.0.w,
                  10.0.h,
                  7.0.w,
                  "        ADAPTADOS NIÑOS PIE",
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                    size: 9.0.w,
                  ),
                  title["title"] == "CALENTAMIENTO"
                      ? cyan
                      : title["title"] == "FLEXIBILIDAD"
                          ? red
                          : title["title"] == "DESARROLLO"
                              ? green
                              : yellow,
                  TextStyle(color: blue, fontSize: 5.5.w)),
            ],
          )
        ],
      ),
    );
  }

  Widget button(Function func, double width, double height, double circleRadius,
      String text, Widget icon, Color circleColor, TextStyle textStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: func,
          child: Container(
            width: width ?? 60.0.w,
            height: height ?? 6.0.h,
            decoration: BoxDecoration(
                border: Border.all(color: circleColor, width: 3),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Ink(
              child: Center(
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: circleRadius ?? 5.0.w,
                                backgroundColor: circleColor ?? Colors.white,
                                child: Center(
                                    child: icon ??
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: blue,
                                          size: 7.0.w,
                                        )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$text",
                              style: textStyle ??
                                  TextStyle(
                                      color: Colors.white, fontSize: 5.5.w),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future getExercisesAll(args) async {
    print("""
    ${args["level"]}, ${args["title"]}
    """);
    exercisesAll.clear();
    ExcerciseDataRepository _excerciseRepository = GetIt.I.get();
    final result = await _excerciseRepository.getExcerciseByLevelAndStage(
        int.parse(args["level"]), args["title"]);
    // final result = await _excerciseRepository.getAllExcercise();
    // print(result[0].toMap().toString());
    for (var i = 0; i < result.length; i++) {
      setState(() {
        exercisesAll.add(result[i]);
      });
    }
    return true;
  }

  addExercises(args) async {
    await getExercisesAll(args);
    print(args);
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return Container(
            child: StatefulBuilder(
              builder: (context, setState) {
                return AlertDialog(
                  contentPadding: EdgeInsets.zero,
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox.expand(
                    child: Container(
                      color: blue,
                      child: Column(
                        children: [
                          Container(
                            height: 8.0.h,
                            width: 100.0.w,
                            color: cyan,
                            child: Center(
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                        size: 10.0.w,
                                      ),
                                      onPressed: () => Navigator.pop(context)),
                                  Container(
                                    width: 50.0.w,
                                    height: 5.0.h,
                                    color: Colors.white,
                                    child: TextField(),
                                  )
                                  // TextField(),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            color: blue,
                            child: SizedBox(
                              height: 2.0.h,
                            ),
                          ),
                          Text(
                            "${args["title"]}",
                            style:
                                TextStyle(color: Colors.white, fontSize: 8.0.w),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          Container(
                            height: 70.0.h,
                            width: 97.0.w,
                            color: blue,
                            child: ListView.builder(
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 15.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20))),
                                    width: 100.0.w,
                                    height: 15.0.h,
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 1.0.w,
                                          ),
                                          Container(
                                            width: 35.0.w,
                                            height: 10.0.h,
                                            color: Colors.white,
                                            child: Center(
                                              child: Image.asset(
                                                "Assets/thumbnails/${exercisesAll[index].videoName}.jpeg",
                                                fit: BoxFit.fill,
                                                width: 100.0.w,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CupertinoSwitch(
                                                    value: true,
                                                    onChanged: (val) {},
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                     MainAxisAlignment.start,
                                                children: [
                                                  Text(
                                     " ${index + 1}.- " +
                                         exercisesAll[index]
                                             .nameExcercise,
                                     style:
                                         TextStyle(color: blue),
                                     overflow:
                                         TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                  ),
                                );
                              },
                              itemCount: exercisesAll.length,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 12.0.h,
                              color: cyan,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // buttonRounded(context, text: "AGREGAR",
                                  //     func: () {
                                  //   selected.clear();
                                  //   for (var i = 0; i < grade.length; i++) {
                                  //     if (grade[i]["status"]) {
                                  //       selected.add({
                                  //         "id": grade[i]["id"],
                                  //         "name": grade[i]["name"]
                                  //       });
                                  //     } else {
                                  //       print("nada");
                                  //     }
                                  //     log("log  " + selected.toString());
                                  //   }
                                  //   Navigator.pop(context);
                                  //   refresh();
                                  // })
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
