import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Models/ExcerciseData.dart';
import 'package:movitronia/Database/Models/QuestionData.dart';
import 'package:movitronia/Database/Models/ResponseModels/ResultClassModel.dart';
import 'package:movitronia/Database/Models/TipsData.dart';
import 'package:movitronia/Database/Models/evidencesSend.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'package:movitronia/Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';
import 'package:movitronia/Database/Repository/TipsDataRepository/TipsDataRepository.dart';
import 'package:movitronia/Database/Repository/QuestionDataRepository/QuestionDataRepository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Design/Widgets/Toast.dart';
import 'package:flutter/material.dart';
import '../Utils/Colors.dart';
import 'dart:developer';
import 'package:archive/archive.dart';
import '../Database/Models/courseModel.dart';
import '../Utils/UrlServer.dart';
import '../Utils/ConnectionState.dart';
import '../Design/Widgets/Loading.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';

class DownloadData {
  var dio = Dio();

  getUserData(BuildContext context) async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    CourseDataRepository courseDataRepository = GetIt.I.get();
    if (hasInternet) {
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      try {
        Response response =
            await dio.get("$urlServer/api/mobile/user/course?token=$token");
        if (response.statusCode == 200) {
          var res =
              await courseDataRepository.getCourseID(response.data[0]["_id"]);
          if (res.isEmpty) {
            var courseData = CourseData(
                courseId: response.data[0]["_id"],
                college: response.data[0]["college"],
                number: response.data[0]["number"],
                letter: response.data[0]["letter"],
                year: response.data[0]["year"]);
            await courseDataRepository.insertCourse(courseData);
            toast(context, "Datos descargados de curso", green);
          } else {
            print("ya existe el curso");
          }
        } else {
          toast(
              context,
              "Ha ocurrido un error al intentar obtener la información del curso. Inténtalo nuevamente.",
              red);
        }
      } catch (e) {
        print(e);
        toast(
            context,
            "Ha ocurrido un error al intentar obtener la información del curso. Inténtalo nuevamente.",
            red);
      }
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
    }
  }

  // downloadVideosTest(List videoList) async {
  //   log(videoList.toString());
  //   List<Future> listDio = [];
  //   List dataDownloaded = [];
  //   var prefs = await SharedPreferences.getInstance();
  //   var token = prefs.getString("token");
  //   var dir = await getApplicationDocumentsDirectory();
  //   var format = "";
  //   var platform = "";
  //   // String path = p.join("/storage/emulated/0/Movitronia/videos/");
  //   if (Platform.isAndroid) {
  //     format = ".webm";
  //     platform = "android";
  //     print("${dir.path}/videos/${videoList[0]}$format");
  //   } else if (Platform.isIOS) {
  //     format = ".mp4";
  //     platform = "ios";
  //     print("${dir.path}/videos/${videoList[0]}$format");
  //   }
  //   Response response2 = await dio.post(
  //       "https://intranet.movitronia.com/api/mobile/videos?token=$token",
  //       data: {"platform": platform, "videoList": videoList});

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
  //           response2.data[i], '${dir.path}/videos/${videoList[i]}$format',
  //           onReceiveProgress: (rec, total) {
  //         if (rec == total) {
  //           print(i.toString() + " descargado");
  //           dataDownloaded.add(response2.data[i]);
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

  //   List<Future> noExists = [];

  //   getDownloaded(response2, videoList) {
  //     response2.data.forEach((element) {
  //       if (!dataDownloaded.contains(element)) {
  //         noExists = response2.data
  //             .toSet()
  //             .difference(dataDownloaded.toSet())
  //             .toList();
  //         print("No descargado $element");
  //         noExists.add(dio.download(response2[element],
  //             '${dir.path}/videos/${videoList[element]}$format'));
  //       }
  //     });

  //     // for (var i = 0; i < videoList.length; i++) {
  //     //   if (videoList[i].contains(dataDownloaded[i])) {
  //     //     print("descargado $i");
  //     //   } else {
  //     //     print("no descargado");
  //     //     noExists.add(dio.download(
  //     //         videoList[i], '${dir.path}/videos/${videoList[i]}$format',
  //     //         onReceiveProgress: (rec, total) {
  //     //       if (rec == total) {
  //     //         print(i.toString() + " descargado");
  //     //         dataDownloaded.add(response2.data[i]);
  //     //       }
  //     //     }));
  //     //   }
  //     // }

  //     return true;
  //   }

  // if (videoList != dataDownloaded) {
  //   print("descargando los que no se descargaron");
  //   getDownloaded(response2, videoList);
  //   await Future.wait(noExists);
  // }

  //   print(dataDownloaded.toList().toString());
  //   // for (var i = 0; i < res.length; i++) {
  //   //   print(i);
  //   //   print(res[i].toString());
  //   // }
  //   // print(res[0]);
  //   print("ok");
  // }

  downloadAudiosTest(List audioList, String type) async {
    log(audioList.toList().toString());
    var dir = await getApplicationDocumentsDirectory();
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    List<Future> listDio = [];
    int downloaded = 0;
    // String path = p.join("/storage/emulated/0/Movitronia/audios/$type/");
    Response response2 = await Dio().post(
        "https://intranet.movitronia.com/api/mobile/audios?token=$token",
        data: {"type": "$type", "audioList": audioList});
    for (int i = 0; i < response2.data.length; i++) {
      print("${i.toString()} ${response2.data[i]}");
      try {
        // ${audioList[i]}
        listDio.add(Dio().download(
            response2.data[i], '${dir.path}/audios/${audioList[i]}.mp3',
            onReceiveProgress: (rec, total) {
          if (rec == total) {
            // print(i.toString() + " Descargado");
            downloaded++;
            print(downloaded);
          }
        }));
      } catch (e) {
        print(e.toString());
      }
    }
    print(listDio.toString());
    try {
      await Future.wait(listDio);
    } catch (e) {
      print("ERRORRR $e");
    }
  }

  getHttp(BuildContext context, String level) async {
    if (level.isEmpty) {
      toast(context, "No se ha encontrado un curso asignado.", red);
    } else {
      bool hasInternet = await ConnectionStateClass().comprobationInternet();
      if (hasInternet) {
        print("HTTP");
        print("INICIA DESCARGANDO DATOS");
        TipsDataRepository _tipsDataRepository = GetIt.I.get();
        QuestionDataRepository _questionDataRepository = GetIt.I.get();
        try {
          var prefs = await SharedPreferences.getInstance();
          String token = prefs.getString("token");
          loading(
            context,
            title: Text(
              "Descargando datos para crear clases...",
              style: TextStyle(color: blue, fontSize: 6.0.w),
              textAlign: TextAlign.center,
            ),
            content: Column(
              children: [
                // Text("${((received.value / totalData.value) * 100)}%"),
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
          Response responseClasses = await dio.get(
            "https://intranet.movitronia.com/api/mobile/classes/$level?token=$token",
          );
          print("RESPONSEEEEEEEEEEE ${responseClasses.data}");
          Navigator.pop(context);
          //getExercises();
          //await getClass(response);
          //testDownload();
          List<num> indexes = [];
          List<TipsData> tipsList = [];
          List<QuestionData> questionList = [];
          List<String> audioNames = [];
          print("Creando tips");
          loading(
            context,
            title: Text(
              "Creando tips y cuestionarios...",
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
          print("LENGTH " + responseClasses.data.length.toString());
          print("CLASSSSSSSSSSSSEES ${responseClasses.data}");
          var responsess = ResultModel.fromJson(responseClasses.data[0]);
          log("DAAAAAAAAAAAAAAAAAAAAAAATOS " + responsess.toJson().toString());
          for (int i = 0; i < responseClasses.data.length; i++) {
            print(i.toString() + " DATA DATA");
            Map responseBody =
                responseClasses.data[i]; //Loop through all objects
            print("PASÓ RESPONSEBODY");
            ResultModel jsonResponse = ResultModel.fromJson(responseBody);
            for (int i = 0; i < jsonResponse.tips.length; i++) {
              print("json RESPONSE $i");
              var tipsResponse = jsonResponse.tips[i];
              // print(tipsResponse.toJson().toString());
              if (indexes.contains(int.parse(tipsResponse.tipId))) {
                print("Repetido");
              } else {
                var audioQuestion;
                var audioTips;
                var audioVF;
                if (tipsResponse.audios.isNotEmpty) {
                  for (int i = 0; i < tipsResponse.audios.length; i++) {
                    if (tipsResponse.audios[i].type == "PREGUNTA") {
                      audioQuestion = tipsResponse.audios[i].link;
                    } else if (tipsResponse.audios[i].type == "TIPS") {
                      audioTips = tipsResponse.audios[i].link;
                    } else if (tipsResponse.audios[i].type == "VF") {
                      audioVF = tipsResponse.audios[i].link;
                    }
                  }
                } else {
                  audioQuestion = "[]";
                  audioTips = "[]";
                  audioVF = "[]";
                }

                print("#ENRTA A TIPS DATA");

                TipsData tipsData = TipsData(
                    audioQuestion: audioQuestion,
                    audioTips: audioTips,
                    audioVF: audioVF,
                    tipsID: int.parse(tipsResponse.tipId),
                    documentID: tipsResponse.sId,
                    tip: tipsResponse.tip);

                indexes.add(tipsData.tipsID);
                tipsList.add(tipsData);

                print("TIP Amount ${tipsResponse.audios.length}");
                for (int i = 0; i < tipsResponse.audios.length; i++) {
                  print("${tipsResponse.audios[i].link}");
                  audioNames.add(tipsResponse.audios[i].link);
                }
                print("TIP value of ${tipsData.tip}");
                var res = await _tipsDataRepository.getTips(tipsResponse.sId);
                if (res.isEmpty) {
                  await _tipsDataRepository.insertTips(tipsData);
                } else {
                  print("ya existe");
                  await _tipsDataRepository.updateTips(tipsData);
                }

                print("ENRTA A QUESTION DATA");
                QuestionData questionData = QuestionData(
                    tipID: tipsResponse.sId,
                    questionVf: tipsResponse.questions.questionVf,
                    correctVf: tipsResponse.questions.correctVf,
                    questionAl: tipsResponse.questions.questionAl,
                    correctAl: tipsResponse.questions.correctAl,
                    alternatives: {
                      'a': tipsResponse.questions.alternatives.a,
                      'b': tipsResponse.questions.alternatives.b,
                      'c': tipsResponse.questions.alternatives.c
                    });
                // print(questionData.alternatives);
                questionList.add(questionData);
              }
            }

            print("ENtra primer for");
            for (int i = 0; i < tipsList.length; i++) {
              final result = await _tipsDataRepository
                  .getTips(tipsList[i].tipsID.toString());
              if (result.isEmpty) {
                await _tipsDataRepository.insertTips(tipsList[i]);
                //  print("Insert Data");
              }
              //print("Result: ${result}");
              //_tipsDataRepository.insertTips(tipsList[i]);
            }

            print("ENtra 2do for");
            for (int i = 0; i < questionList.length; i++) {
              final result = await _questionDataRepository
                  .getQuestion(questionList[i].tipID.toString());
              if (result.isEmpty) {
                await _questionDataRepository.insertQuestion(questionList[i]);
                //  print("Insert Data");
              }
              //print("Result: ${result}");
              //_tipsDataRepository.insertTips(tipsList[i]);
            }
          }
          // Navigator.pop(context);
          //print(indexes);
          // loading(
          //   context,
          //   title: Text(
          //     "Descargando audios...",
          //     style: TextStyle(color: blue, fontSize: 6.0.w),
          //     textAlign: TextAlign.center,
          //   ),
          //   content: Column(
          //     children: [
          //       Center(
          //         child: Image.asset(
          //           "Assets/videos/loading.gif",
          //           width: 70.0.w,
          //           height: 15.0.h,
          //           fit: BoxFit.contain,
          //         ),
          //       ),
          //     ],
          //   ),
          // );
          // await audioDownload(audioNames, "tip");
          // await downloadAudiosTest(audioNames, "tip");
          Navigator.pop(context);
          print("Total Tips: ${tipsList.length}");
          print("Total Questions: ${questionList.length}");
          // var res = await _questionDataRepository.getAllQuestions();
          // print(res.length);
          print("DESCARGANDO DATOS DE CLASES");
          getClass(responseClasses, context);
        } catch (e) {
          print(e);
        }
      } else {
        toast(context,
            "Necesitas estar conectado a internet. Verifica tu conexión", red);
      }
    }
  }

  getExercises(BuildContext context) async {
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
        //This segment Downloads and create objects on the database
        final result =
            await _excerciseRepository.insertExcercise(excercisedata);
        print(result);
      }
      prefs.setBool("downloadedExercisesBd", true);
      print("Response ${response2.data[0]}");
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
    }
  }

  audioDownload(List<String> audioList, String type) async {
    var dir = await getApplicationDocumentsDirectory();
    print("Inside Audio Download");
    Dio dio = Dio();
    var prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token");
    Response response2 = await Dio().post(
        "https://intranet.movitronia.com/api/mobile/audios?token=$token",
        data: {"type": "$type", "audioList": audioList});

    print("Response Audio List: ${response2.data.length}");

    for (int i = 0; i < response2.data.length; i++) {
      // print(response2.data[i]);

      try {
        await dio.download(
            response2.data[i], '${dir.path}/audios/${audioList[i]}.mp3',
            onReceiveProgress: (actualbytes, totalbytes) {
          var percentage = actualbytes / totalbytes * 100;
          print(actualbytes / totalbytes * 100);
          print(percentage);
        });
      } catch (e) {}
    }
  }

  videoDownload(List<String> videoList) async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dir = await getApplicationDocumentsDirectory();
    var format = "";
    if (Platform.isAndroid) {
      format = ".webm";
      print("${dir.path}/videos/${videoList[0]}$format");
    } else if (Platform.isIOS) {
      format = ".mp4";
      print("${dir.path}/videos/${videoList[0]}$format");
    }
    Response response2 = await dio.post(
        "https://intranet.movitronia.com/api/mobile/videos?token=$token",
        data: {"platform": "android", "videoList": videoList});

    print("Response Video List: ${response2.data.length}");

    for (int i = 0; i < response2.data.length; i++) {
      print(response2.data[i]);
      //Try Catch
      try {
        var dir = await getApplicationDocumentsDirectory();
        await dio.download(
            response2.data[i], '${dir.path}/videos/${videoList[i]}$format',
            onReceiveProgress: (actualbytes, totalbytes) {
          // var percentage = actualbytes / totalbytes * 100;
        });
      } catch (e) {}
    }
  }

  getClass(Response response, BuildContext context) async {
    print("EMPIEZA A CREAR CLAAAAASESSS");
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      List<int> pauses = [];
      List<dynamic> tips = [];
      List<dynamic> exerciseCalentamiento = [];
      List<dynamic> exerciseFlexibilidad = [];
      List<dynamic> exerciseDesarrollo = [];
      List<dynamic> exerciseVCalma = [];
      ClassDataRepository _classDataRepository = GetIt.I.get();
      loading(
        context,
        title: Text(
          "Creando clases...",
          style: TextStyle(color: blue, fontSize: 6.0.w),
        ),
        content: Center(
          child: Image.asset(
            "Assets/videos/loading.gif",
            width: 70.0.w,
            height: 15.0.h,
            fit: BoxFit.contain,
          ),
        ),
      );
      //First Loop through each object
      for (int i = 0; i < response.data.length; i++) {
        //print("Response Data: ${response.data[i]['pauses']}\n\n\n");
        var responseobject = response.data[i];
        try {
          //print("Total Objects: " + responseobject['pauses'].length.toString());
          /**Getting Calentamiento List */
          for (int i = 0;
              i < responseobject['exercisesCalentamiento'].length;
              i++) {
            exerciseCalentamiento
                .add(responseobject['exercisesCalentamiento'][i]['videoName']);
          }
          /**Getting Flexibilidad List */
          for (int i = 0;
              i < responseobject['exercisesFlexibilidad'].length;
              i++) {
            exerciseFlexibilidad
                .add(responseobject['exercisesFlexibilidad'][i]['videoName']);
          }
          /**Getting Desarrollo List */
          for (int i = 0;
              i < responseobject['exercisesDesarrollo'].length;
              i++) {
            exerciseDesarrollo
                .add(responseobject['exercisesDesarrollo'][i]['videoName']);
          }
          /**Getting Vuelta Calma List */
          for (int i = 0;
              i < responseobject['exercisesVueltaCalma'].length;
              i++) {
            exerciseVCalma
                .add(responseobject['exercisesVueltaCalma'][i]['videoName']);
          }
          for (int i = 0; i < responseobject['pauses'].length; i++) {
            //print(responseobject['pauses'][i]['tips']);
            tips.add(responseobject['pauses'][i]['tips']);
            if (responseobject['pauses'][i]['micro'] != null) {
              var object = responseobject['pauses'][i]['micro'].toString();
              pauses.add(int.parse(object));
            }
            if (responseobject['pauses'][i]['macro'] != null) {
              pauses.add(
                  int.parse(responseobject['pauses'][i]['macro'].toString()));
            }
          }
        } catch (e) {
          print("Le Error " + e.toString());
        }
        ClassLevel classLevel = ClassLevel(
            classID: responseobject['_id'],
            number: responseobject['number'],
            level: responseobject['level'],
            questionnaire: responseobject["questionnaire"],
            macropause: responseobject['macropause'],
            pauses: pauses,
            excerciseCalentamiento: exerciseCalentamiento,
            excerciseFlexibilidad: exerciseFlexibilidad,
            excerciseDesarrollo: exerciseDesarrollo,
            excerciseVueltaCalma: exerciseVCalma,
            timeCalentamiento: responseobject['times']['calentamiento'],
            timeFlexibilidad: responseobject['times']['flexibilidad'],
            timeDesarrollo: responseobject['times']['desarrollo'],
            timeVcalma: responseobject['times']['vcalma'],
            tips: tips);
        await _classDataRepository.insertClass(classLevel);
        pauses.clear();
        tips.clear();
        exerciseCalentamiento.clear();
        exerciseFlexibilidad.clear();
        exerciseDesarrollo.clear();
        exerciseVCalma.clear();
      }
      Navigator.pop(context);
      toast(context, "Clases creadas", green);
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
    }
  }

  Future downloadEvidencesData(BuildContext context) async {
    log("Downloading evidences data");
    EvidencesRepository evidencesRepository = GetIt.I.get();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet == false) {
      toast(
          context,
          "No tienes conexión a internet. Comprueba que estés conectado a una red estable.",
          red);
    } else {
      var dio = Dio();
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      try {
        Response res =
            await dio.get("$urlServer/api/mobile/evidences?token=$token");
        print(res.data);
        if (res.statusCode == 200) {
          for (var i = 0; i < res.data.length; i++) {
            EvidencesSend evidencesSend = EvidencesSend(
                number: res.data[i]["class"]["number"],
                kilocalories: res.data[i]["totalKilocalories"].toString(),
                idEvidence: res.data[i]["_id"],
                phase: res.data[i]["phase"],
                classObject: res.data[i]["class"],
                questionnaire: res.data[i]["questionnaire"],
                finished: true);
            await evidencesRepository.updateEvidence(evidencesSend);
          }
        }
      } catch (e) {
        toast(context, "Ha ocurrido un error. Inténtalo más tarde.", red);
        print(e);
      }
    }
    log("finish evidence data");
  }

  Future downloadFiles(String url, String filename, BuildContext context,
      String messageAlert, String route, String platform) async {
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

  Future downloadCustomClasses(BuildContext context) async {
    List<int> pauses = [];
    List<dynamic> tips = [];
    List<dynamic> exerciseCalentamiento = [];
    List<dynamic> exerciseFlexibilidad = [];
    List<dynamic> exerciseDesarrollo = [];
    List<dynamic> exerciseVCalma = [];
    List classIds = [];
    print("entra download");
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dio = Dio();
    CourseDataRepository courseDataRepository = GetIt.I.get();

    var course = await courseDataRepository.getAllCourse();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();

    if (hasInternet) {
      Response responseObject = await dio.get(
          "$urlServer/api/mobile/user/customClassesByCourse/${course[0].courseId}?token=$token");

      log(responseObject.data.toString());
      if (responseObject.data.toString() == "[]") {
        print("Sin clases creadas");
      } else {
        for (var i = 0; i < responseObject.data.length; i++) {
          classIds.add(responseObject.data[i]["originalClass"]);
        }
        //First Loop through each object
        for (int i = 0; i < responseObject.data.length; i++) {
          //print("Response Data: ${response.data[i]['pauses']}\n\n\n");
          var responseobject = responseObject.data[i];
          try {
            //print("Total Objects: " + responseobject['pauses'].length.toString());
            /**Getting Calentamiento List */
            for (int i = 0;
                i < responseobject['exercisesCalentamiento'].length;
                i++) {
              exerciseCalentamiento.add(
                  responseobject['exercisesCalentamiento'][i]['videoName']);
            }
            /**Getting Flexibilidad List */
            for (int i = 0;
                i < responseobject['exercisesFlexibilidad'].length;
                i++) {
              exerciseFlexibilidad
                  .add(responseobject['exercisesFlexibilidad'][i]['videoName']);
            }
            /**Getting Desarrollo List */
            for (int i = 0;
                i < responseobject['exercisesDesarrollo'].length;
                i++) {
              exerciseDesarrollo
                  .add(responseobject['exercisesDesarrollo'][i]['videoName']);
            }
            /**Getting Vuelta Calma List */
            for (int i = 0;
                i < responseobject['exercisesVueltaCalma'].length;
                i++) {
              exerciseVCalma
                  .add(responseobject['exercisesVueltaCalma'][i]['videoName']);
            }
            for (int i = 0; i < responseobject['pauses'].length; i++) {
              //print(responseobject['pauses'][i]['tips']);
              tips.add(responseobject['pauses'][i]['tips']);
              if (responseobject['pauses'][i]['micro'] != null) {
                var object = responseobject['pauses'][i]['micro'].toString();
                pauses.add(int.parse(object));
              }
              if (responseobject['pauses'][i]['macro'] != null) {
                pauses.add(
                    int.parse(responseobject['pauses'][i]['macro'].toString()));
              }
            }

            ClassDataRepository _classDataRepository = GetIt.I.get();

            ClassLevel classLevel = ClassLevel(
                classID: responseobject['_id'],
                number: responseobject['number'],
                level: responseobject['level'],
                questionnaire: responseobject["questionnaire"],
                macropause: responseobject['macropause'],
                pauses: pauses,
                excerciseCalentamiento: exerciseCalentamiento,
                excerciseFlexibilidad: exerciseFlexibilidad,
                excerciseDesarrollo: exerciseDesarrollo,
                excerciseVueltaCalma: exerciseVCalma,
                timeCalentamiento: responseobject['times']['calentamiento'],
                timeFlexibilidad: responseobject['times']['flexibilidad'],
                timeDesarrollo: responseobject['times']['desarrollo'],
                timeVcalma: responseobject['times']['vcalma'],
                tips: tips);
            for (var i = 0; i < classIds.length; i++) {
              log(classLevel.toMap().toString());
              var res = await _classDataRepository.updateClass(classLevel,
                  responseobject['level'], responseobject['number']);
              // var res = await _classDataRepository.getClassByNumber(responseobject['number']);
              log("RES " + res.toString());
            }
          } catch (e) {
            print(e.toString());
          }
        }
      }
    } else {
      print("no conectado");
    }
    return null;
  }

  Future<bool> downloadAll({BuildContext context, String level}) async {
    var prefs = await SharedPreferences.getInstance();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      await getExercises(context);
      await getHttp(context, level);
      await downloadEvidencesData(context);
      await downloadCustomClasses(context);
      print("Fin de descarga");
      prefs.setBool("downloaded", true);
      return true;
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
      prefs.setBool("downloaded", false);
      return false;
    }
  }
}
