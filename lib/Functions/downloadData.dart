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
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Design/Widgets/Toast.dart';
import 'package:flutter/material.dart';
import '../Utils/Colors.dart';
import 'package:archive/archive.dart';
import '../Database/Models/courseModel.dart';
import '../Utils/UrlServer.dart';
import '../Utils/ConnectionState.dart';
import '../Design/Widgets/Loading.dart';
import 'package:sizer/sizer.dart';
import 'dart:async';
import 'createError.dart';

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
        CreateError().createError(dio, e.toString(), "downloadData");
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

  getHttp(BuildContext context, String level) async {
    if (level.isEmpty) {
      toast(context,
          "No se ha encontrado un curso asignado. Contacta con soporte.", red);
      goToSupport(true);
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

          Navigator.pop(context);
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
          for (int i = 0; i < responseClasses.data.length; i++) {
            Map responseBody = responseClasses.data[i];
            ResultModel jsonResponse = ResultModel.fromJson(responseBody);
            for (int i = 0; i < jsonResponse.tips.length; i++) {
              var tipsResponse = jsonResponse.tips[i];
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

                TipsData tipsData = TipsData(
                    audioQuestion: audioQuestion,
                    audioTips: audioTips,
                    audioVF: audioVF,
                    tipsID: int.parse(tipsResponse.tipId),
                    documentID: tipsResponse.sId,
                    tip: tipsResponse.tip);

                indexes.add(tipsData.tipsID);
                tipsList.add(tipsData);
                for (int i = 0; i < tipsResponse.audios.length; i++) {
                  audioNames.add(tipsResponse.audios[i].link);
                }
                var res = await _tipsDataRepository.getTips(tipsResponse.sId);
                if (res.isEmpty) {
                  await _tipsDataRepository.insertTips(tipsData);
                } else {
                  await _tipsDataRepository.updateTips(tipsData);
                }
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
                questionList.add(questionData);
              }
            }

            for (int i = 0; i < questionList.length; i++) {
              final result = await _questionDataRepository
                  .getQuestion(questionList[i].tipID.toString());
              if (result.isEmpty) {
                await _questionDataRepository.insertQuestion(questionList[i]);
              }
            }
          }
          Navigator.pop(context);
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
    } else {
      toast(context,
          "Necesitas estar conectado a internet. Verifica tu conexión", red);
    }
  }

  getClass(Response response, BuildContext context) async {
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
          print("Error " + e.toString());
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
            tips: tips,
            isCustom: false);
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
                number: res.data[i]["class"] == null
                    ? res.data[i]["customClass"]["number"]
                    : res.data[i]["class"]["number"],
                kilocalories: res.data[i]["totalKilocalories"].toString(),
                idEvidence: res.data[i]["_id"],
                phase: res.data[i]["phase"],
                classObject: res.data[i]["class"] == null
                    ? res.data[i]["customClass"]
                    : res.data[i]["class"],
                questionnaire: res.data[i]["questionnaire"],
                finished: true);
            await evidencesRepository.updateEvidence(evidencesSend);
          }
          print("fin for evidences");
        }
      } catch (e) {
        toast(context, "Ha ocurrido un error. Inténtalo más tarde.", red);
        print(e);
      }
    }
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
                tips: tips,
                isCustom: true);
            for (var i = 0; i < classIds.length; i++) {
              await _classDataRepository.updateClass(classLevel,
                  responseobject['level'], responseobject['number']);
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
