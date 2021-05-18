import 'dart:io';

import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class DetailsExcercise extends StatefulWidget {
  final String nameVideo;
  final String name;
  final String kcal;
  final String desc;
  final bool isTeacher;
  DetailsExcercise(
      this.nameVideo, this.name, this.kcal, this.desc, this.isTeacher);
  @override
  _DetailsExcerciseState createState() => _DetailsExcerciseState();
}

class _DetailsExcerciseState extends State<DetailsExcercise> {
  VideoPlayerController videoPlayerController1;
  AudioCache audioCache = AudioCache();
  AudioPlayer audioPlayer = AudioPlayer();
  ExcerciseDataRepository _excerciseRepository = GetIt.I.get();
  var dir;
  var audioRecommendation;
  @override
  void initState() {
    super.initState();
    getWeight();
  }

  @override
  void dispose() {
    if (widget.isTeacher == false) {
      audioPlayer.dispose();
    }
    videoPlayerController1.dispose();
    imageCache.clear();
    super.dispose();
  }

  var weight;
  getWeight() async {
    dir = await getApplicationDocumentsDirectory();
    var prefs = await SharedPreferences.getInstance();
    var res = prefs.getString("weight");
    setState(() {
      weight = res;
    });

    final result = await _excerciseRepository.getExcerciseName(widget.name);
    print(result[0].recomendationAudioId);
    await init(widget.name, result[0].recomendationAudioId);
  }

  init(String name, String audioName) async {
    var format;
    if (Platform.isAndroid) {
      format = ".webm";
    } else if (Platform.isIOS) {
      format = ".mp4";
    }
    videoPlayerController1 = VideoPlayerController.file(
        File('${dir.path}/videos/${widget.nameVideo}$format'));

    await videoPlayerController1
      ..initialize().then((value) => null)
      ..setLooping(true)
      ..play();
    Future.delayed(const Duration(milliseconds: 500), () async {
// Here you can write your code
      if (widget.isTeacher == false) {
        await playAudio(audioName);
      }
      setState(() {
        // Here you can write your code for open new view
      });
    });
  }

  playAudio(String audioName) async {
    print("Play Audio");
    if (Platform.isIOS) {
      if (audioCache.fixedPlayer != null) {
        audioCache.fixedPlayer.startHeadlessService();
      }
    }
    //Testing Out a List with audio Names
    //audioPlayer = await audioCache.play('audio/${exercisesAudio[index.value]}');
    await audioPlayer.play("${dir.path}/audios/$audioName.mp3");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(
              context,
              func: () {
                Navigator.pop(context);
              },
              text: "   CERRAR",
            )
          ],
        ),
      ),
      backgroundColor: blue,
      appBar: AppBar(
        toolbarHeight: 6.0.h,
        backgroundColor: cyan,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              size: Device.get().isTablet ? 7.0.w : 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  '${widget.name}'.toUpperCase(),
                  style: TextStyle(fontSize: 15.0.sp),
                )),
          ],
        ),
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
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                widget.isTeacher
                    ? Text(
                        "Mets: ",
                        style: TextStyle(color: Colors.white, fontSize: 7.0.w),
                      )
                    : Icon(
                        Icons.local_fire_department,
                        color: cyan,
                        size: 7.0.w,
                      ),
                widget.isTeacher
                    ? Text(widget.kcal,
                        style: TextStyle(color: Colors.white, fontSize: 7.0.w))
                    : Text(
                        " ${double.parse(widget.kcal).toInt()} Kcal/min",
                        style: TextStyle(color: cyan, fontSize: 6.0.w),
                      ),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.03,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 43.0.h,
                  width: 100.0.w,
                  child: VideoPlayer(videoPlayerController1),
                )
                /*Image(
                  width: 100.0.w,
                  fit: BoxFit.fill,
                  image: AssetImage('Assets/thumbnails/${args["name"]}.png'),
                ),*/
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.03,
                ),
                // Text(
                //   "${args["duration"]} Seg ",
                //   style: TextStyle(color: cyan, fontSize: 6.0.w),
                // ),
                // Icon(Icons.alarm, color: cyan, size: 7.0.w,)
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: Center(
                      child: Text(
                    "RECOMENDACIÓN",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 5.0.w,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )),
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  width: 70.0.w,
                  height: 6.0.h,
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              child: Text(
                widget.desc,
                style: TextStyle(color: Colors.white, fontSize: 12.0.sp),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}
