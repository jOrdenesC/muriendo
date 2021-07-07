import 'dart:math';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Functions/Controllers/videoRecorderController.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import '../DetailsExercise/DetailsExcercise.dart';
import 'package:get_it/get_it.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

class VideosToRecord extends StatefulWidget {
  final List exercises;
  final double kCal;
  final String uuidQuestionary;
  final int number;
  final String idClass;
  final String phase;
  final bool isCustom;
  VideosToRecord(
      {this.exercises,
      this.kCal,
      this.idClass,
      this.number,
      this.uuidQuestionary,
      this.phase,
      this.isCustom});
  @override
  _VideosToRecordState createState() => _VideosToRecordState();
}

class _VideosToRecordState extends State<VideosToRecord>
    with TickerProviderStateMixin {
  VideoPlayerController videoPlayerController1;
  VideoPlayerController videoPlayerController2;
  var dir;
  VideoController videoController = Get.put(VideoController());
  String gifName = "Assets/images/C1.gif";
  String gifName2 = "Assets/images/C2.gif";

  ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    super.initState();
  }

  initdir() async {
    print(widget.exercises[0]);
    print(widget.exercises[1]);
    var dir = await getApplicationDocumentsDirectory();
    videoPlayerController1 = VideoPlayerController.file(
        File('${dir.path}/videos/${widget.exercises[0]}.webm'),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));

    videoPlayerController2 = VideoPlayerController.file(
        File('${dir.path}/videos/${widget.exercises[1]}.webm'),
        videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    //Obx(() => Text(videoController.gifName.value)),
    //This initialize the controller and allow us to build objects observing changes on the
    return GetX<VideoController>(
      init: VideoController(),
      builder: (_) {
        return WillPopScope(
          onWillPop: pop,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              toolbarHeight: 6.0.h,
              centerTitle: true,
              backgroundColor: cyan,
              elevation: 0,
              leading: SizedBox.shrink(),
              title: Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Grabación de ejercicios'.toUpperCase(),
                        style: TextStyle(fontSize: 15.0.sp),
                      )),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              width: w,
              height: 10.0.h,
              color: cyan,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _.loading.value != true
                      ? buttonRounded(context, func: () {
                          videoController.recordMovie(
                              widget.uuidQuestionary,
                              widget.idClass,
                              widget.kCal,
                              widget.number,
                              widget.exercises,
                              widget.phase,
                              widget.isCustom);
                        },
                          circleColor: Colors.transparent,
                          circleRadius: 4.5.w,
                          text: "   GRABAR",
                          icon: Icon(
                            Icons.videocam_rounded,
                            color: Colors.white,
                            size: Device.get().isTablet ? 7.0.w : 9.0.w,
                          ))
                      : SizedBox.shrink()
                ],
              ),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Transform.rotate(
                          // origin: Offset(-3.0.w, -3.0.w),
                          angle: pi * 0.5,
                          child: SvgPicture.asset("Assets/images/figure2.svg",
                              color: cyan, width: 40.0.w),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Transform.rotate(
                          // origin: Offset(-3.0.w, -3.0.w),
                          angle: pi * 2,
                          child: SvgPicture.asset("Assets/images/figure2.svg",
                              color: cyan, width: 40.0.w),
                        ),
                      ],
                    ),
                  ],
                ),
                // ignore: unrelated_type_equality_checks
                _.loading == false
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Transform.rotate(
                            // origin: Offset(-3.0.w, -3.0.w),
                            angle: pi * 2,
                            child: SvgPicture.asset(
                              "Assets/images/yellow.svg",
                              color: yellow,
                              fit: BoxFit.fill,
                              height: 40.0.h,
                              width: 100.0.w,
                            ),
                          ),
                        ],
                      )
                    : SizedBox.shrink(),
                Container(
                  // ignore: unrelated_type_equality_checks
                  child: _.loading == false
                      ? Column(children: [
                          SizedBox(
                            height: 10.0.h,
                          ),
                          InkWell(
                            onTap: () async {
                              print(1);
                              var res = await excerciseDataRepository
                                  .getExcerciseName(widget.exercises[0]);
                              Get.to(DetailsExcercise(
                                  widget.exercises[0],
                                  widget.exercises[0],
                                  res[0].mets.toString(),
                                  res[0].recommendation,
                                  false));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 80.0.w,
                                      height: 7.0.h,
                                      decoration: BoxDecoration(
                                          color: red,
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(50),
                                              bottomRight:
                                                  Radius.circular(50))),
                                      child: Center(
                                        child: AutoSizeText(
                                          "${widget.exercises[0]}",
                                          maxLines: 1,
                                          maxFontSize:
                                              Device.get().isTablet ? 35 : 25,
                                          minFontSize:
                                              Device.get().isTablet ? 18 : 8,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 5.0.w),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: red, width: 2)),
                                        width: 50.0.w,
                                        height: 20.0.h,
                                        child: AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: Image.asset(
                                            "Assets/thumbnails/${widget.exercises[0]}.jpeg",
                                            fit: BoxFit.fill,
                                          ),
                                        )
                                        // VideoPlayer(videoPlayerController1)

                                        )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 2.0.h,
                          ),
                          InkWell(
                            onTap: () async {
                              print(2);
                              var res = await excerciseDataRepository
                                  .getExcerciseName(widget.exercises[1]);
                              Get.to(DetailsExcercise(
                                  widget.exercises[1],
                                  widget.exercises[1],
                                  res[0].mets.toString(),
                                  res[0].recommendation,
                                  false));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 70.0.w,
                                      height: 7.0.h,
                                      decoration: BoxDecoration(
                                          color: red,
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(50),
                                              bottomLeft: Radius.circular(50))),
                                      child: Center(
                                        child: AutoSizeText(
                                          "${widget.exercises[1]}",
                                          maxLines: 1,
                                          maxFontSize:
                                              Device.get().isTablet ? 35 : 25,
                                          minFontSize:
                                              Device.get().isTablet ? 18 : 8,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 5.0.w),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 1.0.h,
                                    ),
                                    Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: red, width: 3)),
                                        width: 50.0.w,
                                        height: 20.0.h,
                                        child: Image.asset(
                                          "Assets/thumbnails/${widget.exercises[1]}.jpeg",
                                          fit: BoxFit.fill,
                                        ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5.0.h,
                          ),
                          Text(
                            'Graba por 30 segundos estos dos ejercicios',
                            style: TextStyle(fontSize: 14.0.sp, color: blue),
                            textAlign: TextAlign.center,
                          ),
                        ])
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: SpinKitWave(
                                size: 100,
                                color: blue,
                              ),
                            ),
                            SizedBox(
                              height: h * 0.04,
                            ),
                            Center(
                                child: Text(
                              "Procesando video...",
                              style: TextStyle(color: blue, fontSize: 30),
                            ))
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }

  @override
  void dispose() {
    videoPlayerController1.dispose();
    videoPlayerController2.dispose();
    super.dispose();
  }
}

Widget activityWidget(
    GifController controller, String gifName, String title, Function f) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: GifImage(
          controller: controller,
          image: AssetImage(gifName),
        ),
        title: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
        ),
        onTap: f,
      ),
    ),
  );
}
