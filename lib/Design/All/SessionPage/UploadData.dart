import 'dart:io';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:movitronia/Database/Models/QuestionaryData.dart';
import 'package:movitronia/Database/Repository/OfflineRepository.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
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

  @override
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
                uploadVideo(args);
                // uploadQuestionary(args, "");
                // goToFinalPage();
              }, text: "   SUBE AQUÍ")
            ],
          ),
        ),
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
          //   onPressed: () => Navigator.pop(context),
          // ),
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

  uploadQuestionary(args, videoData) async {
    CourseDataRepository courseDataRepository = GetIt.I.get();
    var course = await courseDataRepository.getAllCourse();
    var prefs = await SharedPreferences.getInstance();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    QuestionaryRepository offlineRepository = GetIt.I.get();
    var res = await offlineRepository.getForId(args["uuid"]);
    String token = prefs.getString("token");
    var phase = prefs.get("phase");
    if (hasInternet) {
      var dio = Dio();
      try {
        var data = {
          "uuid": Uuid().v4().toString(),
          "phase": phase.toString(),
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
        var response = await dio
            .post("$urlServer/api/mobile/evidence?token=$token", data: data,
                onSendProgress: (sent, total) {
          setState(() {
            progressQuestionary = sent / total * 100;
            print(progressVideo.floor());
          });
        });
        print(response);
        print(response.data);
        // goToFinalPage();
        if (response.statusCode == 201) {
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
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          // Navigator.pop(context);
          GET.Get.offAll(HomePageUser());
        }
      } catch (e) {
        if (e is DioError) {
          print("EEEEEEEEEEEEEERROR " + e.response.data.toString());
        }
        print("EEEEEEEEEEEEEEEEEERRRROR " + e.toString());
        toast(context, "Ha ocurrido un error, inténtalo más tarde.", red);
      }
    } else {
      var actualVideo = prefs.getString("actualVideo");
      saveOffline(
          Uuid().v4().toString(),
          phase.toString(),
          args["idClass"].toString(),
          args["mets"],
          course[0].courseId,
          res[0].questionary,
          actualVideo,
          args["exercises"]);
      toast(
          context,
          "No tienes conexión a internet. Se guardaron los datos localmente para ser subidos cuando tengas conexión a internet.",
          green);
      GET.Get.offAll(HomePageUser());
    }
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
  ) async {
    OfflineRepository offlineRepository = GetIt.I.get();
    OfflineData questionaryData = OfflineData(
        uuid: uuid,
        phase: phase,
        course: course,
        questionary: questionnaire,
        uriVideo: uriVideo,
        idClass: classId,
        exercices: exercises,
        totalKilocalories: totalKilocalories);
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
      File file = File("$actualVideo");
      //Create Multipart form for cloudflare with video, they key is file
      FormData data = FormData.fromMap(
          {"file": await MultipartFile.fromFile(file.path, filename: uuid)});
      try {
        var token = prefs.getString("token");
        //First call api for generate token in cloudflare
        Response response = await dio
            .get("$urlServer/api/mobile/cfStreamTokenGenerator?token=$token");
        print(response.data);
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
        Response response2 = await dio.post(
          "https://api.cloudflare.com/client/v4/accounts/cd249e709572d743280abfc7f2cc8af6/stream",
          data: data,
          options: Options(headers: {
            HttpHeaders.authorizationHeader: 'Bearer ${response.data}'
          }),
          onSendProgress: (int sent, int total) {
            setState(() {
              progressVideo = sent / total * 100;
              print(progressVideo.floor());
            });
          },
        );
        print(response2.data);
        // prefs.setString("actualVideo", null);
        // await file.delete();
        var videoData = {
          "uuid": uuid,
          "exercises": args["exercises"],
          "cloudflareId": response2.data["result"]["uid"]
        };
        //Call API for send data of video in cloudflare
        // Response response3 = await dio.post("path?token=$token", data: dataSend);
        uploadQuestionary(args, videoData);
      } catch (e) {
        toast(context, "Ha ocurrido un error, inténtalo nuevamente.", red);
        print("EO " + e.toString());
      }
    } else {
      toast(context, "Debes estar conectado a internet para subir datos.", red);
    }
  }
}
