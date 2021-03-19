import 'dart:io';
import 'dart:math';
import 'package:badges/badges.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' as GET;
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Design/All/Reports/reports.dart';
import 'package:movitronia/Design/All/Sessions/Sessions.dart';
import 'package:movitronia/Design/All/Settings/ProfilePage.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'package:dio/dio.dart';
import 'package:uuid/uuid.dart';
import '../../../Database/Repository/OfflineRepository.dart';
import 'dart:developer' as dev;
import '../../../Functions/downloadData.dart';

class HomePageUser extends StatefulWidget {
  @override
  _HomePageUserState createState() => _HomePageUserState();
}

class _HomePageUserState extends State<HomePageUser> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _currentIndex = 0;
  List<Widget> _screens = [];
  int count = 0;
  int dataOffline = 0;
  var progressVideo = 0.0;
  List dataClasses = [];
  List<OfflineData> dataOfflineList = [];

  @override
  void initState() {
    super.initState();
    getDataOffline();
    _screens.add(Sessions());
    _screens.add(Reports(drawerMenu: false, isTeacher: false, data: null));
    _screens.add(ProfilePage(isMenu: true));
  }

  getDataOffline() async {
    OfflineRepository offlineRepository = GetIt.I.get();
    var res = await offlineRepository.getAll();
    setState(() {
      dataOffline = res.length;
    });
    if (res.isNotEmpty) {
      dev.log(res[0].exercises.toString());
      for (var i = 0; i < res.length; i++) {
        dataOfflineList.add(res[i]);
      }
    }
  }

  getClasses() async {
    ClassDataRepository classDataRepository = GetIt.I.get();
    var res = await classDataRepository.getAllClassLevel();
    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        setState(() {
          dataClasses.add(res[i]);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        bottomNavigationBar: bottomNavBar(),
        backgroundColor: blue,
        key: _scaffoldKey,
        drawer: _drawerUser(),
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.menu,
              size: 9.0.w,
            ),
            onPressed: () => _scaffoldKey.currentState.openDrawer(),
          ),
          backgroundColor: cyan,
          elevation: 0,
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(
                    _currentIndex == 0
                        ? "SESIONES"
                        : _currentIndex == 1
                            ? "REPORTES"
                            : _currentIndex == 2
                                ? "PERFIL"
                                : "Error al cargar",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 6.0.w),
                  )),
            ],
          ),
          centerTitle: true,
        ),
        body: Stack(children: [
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: Color.fromRGBO(25, 45, 99, 1), width: 70.0.w),
                  ),
                ],
              ),
            ],
          ),
          _screens[_currentIndex]
        ]),
      ),
    );
  }

  Future<bool> pop() async {
    setState(() {
      count++;
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            count = 0;
          });
        }
      });
    });
    if (count == 2) {
      SystemNavigator.pop();
    } else if (count <= 1) {
      toast(
          context, "Vuelve atrás dos veces para salir de la aplicación.", red);
    }

    return false;
  }

  Widget bottomNavBar() {
    return Container(
      height: 13.0.h,
      width: 100.0.w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 0;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonSessions.png",
                  width: 14.0.w,
                ),
                Text("SESIONES", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 1;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonReports.png",
                  width: 14.0.w,
                ),
                Text("REPORTES", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "Assets/images/buttonProfile.png",
                  width: 14.0.w,
                ),
                Text("PERFIL", style: TextStyle(color: blue, fontSize: 4.0.w))
              ],
            ),
          )
        ],
      ),
      decoration: BoxDecoration(color: cyan),
    );
  }

  Widget _drawerUser() {
    var h = MediaQuery.of(context).size.height;
    return Container(
      width: 100.0.w,
      height: h,
      decoration: BoxDecoration(
        color: blue,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 10.0.h,
            ),
            InkWell(
              child: Text(
                "MENÚ",
                style: TextStyle(color: Colors.white, fontSize: 10.0.w),
              ),
            ),
            SizedBox(
              height: 5.0.h,
            ),
            buttonRounded(context,
                icon:
                    Image.asset("Assets/images/sessionIcon.png", width: 8.0.w),
                circleRadius: 6.0.w, func: () {
              Navigator.pop(context);
              setState(() async {
                CourseDataRepository courseDataRepository = GetIt.I.get();
                ClassDataRepository classDataRepository = GetIt.I.get();
                var res = await classDataRepository.getAllClassLevel();
                var resCourse = await courseDataRepository.getAllCourse();
                var prefs = await SharedPreferences.getInstance();
                var res1 = prefs.getString("token");
                print(res1);
                print(resCourse[0].toMap().toString());
                _currentIndex = 0;
              });
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "SESIONES",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            buttonRounded(context,
                icon: Image.asset("Assets/images/reportIcon.png", width: 7.0.w),
                circleRadius: 6.0.w, func: () {
              GET.Get.to(Reports(
                drawerMenu: true,
              ));
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "REPORTES",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/reportIcon.png", width: 7.5.w),
            //     circleRadius: 6.0.w, func: () async {
            //   String level;
            //   CourseDataRepository courseDataRepository = GetIt.I.get();
            //   var course = await courseDataRepository.getAllCourse();
            //   if (course.isNotEmpty) {
            //     setState(() {
            //       level = course[0].number;
            //     });
            //   }
            //   await DownloadData().downloadAll(context, level);
            //   // await DownloadData().getHttp(context, level);
            //   setState(() {
            //     _currentIndex = 0;
            //   });
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "      DESCARGAR DATOS",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            buttonRounded(context,
                icon: Image.asset("Assets/images/evidenciaIcon.png",
                    width: 8.0.w),
                circleRadius: 6.0.w, func: () {
              goToAllEvidences();
            },
                height: 8.0.h,
                width: 80.0.w,
                textStyle: TextStyle(color: blue, fontSize: 6.0.w),
                text: "EVIDENCIAS",
                circleColor: blue,
                backgroudColor: Colors.white),
            SizedBox(
              height: 2.0.h,
            ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/shopIcon.png", width: 9.0.w),
            //     circleRadius: 7.0.w, func: () {
            //   Navigator.pop(context);
            //   setState(() {
            //     _currentIndex = 2;
            //   });
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "TIENDA",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            // buttonRounded(context,
            //     icon: Image.asset("Assets/images/settingsIcon.png", width: 9.0.w),
            //     circleRadius: 7.0.w, func: () {
            //   goToSettingsPage("user");
            // },
            //     height: 8.0.h,
            //     width: 80.0.w,
            //     textStyle: TextStyle(color: blue, fontSize: 6.0.w),
            //     text: "AJUSTES",
            //     circleColor: blue,
            //     backgroudColor: Colors.white),
            // SizedBox(
            //   height: 2.0.h,
            // ),
            InkWell(
              onTap: () {
                closeSession();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80.0.w,
                    height: 8.0.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50)),
                        border: Border.all(color: Colors.white, width: 3)),
                    child: Center(
                      child: Text(
                        "CERRAR SESIÓN",
                        style: TextStyle(color: Colors.white, fontSize: 6.5.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 3.0.h,
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    if (dataOffline == 0) {
                      toast(context, "No hay datos guardados localmente.", red);
                    } else {
                      uploadData();
                      // dev.log(dataOfflineList[2].toMap().toString());
                    }
                  },
                  child: Stack(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 9.0.w,
                        child: CircleAvatar(
                          radius: 8.0.w,
                          backgroundColor: blue,
                          child: Center(
                            child: Icon(
                              Icons.arrow_upward,
                              color: Colors.white,
                              size: 15.0.w,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 5.0.h,
                          ),
                          dataOffline == 0
                              ? SizedBox.shrink()
                              : Badge(
                                  badgeContent: Text(
                                    "$dataOffline",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 7.0.w),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 9.0.w,
                    child: CircleAvatar(
                      radius: 8.0.w,
                      backgroundColor: blue,
                      child: Center(
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 15.0.w,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),

            SizedBox(
              height: 5.0.h,
            ),
            Text(
              "Versión: 1.0.9",
              style: TextStyle(color: Colors.white, fontSize: 5.0.w),
            )
          ],
        ),
      ),
    );
  }

  uploadData() async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    if (hasInternet) {
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
            "Enviando evidencia...",
            textAlign: TextAlign.center,
          ));
      var prefs = await SharedPreferences.getInstance();
      for (var i = 0; i < dataOfflineList.length; i++) {
        try {
          var dio = Dio();
          var uuid = Uuid().v4();
          File file = File("${dataOfflineList[i].uriVideo}");
          //Create Multipart form for cloudflare with video, they key is file
          FormData data = FormData.fromMap({
            "file": await MultipartFile.fromFile(file.path, filename: uuid)
          });
          try {
            var token = prefs.getString("token");
            //First call api for generate token in cloudflare
            Response response = await dio.get(
                "$urlServer/api/mobile/cfStreamTokenGenerator?token=$token");
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
            var videoData = {
              "uuid": uuid,
              "exercises": dataOfflineList[i].exercises, //args["exercises"],
              "cloudflareId": response2.data["result"]["uid"]
            };
            dev.log(videoData.toString());
            toast(context, "Video subido con éxito.", green);
            // Navigator.pop(context);
            //Call API for send data of video in cloudflare
            // Response response3 = await dio.post("path?token=$token", data: dataSend);
            uploadQuestionary(dataOfflineList[i], videoData);
          } catch (e) {
            Navigator.pop(context);
            toast(context, "Ha ocurrido un error, inténtalo nuevamente.", red);
            print("EO " + e.toString());
          }
        } catch (e) {
          print(e.response);
        }
      }
    } else {
      toast(
          context,
          "No cuentas con conexión a internet. Por favor conéctate a una red estable.",
          red);
    }
  }

  uploadQuestionary(OfflineData offlineData, videoData) async {
    var prefs = await SharedPreferences.getInstance();
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    String token = prefs.getString("token");
    if (hasInternet) {
      var dio = Dio();
      try {
        var data = {
          "uuid": Uuid().v4().toString(),
          "type": offlineData.type,
          "phase": offlineData.phase,
          "class": offlineData.idClass,
          "totalKilocalories": offlineData.totalKilocalories,
          "questionnaire": offlineData.questionary,
          "videoData": videoData,
          "course": offlineData.course
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
            .post("$urlServer/api/mobile/evidence?token=$token", data: data);
        print(response);
        print(response.data);
        // goToFinalPage();
        if (response.statusCode == 201) {
          List corrects = [];
          int total = offlineData.questionary.length;
          var quest = offlineData.questionary;
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
          OfflineRepository offlineRepository = GetIt.I.get();
          await offlineRepository.deleteElement(offlineData.uuid);
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
      toast(
          context,
          "No tienes conexión a internet. Se guardaron los datos localmente para ser subidos cuando tengas conexión a internet.",
          green);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
