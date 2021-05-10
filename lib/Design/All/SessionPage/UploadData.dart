import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:movitronia/Database/Models/evidencesSend.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Database/Repository/OfflineRepository.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Functions/createError.dart';
import 'package:movitronia/Utils/retryDioConnectivity.dart';
import 'package:movitronia/Utils/retryDioDialog.dart';
import '../HomePage/HomepageUser.dart';
import 'package:get/get.dart' as GET;
import 'package:movitronia/Utils/ConnectionState.dart';
import 'dart:developer';
import '../../Widgets/Loading.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:get_it/get_it.dart';
import '../../../Database/Repository/QuestionaryRepository.dart';
import '../../../Functions/downloadData.dart';
import '../../../Database/Repository/CourseRepository.dart';

class UploadData extends StatefulWidget {
  @override
  _UploadDataState createState() => _UploadDataState();
}

class _UploadDataState extends State<UploadData> {
  double progressQuestionary = 0.0;
  double progressVideo = 0.0;
  bool isLoading = false;
  var dio = Dio();

  @override
  void initState() {
    initInterceptor();
    super.initState();
  }

  initInterceptor() {
    RetryOnConnectionChangeInterceptorDialog(
      function: () {
        print("a");
      },
      context: context,
      requestRetrier: DioConnectivityRequestRetrier(
        dio: dio,
        connectivity: Connectivity(),
      ),
    );
  }

  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        bottomNavigationBar: Container(
          width: 100.0.w,
          height: 10.0.h,
          color: cyan,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttonRounded(context, func: () async {
                // createEvidence(args);
                uploadVideo(args);
              }, text: "   SUBE AQUÍ")
            ],
          ),
        ),
        appBar: AppBar(
          leading: SizedBox.shrink(),
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(fit: BoxFit.fitWidth, child: Text("FIN SESIÓN")),
            ],
          ),
          backgroundColor: cyan,
          centerTitle: true,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              child: Image.asset(
                "Assets/images/wall3.png",
                fit: BoxFit.fill,
                height: 100.0.h,
                width: 100.0.w,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30.0.h,
                ),
                Text(
                  "Terminaste con éxito la sesión ${args["number"]}...\n...Sube tu sesión!",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8.0.w,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }

  Future uploadQuestionary(args, videoData) async {
    CourseDataRepository courseDataRepository = GetIt.I.get();
    var course = await courseDataRepository.getAllCourse();
    var prefs = await SharedPreferences.getInstance();
    Response evidence;
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    QuestionaryRepository offlineQuestionaryRepository = GetIt.I.get();
    var res = await offlineQuestionaryRepository.getForId(args["uuid"]);
    String token = prefs.getString("token");
    if (hasInternet) {
      var dio = Dio();
      try {
        var data = {
          "uuid": Uuid().v4().toString(),
          "type": args["isCustom"] ? "customClass" : "normalClass",
          "phase": args["phase"].toString(),
          "class": args["idClass"].toString(),
          "totalKilocalories": args["mets"],
          "questionnaire": res[0].questionary,
          "videoData": videoData,
          "course": course[0].courseId
        };

        Navigator.pop(context);
        loading(context,
            content: Center(
              child: Image.asset(
                "Assets/videos/loading.gif",
                width: 70.0.w,
                height: 15.0.h,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(
              "Enviando cuestionario...",
              textAlign: TextAlign.center,
            ));
        try {
          await retry(function: () async {
            evidence = await dio
                .post("$urlServer/api/mobile/evidence?token=$token", data: data,
                    onSendProgress: (sent, total) {
              setState(() {
                progressQuestionary = sent / total * 100;
                print(progressVideo.floor());
              });
            });
          });
        } catch (e) {
          var uuidDevice = prefs.getString("uuid");
          var nameUser = prefs.getString("name");
          var uuidUser = uuidDevice + nameUser;
          var actualVideo = prefs.getString("actualVideo");
          EvidencesRepository evidencesRepository = GetIt.I.get();
          ClassDataRepository classDataRepository = GetIt.I.get();
          var classObj = await classDataRepository.getClassID(args["idClass"]);
          saveOffline(
              Uuid().v4().toString(),
              args["phase"].toString(),
              args["idClass"].toString(),
              args["mets"],
              course[0].courseId,
              res[0].questionary,
              actualVideo,
              args["exercises"],
              args["isCustom"] ? "customClass" : "normalClass",
              uuidUser);

          EvidencesSend evidencesSend = EvidencesSend(
              number: args["number"],
              idEvidence: "evidencia${args["number"]}$uuidUser",
              phase: args["phase"].toString(),
              classObject: {
                "times": {
                  "calentamiento": classObj[0].timeCalentamiento,
                  "desarrollo": classObj[0].timeDesarrollo,
                  "vcalma": classObj[0].timeVcalma,
                  "flexibilidad": classObj[0].timeFlexibilidad
                },
                "students": [],
                "exercisesCalentamiento": classObj[0].excerciseCalentamiento,
                "exercisesFlexibilidad": classObj[0].excerciseFlexibilidad,
                "exercisesDesarrollo": classObj[0].excerciseDesarrollo,
                "exercisesVueltaCalma": classObj[0].excerciseVueltaCalma,
                "tips": classObj[0].tips,
                "_id": classObj[0].classID,
                "course": "",
                "questionnaire": classObj[0].questionnaire,
                "number": classObj[0].number,
                "level": classObj[0].level,
                "pauses": classObj[0].pauses
              },
              finished: true,
              kilocalories: args["mets"].toString(),
              questionnaire: res[0].questionary);
          await evidencesRepository.updateEvidence(evidencesSend);

          toast(
              context,
              "Tu conexión a internet no es estable. Se guardaron los datos localmente para ser subidos automáticamente cuando te conectes nuevamente.",
              green);
          GET.Get.offAll(HomePageUser());
        }
        // goToFinalPage();
        if (evidence.statusCode == 201) {
          List corrects = [];
          int total = res[0].questionary.length;
          var quest = res[0].questionary;
          for (var i = 0; i < quest.length; i++) {
            if (quest[i]["type"] == "vf") {
              if (quest[i]["correctVf"] == quest[i]["studentResponseVf"]) {
                setState(() {
                  corrects.add(quest[i]);
                });
              }
            } else {
              if (quest[i]["correctAl"] == quest[i]["studentResponseAl"]) {
                setState(() {
                  corrects.add(quest[i]);
                });
              }
            }
          }
          toast(
              context,
              "Se han subido los datos correctamente.\n\nTuviste ${corrects.length} correctas de $total en este cuestionario.",
              green);
          await DownloadData().downloadEvidencesData(context);
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => HomePageUser()));
          GET.Get.offAll(HomePageUser());
        }
      } catch (e) {
        if (e is DioError) {
          print("EEEEEEEEEEEEEERROR " + e.response.data.toString());
          Navigator.pop(context);
          toast(context, "Ha ocurrido un error, inténtalo nuevamente.", red);
        }
        print("EEEEEEEEEEEEEEEEEERRRROR " + e.toString());
        Navigator.pop(context);
        toast(context, "Ha ocurrido un error, inténtalo nuevamente.", red);
      }
    } else {
      var uuidDevice = prefs.getString("uuid");
      var nameUser = prefs.getString("name");
      var uuidUser = uuidDevice + nameUser;
      var actualVideo = prefs.getString("actualVideo");
      EvidencesRepository evidencesRepository = GetIt.I.get();
      ClassDataRepository classDataRepository = GetIt.I.get();
      var classObj = await classDataRepository.getClassID(args["idClass"]);
      saveOffline(
          Uuid().v4().toString(),
          args["phase"].toString(),
          args["idClass"].toString(),
          args["mets"],
          course[0].courseId,
          res[0].questionary,
          actualVideo,
          args["exercises"],
          args["isCustom"] ? "customClass" : "normalClass",
          uuidUser);
      try {
        EvidencesSend evidencesSend = EvidencesSend(
            number: args["number"],
            idEvidence: "evidencia${args["number"]}$uuidUser",
            phase: args["phase"].toString(),
            classObject: {
              "times": {
                "calentamiento": classObj[0].timeCalentamiento,
                "desarrollo": classObj[0].timeDesarrollo,
                "vcalma": classObj[0].timeVcalma,
                "flexibilidad": classObj[0].timeFlexibilidad
              },
              "students": [],
              "exercisesCalentamiento": classObj[0].excerciseCalentamiento,
              "exercisesFlexibilidad": classObj[0].excerciseFlexibilidad,
              "exercisesDesarrollo": classObj[0].excerciseDesarrollo,
              "exercisesVueltaCalma": classObj[0].excerciseVueltaCalma,
              "tips": classObj[0].tips,
              "_id": classObj[0].classID,
              "course": "",
              "questionnaire": classObj[0].questionnaire,
              "number": classObj[0].number,
              "level": classObj[0].level,
              "pauses": classObj[0].pauses
            },
            finished: true,
            kilocalories: args["mets"].toString(),
            questionnaire: res[0].questionary);
        await evidencesRepository.updateEvidence(evidencesSend);
      } catch (e) {
        print(e.toString());
      }
      toast(
          context,
          "No tienes conexión a internet. Se guardaron los datos localmente para ser subidos automáticamente cuando tengas conexión a internet.",
          green);
      GET.Get.offAll(HomePageUser());
    }
    return true;
  }

  Future saveOffline(
      var uuid,
      var phase,
      var classId,
      var totalKilocalories,
      var course,
      var questionnaire,
      var uriVideo,
      var exercises,
      String type,
      String uuidUser) async {
    OfflineRepository offlineRepository = GetIt.I.get();
    OfflineData questionaryData = OfflineData(
        uuid: uuid,
        phase: phase,
        course: course,
        questionary: questionnaire,
        uriVideo: uriVideo,
        idClass: classId,
        exercises: exercises,
        totalKilocalories: totalKilocalories,
        type: type,
        uuidUser: uuidUser);
    log(questionaryData.toMap().toString());
    await offlineRepository.insert(questionaryData);
    return true;
  }

  uploadVideo(args) async {
    print(args);
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
      print("upload video");
      loading(context,
          content: Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            "Obteniendo información...",
            textAlign: TextAlign.center,
          ));
      var dio = Dio();
      var prefs = await SharedPreferences.getInstance();
      var actualVideo = prefs.getString("actualVideo");
      var uuid = Uuid().v4();
      bool videoUploaded = false;
      File file = File("$actualVideo");
      //Create Multipart form for cloudflare with video, they key is file
      FormData data = FormData.fromMap(
          {"file": await MultipartFile.fromFile(file.path, filename: uuid)});
      Response tokenGenerator;
      Response videoSend;
      var token = prefs.getString("token");
      var videoData;
      //First call api for generate token in cloudflare
      try {
        await retry(
            numberOfRetries: 2,
            function: () async {
              tokenGenerator = await dio.get(
                  "$urlServer/api/mobile/cfStreamTokenGenerator?token=$token");
            });
      } catch (e) {
        CourseDataRepository courseDataRepository = GetIt.I.get();
        var course = await courseDataRepository.getAllCourse();
        QuestionaryRepository offlineQuestionaryRepository = GetIt.I.get();
        var res = await offlineQuestionaryRepository.getForId(args["uuid"]);
        var uuidDevice = prefs.getString("uuid");
        var nameUser = prefs.getString("name");
        var uuidUser = uuidDevice + nameUser;
        var actualVideo = prefs.getString("actualVideo");
        EvidencesRepository evidencesRepository = GetIt.I.get();
        ClassDataRepository classDataRepository = GetIt.I.get();
        var classObj = await classDataRepository.getClassID(args["idClass"]);
        saveOffline(
            Uuid().v4().toString(),
            args["phase"].toString(),
            args["idClass"].toString(),
            args["mets"],
            course[0].courseId,
            res[0].questionary,
            actualVideo,
            args["exercises"],
            args["isCustom"] ? "customClass" : "normalClass",
            uuidUser);

        EvidencesSend evidencesSend = EvidencesSend(
            number: args["number"],
            idEvidence: "evidencia${args["number"]}$uuidUser",
            phase: args["phase"].toString(),
            classObject: {
              "times": {
                "calentamiento": classObj[0].timeCalentamiento,
                "desarrollo": classObj[0].timeDesarrollo,
                "vcalma": classObj[0].timeVcalma,
                "flexibilidad": classObj[0].timeFlexibilidad
              },
              "students": [],
              "exercisesCalentamiento": classObj[0].excerciseCalentamiento,
              "exercisesFlexibilidad": classObj[0].excerciseFlexibilidad,
              "exercisesDesarrollo": classObj[0].excerciseDesarrollo,
              "exercisesVueltaCalma": classObj[0].excerciseVueltaCalma,
              "tips": classObj[0].tips,
              "_id": classObj[0].classID,
              "course": "",
              "questionnaire": classObj[0].questionnaire,
              "number": classObj[0].number,
              "level": classObj[0].level,
              "pauses": classObj[0].pauses
            },
            finished: true,
            kilocalories: args["mets"].toString(),
            questionnaire: res[0].questionary);
        await evidencesRepository.updateEvidence(evidencesSend);

        toast(
            context,
            "Tu conexión a internet no es estable. Se guardaron los datos localmente para ser subidos automáticamente cuando te conectes nuevamente.",
            green);
        GET.Get.offAll(HomePageUser());
        CreateError()
            .createError(dio, e.toString(), "get token generator uploadData");
      }
      Navigator.pop(context);
      loading(context,
          content: Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            "Enviando video...",
            textAlign: TextAlign.center,
          ));
      //Second call cloudflare api with account id and send multipart form and bearer token in headers
      if (videoUploaded == false) {
        try {
          await retry(
              numberOfRetries: 2,
              function: () async {
                videoSend = await dio.post(
                  "https://api.cloudflare.com/client/v4/accounts/cd249e709572d743280abfc7f2cc8af6/stream",
                  data: data,
                  options: Options(headers: {
                    HttpHeaders.authorizationHeader:
                        'Bearer ${tokenGenerator.data}'
                  }),
                  onSendProgress: (int sent, int total) {
                    setState(() {
                      progressVideo = sent / total * 100;
                      print(progressVideo.floor());
                    });
                    if (sent == total) {
                      setState(() {
                        videoUploaded = true;
                      });
                    }
                  },
                );
              });
          setState(() {
            videoData = {
              "uuid": uuid,
              "exercises": args["exercises"],
              "cloudflareId": videoSend.data["result"]["uid"]
            };
          });
          await uploadQuestionary(args, videoData);
          return true;
        } catch (e) {
          CourseDataRepository courseDataRepository = GetIt.I.get();
          var course = await courseDataRepository.getAllCourse();
          QuestionaryRepository offlineQuestionaryRepository = GetIt.I.get();
          var res = await offlineQuestionaryRepository.getForId(args["uuid"]);
          var uuidDevice = prefs.getString("uuid");
          var nameUser = prefs.getString("name");
          var uuidUser = uuidDevice + nameUser;
          var actualVideo = prefs.getString("actualVideo");
          EvidencesRepository evidencesRepository = GetIt.I.get();
          ClassDataRepository classDataRepository = GetIt.I.get();
          var classObj = await classDataRepository.getClassID(args["idClass"]);
          saveOffline(
              Uuid().v4().toString(),
              args["phase"].toString(),
              args["idClass"].toString(),
              args["mets"],
              course[0].courseId,
              res[0].questionary,
              actualVideo,
              args["exercises"],
              args["isCustom"] ? "customClass" : "normalClass",
              uuidUser);

          EvidencesSend evidencesSend = EvidencesSend(
              number: args["number"],
              idEvidence: "evidencia${args["number"]}$uuidUser",
              phase: args["phase"].toString(),
              classObject: {
                "times": {
                  "calentamiento": classObj[0].timeCalentamiento,
                  "desarrollo": classObj[0].timeDesarrollo,
                  "vcalma": classObj[0].timeVcalma,
                  "flexibilidad": classObj[0].timeFlexibilidad
                },
                "students": [],
                "exercisesCalentamiento": classObj[0].excerciseCalentamiento,
                "exercisesFlexibilidad": classObj[0].excerciseFlexibilidad,
                "exercisesDesarrollo": classObj[0].excerciseDesarrollo,
                "exercisesVueltaCalma": classObj[0].excerciseVueltaCalma,
                "tips": classObj[0].tips,
                "_id": classObj[0].classID,
                "course": "",
                "questionnaire": classObj[0].questionnaire,
                "number": classObj[0].number,
                "level": classObj[0].level,
                "pauses": classObj[0].pauses
              },
              finished: true,
              kilocalories: args["mets"].toString(),
              questionnaire: res[0].questionary);
          await evidencesRepository.updateEvidence(evidencesSend);

          toast(
              context,
              "Tu conexión a internet no es estable. Se guardaron los datos localmente para ser subidos automáticamente cuando te conectes nuevamente.",
              green);
          GET.Get.offAll(HomePageUser());
          print(e);
          CreateError()
              .createError(dio, e.toString(), "upload video / uploadData");
        }
      }

      // prefs.setString("actualVideo", null);
      // await file.delete();

      //Call API for send data of video in cloudflare
      // Response response3 = await dio.post("path?token=$token", data: dataSend);

    } else {
      var prefs = await SharedPreferences.getInstance();
      CourseDataRepository courseDataRepository = GetIt.I.get();
      var course = await courseDataRepository.getAllCourse();
      var uuidDevice = prefs.getString("uuid");
      var nameUser = prefs.getString("name");
      var uuidUser = uuidDevice + nameUser;
      OfflineRepository offlineRepository = GetIt.I.get();
      QuestionaryRepository offlineQuestionaryRepository = GetIt.I.get();
      var res = await offlineQuestionaryRepository.getForId(args["uuid"]);
      var actualVideo = prefs.getString("actualVideo");
      saveOffline(
          Uuid().v4().toString(),
          args["phase"].toString(),
          args["idClass"].toString(),
          args["mets"],
          course[0].courseId,
          res[0].questionary,
          actualVideo,
          args["exercises"],
          args["isCustom"] ? "customClass" : "normalClass",
          uuidUser);
      var resOffline = await offlineRepository.getAll();
      EvidencesRepository evidencesRepository = GetIt.I.get();
      ClassDataRepository classDataRepository = GetIt.I.get();
      var classObj = await classDataRepository.getClassID(args["idClass"]);
      log(resOffline.toString());

      EvidencesSend evidencesSend = EvidencesSend(
          number: args["number"],
          idEvidence: "evidencia${args["number"]}$uuidUser",
          phase: args["phase"].toString(),
          classObject: {
            "times": {
              "calentamiento": classObj[0].timeCalentamiento,
              "desarrollo": classObj[0].timeDesarrollo,
              "vcalma": classObj[0].timeVcalma,
              "flexibilidad": classObj[0].timeFlexibilidad
            },
            "students": [],
            "exercisesCalentamiento": classObj[0].excerciseCalentamiento,
            "exercisesFlexibilidad": classObj[0].excerciseFlexibilidad,
            "exercisesDesarrollo": classObj[0].excerciseDesarrollo,
            "exercisesVueltaCalma": classObj[0].excerciseVueltaCalma,
            "tips": classObj[0].tips,
            "_id": classObj[0].classID,
            "course": "",
            "questionnaire": classObj[0].questionnaire,
            "number": classObj[0].number,
            "level": classObj[0].level,
            "pauses": classObj[0].pauses
          },
          finished: true,
          kilocalories: args["mets"].toString(),
          questionnaire: res[0].questionary);
      await evidencesRepository.updateEvidence(evidencesSend);
      toast(
          context,
          "Se guardaron los datos localmente. Deberás conectarte a internet para subir tus evidencias.",
          green);
      GET.Get.offAll(HomePageUser());

      return true;
    }
  }
}

Future retry<T>(
    {Future<T> Function() function,
    int numberOfRetries = 3,
    Duration delayToRetry = const Duration(milliseconds: 500),
    String message = ''}) async {
  int retry = numberOfRetries;
  List<Exception> exceptions = [];

  while (retry-- > 0) {
    try {
      return await function();
    } catch (e) {
      exceptions.add(e);
    }
    if (message != null) print('$message:  retry - ${numberOfRetries - retry}');
    await Future.delayed(delayToRetry);
  }

  AggregatedException exception = AggregatedException(message, exceptions);
  throw exception;
}

class AggregatedException implements Exception {
  final String message;
  AggregatedException(this.message, this.exceptions)
      : lastException = exceptions.last,
        numberOfExceptions = exceptions.length;

  final List<Exception> exceptions;
  final Exception lastException;
  final int numberOfExceptions;

  String toString() {
    String result = '';
    exceptions.forEach((e) => result += e.toString() + '\\');
    return result;
  }
}
