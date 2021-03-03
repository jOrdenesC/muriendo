import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DownloadTeacher {
  var dio = Dio();

  // downloadVideosTest(List videoList) async {
  //   log(videoList.toString());
  //   List<Future> listDio = [];
  //   List dataNotDownloaded = [];
  //   var prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString("token");
  //   var dir = await getApplicationDocumentsDirectory();
  //   var format = "";
  //   // String path = p.join("/storage/emulated/0/Movitronia/videos/");
  //   if (Platform.isAndroid) {
  //     format = ".webm";
  //     print("${dir.path}/videos/${videoList[0]}$format");
  //   } else if (Platform.isIOS) {
  //     format = ".mp4";
  //     print("${dir.path}/videos/${videoList[0]}$format");
  //   }
  //   Response response2 = await dio.post(
  //       "https://intranet.movitronia.com/api/mobile/videos?token=$token",
  //       data: {"platform": "android", "videoList": videoList});

  //   print("Response Video List: ${response2.data.length}");

  //   for (int i = 0; i < response2.data.length; i++) {
  //     print(response2.data[i] + "  ${i.toString()}");
  //     //Try Catch
  //     try {
  //       // data.add({
  //       //   "link": response2.data[i].toString(),
  //       //   "route": "$path/${videoList[i]}$format",
  //       //   "index": i.toString()
  //       // });

  //       listDio.add(dio.download(
  //           //
  //           response2.data[i],
  //           '${dir.path}/videos/${videoList[i]}$format',
  //           onReceiveProgress: (rec, total) {
  //         if (rec == total) {
  //           print(i.toString() + " descargado");
  //         } else {
  //           dataNotDownloaded.add(response2.data[i]);
  //         }
  //       }));
  //     } catch (e) {
  //       log(e);
  //     }
  //   }

  //   // print(listDio[282].toString());
  //   // log(data.toList().toString());
  //   try {
  //     await Future.wait(listDio, eagerError: true);
  //   } catch (e) {
  //     print(e);
  //   }

  //   print(dataNotDownloaded.toList().toString());
  //   // for (var i = 0; i < res.length; i++) {
  //   //   print(i);
  //   //   print(res[i].toString());
  //   // }
  //   // print(res[0]);
  //   print("ok");
  // }
  
  getExercises(BuildContext context) async {
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
      //This segment Downloads and create objects on the database
      final result = await _excerciseRepository.insertExcercise(excercisedata);
      print(result);
    }
    var w;
    loading(
      context,
      title: Text(
        "Descargando vídeos",
        style: TextStyle(color: blue, fontSize: 6.0.w),
        textAlign: TextAlign.center,
      ),
      content: Column(
        children: [
          Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
    // await videoDownload(videos);
    // await downloadVideosTest(videos);
  }
}
