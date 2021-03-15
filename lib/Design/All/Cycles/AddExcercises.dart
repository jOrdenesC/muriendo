import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:get_it/get_it.dart';
import 'dart:developer';
import '../../../Database/Models/ExcerciseData.dart';
import '../../Widgets/Toast.dart';
import '../../../Functions/Controllers/ListsController.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddExcercises extends StatefulWidget {
  final String level;
  final String number;
  final String category;
  final String subCategory;
  final String stage;
  final bool isPie;
  AddExcercises(
      {this.level,
      this.number,
      this.category,
      this.subCategory,
      this.stage,
      this.isPie});
  @override
  _AddExcercisesState createState() => _AddExcercisesState();
}

class _AddExcercisesState extends State<AddExcercises> {
  var args;
  List bools = [];
  List<ExcerciseData> response = [];
  bool loading = false;
  var max = 0;
  var maxStatic = 0;
  ListController listController = ListController();

  @override
  void initState() {
    super.initState();
    getVideos(widget.level, widget.number, widget.category, widget.subCategory,
        widget.stage);
    getMax();
    getMaxStatic();
  }

  getMax() async {
    if (widget.stage == "CALENTAMIENTO") {
      var res = await ListController().getMaxCalentamiento();
      print(res);
      setState(() {
        max = res;
      });
    } else if (widget.stage == "FLEXIBILIDAD") {
      var res = await ListController().getMaxFlexibilidad();
      print(res);
      setState(() {
        max = res;
      });
    } else if (widget.stage == "DESARROLLO") {
      var res = await ListController().getMaxDesarrollo();
      print(res);
      setState(() {
        max = res;
      });
    } else if (widget.stage == "VUELTA A LA CALMA") {
      var res = await ListController().getMaxVueltaCalma();
      print(res);
      setState(() {
        max = res;
      });
    }
  }

  getMaxStatic() async {
    if (widget.stage == "CALENTAMIENTO") {
      print("Entra a if");
      var res = await ListController().getMaxStaticCalentamiento();
      print(res);
      setState(() {
        maxStatic = res;
      });
    } else if (widget.stage == "FLEXIBILIDAD") {
      print("Entra a if");
      var res = await ListController().getMaxStaticFlexibilidad();
      print(res);
      setState(() {
        maxStatic = res;
      });
    } else if (widget.stage == "DESARROLLO") {
      print("Entra a if");
      var res = await ListController().getMaxStaticDesarrollo();
      print(res);
      setState(() {
        maxStatic = res;
      });
    } else if (widget.stage == "VUELTA A LA CALMA") {
      print("Entra a if");
      var res = await ListController().getMaxStaticVueltaCalma();
      print(res);
      setState(() {
        maxStatic = res;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 9.0.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: cyan,
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text(widget.subCategory)),
          ],
        ),
        elevation: 0,
      ),
      body: loading == false
          ? Column(
              children: [
                SizedBox(height: 3.0.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            bottomRight: Radius.circular(50)),
                        border: Border.all(color: Colors.white, width: 3),
                        color: red,
                      ),
                      width: 95.0.w,
                      height: 8.0.h,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              InkWell(
                                onTap: () {
                                  getBools();
                                },
                                child: Text(
                                  max == 0
                                      ? "MÁXIMO ALCANZADO"
                                      : "ESCOGE SÓLO $max EJERCICIOS",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 5.0.w),
                                ),
                              ),
                            ],
                          ),
                          CircleAvatar(
                            backgroundColor: red,
                            radius: 7.0.w,
                            child: CircleAvatar(
                              radius: 6.0.w,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: Text(
                                  "$max",
                                  style: TextStyle(color: red, fontSize: 8.0.w),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.0.h),
                Expanded(
                  child: ListView.builder(
                      itemCount: response.length,
                      itemBuilder: (context, index) {
                        return item(
                            response[index].idMongo,
                            response[index].nameExcercise,
                            response[index].recommendation,
                            response[index].mets.toString(),
                            bools[index]["status"],
                            index,
                            response[index].videoName);
                      }),
                )
              ],
            )
          : Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            ),
    );
  }

  item(String codeExercise, String nameExercise, String recomendation,
      String mets, bool switchValue, int index, String videoName) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          goToDetailsExcercises(
              videoName, nameExercise, mets, recomendation, true);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 35.0.w,
              height: 10.0.h,
              color: Colors.white,
              child: Center(
                child: Image.asset(
                  "Assets/thumbnails/$videoName.jpeg",
                  fit: BoxFit.fill,
                  width: 100.0.w,
                ),
              ),
            ),
            SizedBox(
              width: 3.0.w,
            ),
            Container(
              width: 55.0.w,
              height: 10.0.h,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CupertinoSwitch(
                        value: switchValue,
                        activeColor: red,
                        onChanged: (value) async {
                          var prefs = await SharedPreferences.getInstance();
                          if (widget.stage == "CALENTAMIENTO") {
                            var actualList = prefs
                                .getStringList("exercisesCalentamiento" ?? []);

                            if (actualList.toString() != "[]" &&
                                actualList != null) {
                              print("Lista de calentamiento no vacía");
                              if (maxStatic == actualList.length) {
                                log(actualList.toString());
                                print("max static = list");
                                if (value) {
                                  print("value true");
                                  toast(
                                      context,
                                      "Ya no puedes agregar más ejercicios.",
                                      red);
                                } else {
                                  setState(() {
                                    bools[index]["status"] = value;
                                    print("value false");
                                    listController
                                        .removeCalentamiento(codeExercise);
                                  });
                                }
                              } else {
                                bools[index]["status"] = value;
                                if (bools[index]["status"]) {
                                  print("add 1");
                                  setState(() {
                                    listController
                                        .addCalentamiento(codeExercise);
                                  });
                                } else {
                                  setState(() {
                                    listController
                                        .removeCalentamiento(codeExercise);
                                  });
                                }
                              }
                            } else {
                              print("list vacía");
                              bools[index]["status"] = value;
                              if (bools[index]["status"]) {
                                print("add 2");
                                setState(() {
                                  listController.addCalentamiento(codeExercise);
                                });
                              } else {
                                setState(() {
                                  listController
                                      .removeCalentamiento(codeExercise);
                                });
                              }
                            }
                            setState(() {
                              getMax();
                            });
                          } else if (widget.stage == "FLEXIBILIDAD") {
                            var actualList = prefs
                                .getStringList("exercisesFlexibilidad" ?? []);
                            setState(() {
                              if (actualList.toString() != "[]" &&
                                  actualList != null) {
                                print(actualList.length.toString());
                                print(maxStatic);
                                if (maxStatic == actualList.length) {
                                  if (value) {
                                    print("value true");
                                    toast(
                                        context,
                                        "Ya no puedes agregar más ejercicios.",
                                        red);
                                  } else {
                                    setState(() {
                                      bools[index]["status"] = value;
                                      print("value false");
                                      listController
                                          .removeFlexibilidad(codeExercise);
                                    });
                                  }
                                } else {
                                  bools[index]["status"] = value;
                                  if (bools[index]["status"]) {
                                    listController
                                        .addFlexibilidad(codeExercise);
                                  } else {
                                    listController
                                        .removeFlexibilidad(codeExercise);
                                  }
                                }
                              } else {
                                bools[index]["status"] = value;
                                if (bools[index]["status"]) {
                                  listController.addFlexibilidad(codeExercise);
                                }
                              }
                              getMax();
                            });
                          } else if (widget.stage == "VUELTA A LA CALMA") {
                            var actualList = prefs
                                .getStringList("exercisesVueltaCalma" ?? []);
                            setState(() {
                              if (actualList.toString() != "[]" &&
                                  actualList != null) {
                                print(actualList.length.toString());
                                print(maxStatic);
                                if (maxStatic == actualList.length) {
                                  if (value) {
                                    print("value true");
                                    toast(
                                        context,
                                        "Ya no puedes agregar más ejercicios.",
                                        red);
                                  } else {
                                    setState(() {
                                      bools[index]["status"] = value;
                                      print("value false");
                                      listController
                                          .removeVueltaCalma(codeExercise);
                                    });
                                  }
                                } else {
                                  bools[index]["status"] = value;
                                  if (bools[index]["status"]) {
                                    listController.addVueltaCalma(codeExercise);
                                  } else {
                                    listController
                                        .removeVueltaCalma(codeExercise);
                                  }
                                }
                              } else {
                                bools[index]["status"] = value;
                                if (bools[index]["status"]) {
                                  listController.addVueltaCalma(codeExercise);
                                }
                              }
                              getMax();
                            });
                          } else if (widget.stage == "DESARROLLO") {
                            var actualList = prefs
                                .getStringList("exercisesDesarrollo" ?? []);
                            setState(() {
                              if (actualList.toString() != "[]" &&
                                  actualList != null) {
                                print(actualList.length.toString());
                                print(maxStatic);
                                if (maxStatic == actualList.length) {
                                  if (value) {
                                    print("value true");
                                    toast(
                                        context,
                                        "Ya no puedes agregar más ejercicios.",
                                        red);
                                  } else {
                                    setState(() {
                                      bools[index]["status"] = value;
                                      print("value false");
                                      listController
                                          .removeDesarrollo(codeExercise);
                                    });
                                  }
                                } else {
                                  bools[index]["status"] = value;
                                  if (bools[index]["status"]) {
                                    listController.addDesarrollo(codeExercise);
                                  } else {
                                    listController
                                        .removeDesarrollo(codeExercise);
                                  }
                                }
                              } else {
                                bools[index]["status"] = value;
                                if (bools[index]["status"]) {
                                  listController.addDesarrollo(codeExercise);
                                }
                              }
                              getMax();
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          " ${index + 1}.- " + nameExercise,
                          style: TextStyle(color: blue),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getBools() async {
    var listCalentamiento = await listController.getExercisesCalentamiento();
    var listFlexibilidad = await listController.getExercisesFlexibilidad();
    var listDesarrollo = await listController.getExercisesDesarrollo();
    var listVueltaCalma = await listController.getExercisesVueltaCalma();

    if (widget.stage == "CALENTAMIENTO") {
      for (var i = 0; i < bools.length; i++) {
        if (listCalentamiento.isNotEmpty) {
          for (var j = 0; j < listCalentamiento.length; j++) {
            if (bools[i]["id"] == listCalentamiento[j]) {
              print(bools[i]["id"]);
              setState(() {
                bools[i] = {"id": bools[i]["id"], "status": true};
              });
            }
          }
        }
      }
    } else if (widget.stage == "FLEXIBILIDAD") {
      for (var i = 0; i < bools.length; i++) {
        if (listFlexibilidad.isNotEmpty) {
          for (var j = 0; j < listFlexibilidad.length; j++) {
            if (bools[i]["id"] == listFlexibilidad[j]) {
              print(bools[i]["id"]);
              setState(() {
                bools[i] = {"id": bools[i]["id"], "status": true};
              });
            }
          }
        }
      }
    } else if (widget.stage == "DESARROLLO") {
      for (var i = 0; i < bools.length; i++) {
        if (listDesarrollo.isNotEmpty) {
          for (var j = 0; j < listDesarrollo.length; j++) {
            if (bools[i]["id"] == listDesarrollo[j]) {
              print(bools[i]["id"]);
              setState(() {
                bools[i] = {"id": bools[i]["id"], "status": true};
              });
            }
          }
        }
      }
    } else {
      for (var i = 0; i < bools.length; i++) {
        if (listVueltaCalma.isNotEmpty) {
          for (var j = 0; j < listVueltaCalma.length; j++) {
            if (bools[i]["id"] == listVueltaCalma[j]) {
              print(bools[i]["id"]);
              setState(() {
                bools[i] = {"id": bools[i]["id"], "status": true};
              });
            }
          }
        }
      }
    }
  }

  getVideos(String level, String number, String category, String subCategory,
      String stage) async {
    setState(() {
      loading = true;
    });
    ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
    List<ExcerciseData> res;
    if (widget.isPie) {
      res = await excerciseDataRepository.getExercisesPie(
        category,
      );
    } else {
      res = await excerciseDataRepository.getExercisesByCategories(
          stage == "FLEXIBILIDAD" ? "CALENTAMIENTO" : stage,
          category,
          subCategory,
          level);
    }

    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        setState(() {
          response.add(res[i]);
          bools.add({"id": res[i].idMongo, "status": false});
        });
      }
    }

    getBools();
    setState(() {
      loading = false;
    });
  }
}
