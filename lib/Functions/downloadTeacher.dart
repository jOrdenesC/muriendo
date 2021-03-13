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
import '../Functions/Controllers/mp4Controller.dart';

class DownloadTeacher {
  

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
            stages: responseobject[i]['stages'],
            idMongo: responseobject[i]["_id"]);
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
  }
}
