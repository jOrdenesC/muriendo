import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:clippy_flutter/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Functions/Controllers/OtherController.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage>
    with TickerProviderStateMixin {
  Orientation orientation;
  //bool isPause = false;
  OtherController otherController = Get.put(OtherController());
  final _key = GlobalKey();
  final _key2 = GlobalKey();
  @override
  void initState() {
    otherController.startTimer2();
    otherController.getData();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    //print(otherController.index);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      orientation = MediaQuery.of(context).orientation;
    });
    orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return GetX<OtherController>(
        init: OtherController(),
        builder: (_) {
          if (_.startgif == true) {}

          return Scaffold(
            bottomNavigationBar: orientation == Orientation.landscape
                ? SizedBox.shrink()
                : _.startgif == true
                    ? Container(
                        width: 100.0.w,
                        height: 10.0.h,
                        color: cyan,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buttonRounded(
                              context,
                              func: () {
                                if (_.gif.value == false) {
                                  _.pauseController();
                                } else {
                                  // Get.to(Calories());
                                }
                                // setState(() {
                                //   isPause = !isPause;
                                // });
                              },
                              icon: Icon(
                                _.isPause.value == false
                                    ? Icons.pause
                                    : Icons.play_arrow,
                                color: blue,
                                size: 4.0.h,
                              ),
                              text: _.isPause.value == false
                                  ? "PAUSAR"
                                  : "  REANUDAR",
                            )
                          ],
                        ),
                      )
                    : SizedBox.shrink(),
            backgroundColor: _.microPause.value
                ? _.index < 2
                    ? cyan
                    : _.index < 9
                        ? green
                        : yellow
                : blue,
            appBar: orientation == Orientation.landscape
                ? null
                : AppBar(
                    backgroundColor: cyan,
                    elevation: 0,
                    leading: IconButton(
                      icon: Icon(Icons.arrow_back,
                          size: 12.0.w, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    title: Column(
                      children: [
                        SizedBox(
                          height: 2.0.h,
                        ),
                        FittedBox(
                            fit: BoxFit.fitWidth, child: Text("Sesión 1")),
                      ],
                    ),
                    centerTitle: true,
                  ),
            body: _.startgif == false
                ? orientation == Orientation.portrait
                    ? preparePortrait()
                    : prepareLandscape()
                : _.demonstration.value == true
                    ? orientation == Orientation.portrait
                        ? demostrationExcercisePortrait(_)
                        : demostrationExcerciseLandscape(_)
                    : OrientationBuilder(
                        builder: (context, orientation) {
                          if (orientation == Orientation.portrait) {
                            return _.microPause.value == false
                                ? portraitDesign(_)
                                : pausePortrait(_);
                          } else {
                            return _.microPause.value == false
                                ? landscapeDesign(_)
                                : pauseLandscape(_);
                          }
                        },
                      ),
          );
        });
  }

  Widget pauseLandscape(OtherController _) {
    return Stack(
      children: [
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
                      color: blue, width: 45.0.w),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("Assets/images/figure2.svg",
                    color: blue, width: 45.0.w),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(height: 30.0.w),
                    Text(
                      "¿Sabías que...",
                      style: TextStyle(
                        fontSize: 10.0.w,
                        color: Colors.white,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1, 1),
                            blurRadius: 3.0,
                            color: blue,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Message(
                  clipShadows: [
                    ClipShadow(color: blue, elevation: 5),
                  ],
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20))),
                    width: 50.0.h,
                    height: 65.0.w,
                    child: Center(
                        child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _.tips[_.index.value],
                                style: TextStyle(
                                  fontSize: 6.0.w,
                                  color: blue,
                                  shadows: <Shadow>[
                                    // Shadow(
                                    //   offset: Offset(1, 1),
                                    //   blurRadius: 3.0,
                                    //   color: yellow,
                                    // ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Text(""),
                          Text(
                            _.tipsData[_.index.value],
                            style: TextStyle(fontSize: 3.0.h, color: blue),
                          )
                        ],
                      ),
                    )),
                  ),
                  triangleX1: 80.0.w,
                  triangleX2: 60.0.w,
                  triangleX3: 85.0.w,
                  triangleY1: 10.0.w,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Container(
                        child: Center(
                          child: Stack(
                            children: <Widget>[
                              gifImage(_),
                            ],
                          ),
                        ),
                        color: Colors.white,
                        width: 50.0.w,
                        height: 15.0.h,
                      ),
                      Text(
                        "SIGUIENTE EJERCICIO",
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                      ),
                      circTimer(_)
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget pausePortrait(OtherController _) {
    return Stack(
      children: [
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
                      color: blue, width: 50.0.w),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset("Assets/images/figure2.svg",
                    color: blue, width: 50.0.w),
              ],
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Container(
                        child: gifImage(_),
                        color: Colors.white,
                        width: 50.0.w,
                        height: 15.0.h,
                      ),
                      Text(
                        "SIGUIENTE EJERCICIO",
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                      )
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "¿Sabías que...",
                  style: TextStyle(
                    fontSize: 5.0.w,
                    color: Colors.white,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 3.0,
                        color: blue,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10.0.w,
                ),
              ],
            ),
            Container(
              width: 80.0.w,
              height: 30.0.h,
              child: Message(
                clipShadows: [
                  ClipShadow(color: blue, elevation: 5),
                ],
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(20))),
                  width: 80.0.w,
                  height: 30.0.h,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _.tips[_.index.value],
                              style: TextStyle(
                                fontSize: 6.0.w,
                                color: blue,
                                shadows: <Shadow>[
                                  // Shadow(
                                  //   offset: Offset(1, 1),
                                  //   blurRadius: 3.0,
                                  //   color: yellow,
                                  // ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Text(""),
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            _.tipsData[_.index.value],
                            style: TextStyle(fontSize: 2.5.h, color: blue),
                          ),
                        )
                      ],
                    ),
                  )),
                ),
                triangleX1: 75.0.w,
                triangleX2: 65.0.w,
                triangleX3: 75.0.w,
                triangleY1: 10.0.w,
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: blue,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(80),
                          bottomRight: Radius.circular(80))),
                  width: 10.0.h,
                  child: Row(
                    children: [
                      Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: 20.0.w,
                      ),
                      SizedBox(
                        width: 1.5.w,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 30.0.w,
                ),
                circTimer(_),
              ],
            ))
          ],
        ),
      ],
    );
  }

  Widget landscapeDesign(OtherController _) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          child: Center(child: gifImage(_)),
          height: double.infinity,
          color: Colors.white,
          width: 75.0.h,
        ),
        Container(
          width: 25.0.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 2.0.w,
              ),
              SizedBox(
                height: 2.0.w,
              ),
              Container(
                decoration: BoxDecoration(
                    color: cyan,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(80))),
                width: 10.0.h,
                child: Row(
                  children: [
                    Icon(
                      Icons.volume_up_rounded,
                      color: Colors.white,
                      size: w * 0.08,
                    ),
                    SizedBox(
                      width: w * 0.015,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 2.0.w,
              ),
              Container(
                height: 50.0.w,
                width: 25.0.h,
                child: Center(child: circTimer(_)),
              ),
              SizedBox(
                height: 1.0.w,
              ),
              Expanded(
                child: Container(
                  width: 25.0.h,
                  color: cyan,
                  child: Center(
                      child: buttonRounded(context, func: () {
                    if (_.gif.value == false) {
                      _.pauseController();
                    } else {
                      // Get.to(Calories());
                    }
                  },
                          text: _.isPause.value == false
                              ? "PAUSAR"
                              : "  REANUDAR",
                          icon: Icon(
                            _.isPause.value == false
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: blue,
                            size: 4.0.h,
                          ))),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget portraitDesign(OtherController _) {
    var w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        SizedBox(
          height: 2.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                    Icons.volume_up_outlined,
                    color: Colors.white,
                    size: 15.0.w,
                  ),
                  SizedBox(
                    width: 2.0.w,
                  )
                ],
              ),
              width: 25.0.w,
              height: 10.0.h,
              decoration: BoxDecoration(
                  color: cyan,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      bottomLeft: Radius.circular(80))),
            )
          ],
        ),
        SizedBox(
          height: 2.0.h,
        ),
        //GIF HERE ⬇⬇⬇⬇
        Container(
            width: w,
            height: 40.0.h,
            color: Colors.white,
            child: Center(child: gifImage(_))),
        SizedBox(
          height: 2.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //COUNTDOWN TIMER HERE ⬇⬇⬇⬇
            Container(
              child: Center(
                child: circTimer(_),
              ),
              width: 40.0.w,
              height: 18.0.h,
            )
          ],
        ),
      ],
    );
  }

  Widget gifImage(OtherController _) {
    return Stack(
      children: <Widget>[
        ColorFiltered(
          colorFilter: _.microPause.value == true
              ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
              : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
        ),
      ],
    );
  }

  Widget centerPrepare() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
        ),
        Center(
          child: Text(
            "Prepárate \n${otherController.startcounter}",
            style: TextStyle(
              fontSize: 30,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget preparePortrait() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: cyan, width: 90.0.w),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "Assets/images/LogoCompleto.png",
                    width: 20.0.w,
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 30.0.h,
              ),
              Container(
                child: Center(
                    child: Text(
                  "Prepárate \n${otherController.startcounter}",
                  style: TextStyle(color: blue, fontSize: 6.0.h),
                  textAlign: TextAlign.center,
                )),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget prepareLandscape() {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: cyan, width: 90.0.w),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                height: 10.0.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 15.0.h,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0.h,
                      ),
                      Container(
                        child: Center(
                            child: Text(
                          "Prepárate \n${otherController.startcounter}",
                          style: TextStyle(color: blue, fontSize: 6.0.h),
                          textAlign: TextAlign.center,
                        )),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 5.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 30.0.h,
                      ),
                      Image.asset(
                        "Assets/images/LogoCompleto.png",
                        width: 20.0.w,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget circTimer(OtherController _) {
    return InkWell(
      // onTap: () {
      //   _.controllerCountDown.pause();
      // },
      child: CircularCountDownTimer(
        key: _key2,
        controller: _.controllerCountDown,
        duration: _.returnTimer(),
        //Change time if micropause is selected
        color: green,
        fillColor: Colors.white,
        backgroundColor: yellow,
        strokeWidth: 10.0,
        textStyle: TextStyle(
            fontFamily: "Gotham",
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        isReverse: true,
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width / 2.5,
        onComplete: () {
          _.controllTimer();
        },
      ),
    );
  }

  Widget circTimerDemostration(OtherController _) {
    return InkWell(
      onTap: () {
        _.controllerDemostration.pause();
      },
      child: CircularCountDownTimer(
        key: _key,
        //UniqueKey(),
        controller: _.controllerCountDown,

        duration: 15,
        //Change time if micropause is selected
        color: green,
        fillColor: Colors.white,
        backgroundColor: yellow,
        strokeWidth: 10.0,
        textStyle: TextStyle(
            fontFamily: "Gotham",
            fontSize: 30.0,
            color: Colors.white,
            fontWeight: FontWeight.bold),
        isReverse: true,
        height: MediaQuery.of(context).size.height / 2.5,
        width: MediaQuery.of(context).size.width / 2.5,
        onComplete: () {
          _.demonstration.value = false;
        },
      ),
    );
  }

  Widget demostrationExcercisePortrait(OtherController _) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: cyan, width: 90.0.w),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    "Assets/images/LogoCompleto.png",
                    width: 20.0.w,
                  ),
                  SizedBox(
                    width: 10.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: 7.0.h,
              ),
              Container(
                  width: 100.0.w,
                  height: 35.0.h,
                  color: blue,
                  child: Center(
                      child: Image(
                    width: 100.0.w,
                    height: 100.0.h,
                    fit: BoxFit.fill,
                    image: AssetImage(_.gifName),
                  ))),
              SizedBox(
                height: 3.0.h,
              ),
              Text("Observa y aprende el ejercicio",
                  style: TextStyle(color: blue, fontSize: 5.0.w)),
              SizedBox(
                height: 3.0.h,
              ),
              Container(
                width: 40.0.w,
                height: 17.0.h,
                child: Center(
                  child: circTimerDemostration(_),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget demostrationExcerciseLandscape(OtherController _) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1.5,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: cyan, width: 70.0.w),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 4.0.h,
                    ),
                    Container(
                      width: 100.0.w,
                      height: 35.0.h,
                      color: blue,
                      child: Center(
                          child: Image(
                        width: 100.0.w,
                        height: 100.0.h,
                        fit: BoxFit.fill,
                        image: AssetImage(_.gifName),
                      )),
                    ),
                    SizedBox(
                      height: 2.0.h,
                    ),
                    Text("Observa y aprende el ejercicio",
                        style: TextStyle(color: blue, fontSize: 5.0.w)),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 25.0.h,
                  ),
                  Container(
                    width: 40.0.w,
                    height: 17.0.h,
                    child: Center(
                      child: circTimerDemostration(_),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Image.asset(
                        "Assets/images/LogoCompleto.png",
                        width: 20.0.w,
                      ),
                      SizedBox(
                        width: 10.0.w,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
