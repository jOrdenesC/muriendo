import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_time_button/flutter_time_button.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
//import 'package:movitronia/Functions/Controllers/VideoController.dart';
import 'package:movitronia/Functions/Controllers/mp4Controller.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:screen/screen.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Widgets/Toast.dart';

//import '../../../Functions/Controllers/VideoController.dart';

class ExcerciseVideo extends StatefulWidget {
  final String id;
  final List questionnaire;
  final int number;
  final String phase;
  final bool isCustom;
  ExcerciseVideo(
      this.id, this.questionnaire, this.number, this.phase, this.isCustom);
  @override
  _ExcerciseVideoState createState() => _ExcerciseVideoState();
}

class _ExcerciseVideoState extends State<ExcerciseVideo>
    with TickerProviderStateMixin {
  Orientation orientation;
  //bool isPause = false;
  Mp4Controller mp4Controller = Mp4Controller();
  bool dev = false;
  int count = 0;
  final key = GlobalKey();
  final key2 = GlobalKey();

  @override
  void initState() {
    getRole();
    Screen.keepOn(true);
    //

    //----------------- -----------------------------------//
    //webmController.initializePlayer();
    imageCache.maximumSize = 0;
    mp4Controller.startTimer2();

    mp4Controller.getData(widget.id);
    //webmController.playAudio();
    //webmController.controller = GifController(vsync: this);

    WidgetsBinding.instance.addPostFrameCallback((_) {});
    //print(otherController.index);
    super.initState();
  }

  @override
  void dispose() {
    //webmController.controller.dispose();
    mp4Controller.timer?.cancel();
    mp4Controller.videoPlayerController1 = null;
    mp4Controller.videoPlayerController1.dispose();
    imageCache.clear();

    super.dispose();
  }

  getRole() async {
    var prefs = await SharedPreferences.getInstance();
    var dev1 = prefs.getBool("dev");
    if (dev1 == null) {
      setState(() {
        dev = false;
      });
    } else {
      setState(() {
        dev = dev1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
    setState(() {
      orientation = MediaQuery.of(context).orientation;
    });
    orientation == Orientation.landscape
        ? SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom])
        : SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    return GetX<Mp4Controller>(
        init: mp4Controller,
        builder: (_) {
          if (_.startgif == true) {
            @override
            void dispose() {
              super.dispose();
            }
          }

          return WillPopScope(
            onWillPop: pop,
            child: Scaffold(
              floatingActionButton: dev
                  ? _.demonstration.value == false
                      ? SizedBox(
                          width: 140,
                          child: TimeButton(
                              label: "Espera para avanzar",
                              timeout: 3,
                              onPressed: () {
                                _.controllTimer(
                                    widget.id,
                                    widget.questionnaire,
                                    widget.number,
                                    widget.phase,
                                    widget.isCustom);
                              },
                              toastMessage: "Adelantado"),
                        )
                      : SizedBox.shrink()
                  : SizedBox.shrink(),
              bottomNavigationBar: orientation == Orientation.landscape
                  ? SizedBox.shrink()
                  :
                  // _.isPause.value == false
                  //     ? SizedBox.shrink()
                  //     :

                  _.macroPause.value || _.microPause.value
                      ? SizedBox.shrink()
                      : Container(
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
                                    goToUploadData();
                                  }
                                  // setState(() {
                                  //   isPause = !isPause;
                                  // });
                                },
                                circleRadius: 4.0.w,
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
                        ),
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
                      toolbarHeight: 6.0.h,
                      backgroundColor: cyan,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(Icons.arrow_back,
                            size: Device.get().isTablet ? 7.0.w : 9.0.w,
                            color: Colors.white),
                        onPressed: () => pop(),
                      ),
                      title: Column(
                        children: [
                          SizedBox(
                            height: 2.0.h,
                          ),
                          FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                "SESIÓN ${widget.number}",
                                style: TextStyle(fontSize: 5.0.w),
                              )),
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
                                  : _.macroPause.value == true
                                      ? macroPausePortrait(_)
                                      : pausePortrait(_);
                            } else {
                              return _.microPause.value == false
                                  ? landscapeDesign(_)
                                  : _.macroPause.value
                                      ? macroPauseLandscape(_)
                                      : pauseLandscape(_);
                            }
                          },
                        ),
            ),
          );
        });
  }

  Widget pauseLandscape(Mp4Controller _) {
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
                    SizedBox(height: 20.0.w),
                    Text(
                      "Tips",
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
                Stack(
                  children: [
                    SvgPicture.asset("Assets/figures/micro.svg"),
                    Container(
                      margin: EdgeInsets.only(top: 50, left: 50),
                      // color: red,
                      width: 35.0.h,
                      height: 55.0.w,
                      child: Column(
                        children: [
                          Text(
                            _.tipsData[_.globalindex.value - 1].toUpperCase(),
                            style: TextStyle(
                              fontSize:
                                  _.tipsData[_.globalindex.value - 1].length >
                                          80
                                      ? 2.0.h
                                      : 2.5.h,
                              color: blue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                            children: <Widget>[webpVideo(_)],
                          ),
                        ),
                        color: Colors.white,
                        width: 50.0.w,
                        height: 15.0.h,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Text(
                          "${_.excerciseNames[_.globalindex.value]}",
                          style:
                              TextStyle(color: Colors.white, fontSize: 5.0.w),
                        ),
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

  Widget pausePortrait(Mp4Controller _) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        height: Device.get().isTablet ? 3.0.h : 2.0.h,
                      ),
                      Container(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                              Colors.grey, BlendMode.saturation),
                          child: AspectRatio(
                            aspectRatio: 4 / 3,
                            child: webpVideo(_),
                          ),
                        ),
                        color: Colors.white,
                        width: Device.get().isTablet ? 40.0.w : 50.0.w,
                        //height: Device.get().isTablet ? 20.0.h : 15.0.h,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: Device.get().isTablet ? 50.0.w : 70.0.w,
                          child: Text(
                            " " + _.excerciseNames[_.globalindex.value] + " ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize:
                                    Device.get().isTablet ? 13.0.sp : 10.0.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Transform.rotate(
                  angle: pi / -45,
                  child: Text(
                    "¿Sabias que ...",
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
                ),
                SizedBox(
                  width: 15.0.w,
                ),
              ],
            ),
            Stack(
              children: [
                Container(
                  width: Device.get().isTablet ? 80.0.w : 99.0.w,
                  height: Device.get().isTablet ? 42.0.h : 40.0.h,
                  child: SvgPicture.asset("Assets/figures/micro.svg",
                      fit: BoxFit.contain),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: Device.get().isTablet ? 65.0.w : 80.0.w,
                        height: Device.get().isTablet ? 30.0.h : 25.0.h,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(""),
                            Text(""),
                            Text(""),
                            Text(""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 16.0.w,
                                ),
                                Flexible(
                                  flex: 2,
                                  child: Transform.rotate(
                                    angle: pi / -45,
                                    child: AutoSizeText(
                                      _.tipsData[_.globalindex.value - 1]
                                          .toUpperCase(),
                                      maxLines: 10,
                                      maxFontSize:
                                          Device.get().isTablet ? 20 : 15,
                                      minFontSize:
                                          Device.get().isTablet ? 18 : 8,
                                      style: TextStyle(
                                          fontSize: 20.0.sp, color: blue),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(child: circTimer(_))
          ],
        ),
      ],
    );
  }
/*
  Widget pausePortrait(Mp4Controller _) {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
                        child: webpVideo(_),
                        color: Colors.white,
                        width: 50.0.w,
                        height: 15.0.h,
                      ),
                      FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: 70.0.w,
                          child: Text(
                            " " + _.excerciseNames[_.globalindex.value] + " ",
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(fontSize: 4.0.w, color: Colors.white),
                          ),
                        ),
                      ),
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
                  "TIPS!",
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
            Stack(
              children: [
                Container(
                  width: 99.0.w,
                  height: 40.0.h,
                  child: SvgPicture.asset("Assets/figures/micro.svg",
                      fit: BoxFit.contain),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: 80.0.w,
                        height: 40.0.h,
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     SizedBox(
                            //       width: 10.0.w,
                            //     ),
                            //     /*Text(
                            //       _.tips[_.index.value],
                            //       style: TextStyle(
                            //         fontSize: 6.0.w,
                            //         color: blue,
                            //       ),
                            //     )*/
                            //   ],
                            // ),
                            Text(""),
                            Text(""),
                            Text(""),
                            Text(""),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: 11.0.w,
                                ),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    _.tipsData[_.globalindex.value - 1]
                                        .toUpperCase(),
                                    style: TextStyle(
                                        fontSize:
                                            _.tipsData[_.globalindex.value - 1]
                                                        .length >
                                                    85
                                                ? 2.05.h
                                                : 2.4.h,
                                        color: blue),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Expanded(child: circTimer(_))
          ],
        ),
      ],
    );
  }*/

  Widget landscapeDesign(Mp4Controller _) {
    var w = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Container(
          child: Center(child: webpVideo(_)),
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
                    InkWell(
                      onTap: () {
                        print("Button pressed");
                        _.controllTimer(widget.id, widget.questionnaire,
                            widget.number, widget.phase, widget.isCustom);
                      },
                      child: Icon(
                        Icons.volume_up_rounded,
                        color: Colors.white,
                        size: w * 0.08,
                      ),
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
                      goToUploadData();
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

  Widget portraitDesign(Mp4Controller _) {
    return Column(
      children: [
        SizedBox(
          height: 1.0.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [],
        ),
        SizedBox(
          height: 1.0.h,
        ),
        //GIF HERE ⬇⬇⬇⬇
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.blue.shade600, width: 2),
              color: green,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(
              " " + _.excerciseNames[_.globalindex.value] + " ",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 5.0.w, color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: Device.get().isTablet ? 1.0.h : 14.0.h,
        ),
        Container(
            color: Colors.white,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: Center(child: webpVideo(_)),
            )),
        SizedBox(
          height: 2.0.h,
        ),

        SizedBox(
          height: Device.get().isTablet ? 1.0.h : 5.0.h,
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //COUNTDOWN TIMER HERE ⬇⬇⬇⬇
            Container(
              child: Center(
                child: circTimer(_),
              ),
              width: Device.get().isTablet ? 36.0.w : 40.0.w,
              height: 14.0.h,
            )
          ],
        ),
      ],
    );
  }

  Widget macroPausePortrait(Mp4Controller _) {
    return Stack(
      children: [
        Container(
          height: 100.0.h,
          width: 100.0.w,
          color: blue,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                      origin: Offset(-10, Device.get().isTablet ? -45 : -10),
                      angle: pi / -2,
                      child: SvgPicture.asset(
                        "Assets/images/figure2.svg",
                        color: cyan,
                        width: 90.0.w,
                      )),
                ],
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset("Assets/images/LogoCompleto.png", width: 15.0.w),
                SizedBox(width: 10.0.w)
              ],
            ),
            SizedBox(
              height: 2.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      width: 90.0.w,
                      height: 60.0.h,
                      child: SvgPicture.asset(
                        "Assets/figures/macro.svg",
                        fit: BoxFit.contain,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: Device.get().isTablet ? 9.0.h : 10.0.h,
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: Device.get().isTablet ? 12.0.w : 5.0.w,
                                ),
                                FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Container(
                                      width: Device.get().isTablet
                                          ? 65.0.w
                                          : 80.0.w,
                                      height: Device.get().isTablet
                                          ? 40.0.h
                                          : 30.0.h,
                                      child: Transform.rotate(
                                          angle: pi / -55,
                                          child: Center(
                                            child: Obx(() => AutoSizeText(
                                                  "${mp4Controller.macroTip}"
                                                      .toUpperCase(),
                                                  maxLines: 13,
                                                  maxFontSize:
                                                      Device.get().isTablet
                                                          ? 35
                                                          : 25,
                                                  minFontSize:
                                                      Device.get().isTablet
                                                          ? 18
                                                          : 8,
                                                  style: TextStyle(
                                                      fontSize: 20.0.sp,
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center,
                                                )),
                                          ))),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Transform.rotate(
                  angle: pi / -20,
                  child: Text("APRENDE",
                      style: TextStyle(shadows: <Shadow>[
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 0.5,
                          color: cyan,
                        )
                      ], color: yellow, fontSize: 6.5.w)),
                ),
              ],
            ),
            Expanded(
              child: circTimer(_),
            )
          ],
        ),
      ],
    );
  }

  Widget macroPauseLandscape(Mp4Controller _) {
    return Stack(
      children: [
        Container(
          height: 100.0.w,
          width: 100.0.h,
          color: blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                      origin: Offset(-10, -10),
                      angle: pi / -2,
                      child: SvgPicture.asset(
                        "Assets/images/figure2.svg",
                        color: cyan,
                        width: 70.0.h,
                        height: 70.0.w,
                      )),
                ],
              ),
            ],
          ),
        ),
        Row(
          children: [
            SizedBox(
              width: 5.0.w,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        SvgPicture.asset(
                          "Assets/figures/macro.svg",
                          width: 80.0.w,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 13.0.h,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Container(
                                    width: 80.0.w,
                                    child: Obx(() => Text(
                                          "${mp4Controller.macroTip}"
                                              .toUpperCase(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 5.0.w),
                                          textAlign: TextAlign.center,
                                        ))),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform.rotate(
                      angle: pi / -20,
                      child: Text("APRENDE",
                          style: TextStyle(shadows: <Shadow>[
                            Shadow(
                              offset: Offset(1.5, 1.5),
                              blurRadius: 0.5,
                              color: cyan,
                            )
                          ], color: yellow, fontSize: 7.5.w)),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: 40.0.w,
                ),
                circTimer(_)
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          _.controllerCountDown.pause();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Image.asset("Assets/images/LogoCompleto.png",
                                width: 23.0.w),
                            SizedBox(
                              width: 1.0.w,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: cyan,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(80),
                                bottomLeft: Radius.circular(80))),
                        width: 25.0.w,
                        height: 10.0.h,
                        child: Row(
                          children: [
                            Icon(
                              Icons.volume_up_rounded,
                              color: Colors.white,
                              size: 20.0.w,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget webpVideo(Mp4Controller _) {
    return Stack(
      children: <Widget>[
        ColorFiltered(
          colorFilter: _.microPause.value == true
              ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
              : ColorFilter.mode(Colors.transparent, BlendMode.multiply),
          child: VideoPlayer(_.videoPlayerController1)
          //Chewie(controller: _.chewieController)
          /* GifImage(
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            controller: _.controller,
            image: AssetImage(_.webpName),
          )*/
          ,
        ),
      ],
    );
  }

  finished() {
    return Column(
      children: [
        Text("A"),
        SizedBox(
          height: 100.0.h,
          width: 100.0.w,
        )
        /* Image.asset(
          "Assets/images/clapping.png",
          width: MediaQuery.of(context).size.width * 0.4,
        ),
        Text(
          "¡Felicidades! \nHas completado la sesión",
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),*/
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
            "Prepárate \n${mp4Controller.startcounter}",
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
                    width: Device.get().isTablet ? 7.5.w : 20.0.w,
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
                  "Prepárate \n${mp4Controller.startcounter}",
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
                          "Prepárate \n${mp4Controller.startcounter}",
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

  Widget circTimer(Mp4Controller _) {
    return CircularCountDownTimer(
      key: key,
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
        _.controllTimer(widget.id, widget.questionnaire, widget.number,
            widget.phase, widget.isCustom);
      },
    );
  }

  Widget circTimerDemostration(Mp4Controller _) {
    return CircularCountDownTimer(
      controller: _.controllerCountDown,
      key: key2,
      duration: 5,
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
        _.playAudio(_.exercisesAudio[_.globalindex.value], false);
      },
    );
  }

  Widget demostrationExcercisePortrait(Mp4Controller _) {
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
                    width: Device.get().isTablet ? 5.0.w : 15.0.w,
                  ),
                  SizedBox(
                    width: Device.get().isTablet ? 2.0.w : 5.0.w,
                  ),
                ],
              ),
              SizedBox(
                height: Device.get().isTablet ? 1.0.h : 4.0.h,
              ),
              Container(
                  color: blue,
                  child: Center(
                      child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: webpVideo(_),
                  ) /*webpVideo(_)*/)),
              SizedBox(
                height: Device.get().isTablet ? 2.0.h : 3.0.h,
              ),
              Text("Observa y aprende el ejercicio",
                  style: TextStyle(color: blue, fontSize: 5.0.w)),
              SizedBox(
                height: Device.get().isTablet ? 1.0.h : 5.0.h,
              ),
              Container(
                width: 40.0.w,
                height: Device.get().isTablet ? 12.0.h : 15.0.h,
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

  Widget demostrationExcerciseLandscape(Mp4Controller _) {
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
                      child: Center(child: webpVideo(_)),
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
                        width: Device.get().isTablet ? 15.0.w : 20.0.w,
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

  Future<bool> pop() async {
    setState(() {
      count++;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            count = 0;
          });
        }
      });
    });
    if (Device.get().isAndroid) {
      if (count == 2) {
        Navigator.pop(context);
      } else if (count <= 1) {
        toast(context, "Presiona nuevamente para salir de la clase.", red);
      }
    } else {
      showAlertDialog(context);
    }

    return false;
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        child: CupertinoAlertDialog(
          title: Text("Salir de la clase"),
          content: Text("¿Estas Seguro que desas salir?"),
          actions: <Widget>[
            CupertinoDialogAction(
                isDefaultAction: true,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancelar")),
            CupertinoDialogAction(
                textStyle: TextStyle(color: Colors.red),
                isDefaultAction: true,
                onPressed: () async {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Salir")),
          ],
        ));
  }
}
