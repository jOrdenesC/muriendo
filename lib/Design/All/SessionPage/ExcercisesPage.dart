import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/Models/ExcerciseData.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

class ExcercisesPage extends StatefulWidget {
  @override
  _ExcercisesPageState createState() => _ExcercisesPageState();
}

class _ExcercisesPageState extends State<ExcercisesPage>
    with TickerProviderStateMixin {
  GifController controller1;

  ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();

  @override
  void initState() {
    controller1 = GifController(vsync: this);
    controller1.repeat(period: Duration(seconds: 1), min: 0, max: 15);
    super.initState();
  }

  @override
  void dispose() {
    controller1.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    final dynamic name =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cyan,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("${name["name"].toUpperCase()}")),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: w,
            height: h,
            color: name == "calentamiento"
                ? cyan
                : name == "desarrollo"
                    ? green
                    : yellow,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: blue, height: 30.0.h),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    // origin: Offset(-5.0.w, 1.0.w),
                    angle: pi * 2,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: blue, height: 30.0.h),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 3.0.h,
              // ),
            ],
          ),
          name == "calentamiento"
              ?
              // ? SingleChildScrollView(
              //     physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              //     scrollDirection: Axis.vertical,
              //     child: Column(
              //       children: [
              //         Text(""),
              //         Text(""),
              //         InkWell(
              //           onTap: () {
              //             goToDetailsExcercises(
              //                 "FILA DE AIRE",
              //                 "Assets/videos/C12",
              //                 "13",
              //                 "10",
              //                 "Mantén la espalda erguida. Contrae el abdomen y los glúteos. No encojas los hombros. Junta las escapulas.");
              //           },
              //           child: Container(
              //             color: Colors.white,
              //             width: w,
              //             child:
              //                 Image.asset("Assets/images/thumbnails/C12T.jpg"),
              //           ),
              //         ),
              //         Text(""),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "FILA DE AIRE",
              //               style: TextStyle(
              //                   fontSize: w * 0.06, color: Colors.white),
              //             )
              //           ],
              //         ),
              //         Text(""),
              //         InkWell(
              //           onTap: () {
              //             goToDetailsExcercises(
              //                 "LOW RUNNER",
              //                 "Assets/videos/C7",
              //                 "12",
              //                 "10",
              //                 "Mantén la espalda erguida. Flecta un poco las rodillas. No te inclines hacia adelante. Contrae el abdomen.");
              //           },
              //           child: Container(
              //             color: Colors.white,
              //             width: w,
              //             child:
              //                 Image.asset("Assets/images/thumbnails/C7T.jpg"),
              //           ),
              //         ),
              //         Text(""),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             Text(
              //               "LOW RUNNER",
              //               style: TextStyle(
              //                   fontSize: w * 0.06, color: Colors.white),
              //             )
              //           ],
              //         ),
              //         Text(""),
              //       ],
              //     ),
              //   )

              ListView.builder(
                  itemCount: name["data"].length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () async {
                            var res = await excerciseDataRepository
                                .getExcerciseName(name["data"][index]);
                            goToDetailsExcercises(
                                "${name["data"][index]}",
                                "Assets/videos/C12",
                                "${res[0].mets}",
                                "${res[0].recommendation}");
                          },
                          child: Container(
                            color: Colors.white,
                            width: w,
                            child: Image.asset(
                                "Assets/thumbnails/${name["data"][index]}.png"),
                          ),
                        ),
                        Text(""),
                        FittedBox(
                          fit: BoxFit.fitWidth,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${name["data"][index]}",
                                style: TextStyle(
                                    fontSize: w * 0.06, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  })
              : name == "desarrollo"
                  ? ListView.builder(
                      itemCount: name["data"].length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                var res = await excerciseDataRepository
                                    .getExcerciseName(name["data"][index]);
                                goToDetailsExcercises(
                                    "${name["data"][index]}",
                                    "Assets/videos/C12",
                                    "${res[0].mets}",
                                    "${res[0].recommendation}");
                              },
                              child: Container(
                                color: Colors.white,
                                width: w,
                                child: Image.asset(
                                    "Assets/thumbnails/${name["data"][index]}.png"),
                              ),
                            ),
                            Text(""),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${name["data"][index]}",
                                    style: TextStyle(
                                        fontSize: w * 0.06,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      })
                  : ListView.builder(
                      itemCount: name["data"].length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                var res = await excerciseDataRepository
                                    .getExcerciseName(name["data"][index]);
                                goToDetailsExcercises(
                                    "${name["data"][index]}",
                                    "Assets/videos/C12",
                                    "${res[0].mets}",
                                    "${res[0].recommendation}");
                              },
                              child: Container(
                                color: Colors.white,
                                width: w,
                                child: Image.asset(
                                    "Assets/thumbnails/${name["data"][index]}.png"),
                              ),
                            ),
                            Text(""),
                            FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${name["data"][index]}",
                                    style: TextStyle(
                                        fontSize: w * 0.06,
                                        color: Colors.white),
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      })
        ],
      ),
    );
  }

  viewInfo(String asset, int duration, String recomendation, String name,
      int calories) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => Navigator.pop(context),
                  label: Icon(
                    Icons.close,
                    size: 40,
                  ),
                  icon: Text(
                    "   Cerrar   ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                backgroundColor: Colors.white,
                appBar: new AppBar(
                  backgroundColor: cyan,
                  leading: SizedBox.shrink(),
                  elevation: 0,
                  centerTitle: true,
                  title: new FittedBox(
                      fit: BoxFit.fitWidth, child: Text('$name'.toUpperCase())),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: new Image(
                              width: MediaQuery.of(context).size.width * 0.9,
                              fit: BoxFit.fill,
                              image: new AssetImage('$asset'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                backgroundImage:
                                    AssetImage("Assets/images/calories.png"),
                              ),
                              Text("$calories",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.043))
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                backgroundImage:
                                    AssetImage("Assets/images/duration.png"),
                              ),
                              Text(
                                "$duration S",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.043),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recomendación:",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("$recomendation",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02)),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
