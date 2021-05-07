import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class OfflineDataPage extends StatefulWidget {
  final OfflineData offlineData;
  final String session;

  OfflineDataPage({this.offlineData, this.session});
  @override
  _OfflineDataPageState createState() => _OfflineDataPageState();
}

class _OfflineDataPageState extends State<OfflineDataPage> {
  VideoPlayerController _controller;
  ChewieController chewieController;
  bool showControls = false;

  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.offlineData.uriVideo))
      ..initialize().then((value) {
        setState(() {});
      });

    chewieController = ChewieController(
        aspectRatio: 1 / 2,
        allowPlaybackSpeedChanging: false,
        showControls: true,
        showControlsOnInitialize: false,
        videoPlayerController: _controller);

    // chewieController.addListener(() {
    //   if (chewieController.isFullScreen) {
    //     setState(() {
    //       showControls = true;
    //     });
    //   } else {
    //     setState(() {
    //       showControls = false;
    //     });
    //   }
    // });
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
            FittedBox(
                fit: BoxFit.fitWidth, child: Text("DETALLES DE EVIDENCIA")),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 3.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
                width: 30.0.w,
                height: 6.0.h,
                child: Center(
                  child: Text(
                    "${widget.offlineData.totalKilocalories.toInt()} Kcal.",
                    style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Center(
            child: Container(
              color: Colors.black,
              width: 90.0.w,
              height: 35.0.h,
              child: _controller.value.initialized
                  ? Center(
                      child: Chewie(controller: chewieController),
                    )
                  : Center(
                      child: Image.asset(
                        "Assets/videos/loading.gif",
                        width: 70.0.w,
                        height: 15.0.h,
                        fit: BoxFit.contain,
                      ),
                    ),
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Container(
            height: 6.0.h,
            color: cyan,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "FASE: ${widget.offlineData.phase}",
                  style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                ),
                Text(
                  "SESIÓN: ${widget.session}",
                  style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                )
              ],
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40),
                          bottomRight: Radius.circular(40))),
                  height: 7.0.h,
                  width: 45.0.w,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                    "Ejercicio 1: ${widget.offlineData.exercises[0]}",
                    style: TextStyle(color: Colors.white),
                  ),
                      ))),
            ],
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: green,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(40))),
                  height: 7.0.h,
                  width: 45.0.w,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                    "Ejercicio 2: ${widget.offlineData.exercises[1]}",
                    style: TextStyle(color: Colors.white),
                  ),
                      ))),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    chewieController.dispose();
  }
}
