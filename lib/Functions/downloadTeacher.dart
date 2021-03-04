import 'dart:io';

import 'package:archive/archive.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DownloadTeacher {
  Future downloadFiles(
      {String url,
      String filename,
      BuildContext context,
      String messageAlert,
      String route,
      String platform}) async {
    var dir = await getApplicationDocumentsDirectory();
    var progress = 0.0;
    loading(context,
        content: Center(
          child: Column(
            children: [
              Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
        title: Text(
          "$messageAlert",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 6.0.w),
        ));
    var dio = Dio();
    await dio.download(url, "${dir.path}/$route/$filename",
        onReceiveProgress: (rec, total) {
      progress = (rec / total) * 100;
      print("$progress %");
    });
    if (route == "videos") {
      await unarchiveAndSaveVideos(
          File("${dir.path}/$route/$filename"), context, route, platform);
    } else {
      await unarchiveAndSave(
          File("${dir.path}/$route/$filename"), context, route, platform);
    }

    print("finish");
    return null;
  }

  Future unarchiveAndSave(var zippedFile, BuildContext context, String route,
      String platform) async {
    var dir = await getApplicationDocumentsDirectory();
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = "${dir.path}/$route/${file.name}";
      if (file.isFile) {
        var outFile = File(fileName);
        print('file: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }
    Navigator.pop(context);
    return null;
  }

  Future unarchiveAndSaveVideos(var zippedFile, BuildContext context,
      String route, String platform) async {
    var dir = await getApplicationDocumentsDirectory();
    var bytes = zippedFile.readAsBytesSync();
    var archive = ZipDecoder().decodeBytes(bytes);
    for (var file in archive) {
      var fileName = platform == "ios"
          ? "${dir.path}/$route/${file.name}".replaceAll(" ", "")
          : "${dir.path}/$route/${file.name}";
      if (file.isFile) {
        var outFile = File(fileName);
        print('file: ' + outFile.path);
        outFile = await outFile.create(recursive: true);
        await outFile.writeAsBytes(file.content);
      }
    }

    Navigator.pop(context);
    return null;
  }

  getExercises(BuildContext context) async {
    var dio = Dio();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      var prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("token");
      Response response2 = await dio.get(
          "https://intranet.movitronia.com/api/mobile/exercises?token=$token");
      var responseobject = response2.data;
      List<String> videos = [];
      List<String> audios = [];
      ExcerciseDataRepository _excerciseRepository = GetIt.I.get();

      for (int i = 0; i < responseobject.length; i++) {
        // print(responseobject[i]['url']);
        ExcerciseData excercisedata = ExcerciseData(
            exerciseID: int.parse(responseobject[i]['exerciseId']),
            excerciseNameAudioId: responseobject[i]['exerciseNameAudioId'],
            recomendationAudioId: responseobject[i]['recomendationAudioId'],
            videoName: responseobject[i]['videoName'],
            mets: responseobject[i]['metsPerMinute'],
            nameExcercise: responseobject[i]['exerciseName'],
            recommendation: responseobject[i]['recomendation'],
            categories: responseobject[i]['categories'],
            level: responseobject[i]['levels'],
            stages: responseobject[i]['stages']);
        videos.add(excercisedata.videoName);
        if (excercisedata.excerciseNameAudioId.isNotEmpty) {
          audios.add(excercisedata.excerciseNameAudioId);
        }
        if (excercisedata.recomendationAudioId.isNotEmpty) {
          audios.add(excercisedata.recomendationAudioId);
        }

        var res = await _excerciseRepository
            .getExcerciseID(int.parse(responseobject[i]['exerciseId']));
        if (res.isEmpty) {
          final result =
              await _excerciseRepository.insertExcercise(excercisedata);
          print(result);
        } else {
          print("Ya existe este ejercicio");
        }
      }
      print("Response ${response2.data[0]}");
      prefs.setBool("downloaded", true);
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
    }
    Navigator.pop(context);
  }
}
