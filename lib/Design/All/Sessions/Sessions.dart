import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_restart/flutter_restart.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/retryDio.dart';
import 'package:movitronia/Utils/retryDioConnectivity.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Functions/downloadData.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'package:path_provider/path_provider.dart';
import 'package:archive/archive.dart';
import 'package:progress_dialog/progress_dialog.dart';
import '../../../Utils/ConnectionState.dart';
import '../../../Utils/UrlServer.dart';
import '../../Widgets/Toast.dart';

class Sessions extends StatefulWidget {
  @override
  _SessionsState createState() => _SessionsState();
}

class _SessionsState extends State<Sessions> {
  var dio = Dio();
  ClassDataRepository classDataRepository = GetIt.I.get();
  EvidencesRepository evidencesRepository = GetIt.I.get();
  bool loaded = false;
  bool noData = false;
  List dataClasses = [];
  int phasePhone;
  List<bool> evidences = [];
  bool downloaded = false;
  bool notaccepted = true;
  var progressVideos = "0.0";
  var progressAudios = "0.0";
  var progressTips = "0.0";
  var totalMax = "100.0";
  var _urlAndroid =
      'https://play.google.com/store/apps/details?id=com.movitronia.michcom';

  var _urlIphone = "https://apps.apple.com/cl/app/movitronia/id1557150292";

  Future getEvidence() async {
    var all = await evidencesRepository.getAllEvidences();
    for (var i = 0; i < all.length; i++) {
      if (all.isNotEmpty) {
        setState(() {
          evidences.add(all[i].finished);
        });
      } else {
        setState(() {
          evidences.add(false);
        });
      }
    }
    print(evidences.toString());
    return true;
  }

  Future getClasses() async {
    print("get Classes");
    var res = await classDataRepository.getAllClassLevel();

    if (res.isNotEmpty) {
      for (var i = 0; i < res.length; i++) {
        dataClasses.add(res[i]);
      }

      for (var i = 0; i < res.length; i++) {
        if (dataClasses[i] == res[i]) {
          print("ya está");
        } else {
          dataClasses.add(res[i]);
        }
      }

      setState(() {
        loaded = true;
      });
    } else {
      setState(() {
        noData = true;
      });
    }
    return true;
  }

  Future getPhase() async {
    var prefs = await SharedPreferences.getInstance();
    int phase = prefs.getInt("phase");
    setState(() {
      phasePhone = phase;
    });
    return true;
  }

  Future getData() async {
    ProgressDialog prVideos;
    prVideos = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    ProgressDialog prAudios;
    prAudios = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    ProgressDialog prTips;
    prTips = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    await DownloadData().getUserData(context);
    var prefs = await SharedPreferences.getInstance();
    var down = prefs.getBool("downloaded" ?? false);
    var token = prefs.getString("token" ?? false);
    notaccepted = prefs.getBool("notaccepted" ?? true);

    String level;
    CourseDataRepository courseDataRepository = GetIt.I.get();

    var course = await courseDataRepository.getAllCourse();
    if (course.isNotEmpty) {
      setState(() {
        level = course[0].number;
      });
      print(course[0].courseId);
    }
    setState(() {
      downloaded = down;
    });

    String platform = "";
    if (Platform.isAndroid) {
      setState(() {
        platform = "android";
      });
    } else if (Platform.isIOS) {
      setState(() {
        platform = "ios";
      });
    }
    Response responseVideos;
    Response responseAudiosExercise;
    Response responseAudiosLevel;
    print("Value of Not Accepted $notaccepted");
    if (Platform.isAndroid) {
      prefs.setBool("downloaded", false);
      downloaded = prefs.getBool("downloaded");
      print("Value of Not Accepted Downloading Videos");
      responseVideos = await Dio().post(
          "https://intranet.movitronia.com/api/mobile/videosZip?token=$token",
          data: {"platform": platform});
      print("RESPONSE VIDEOS " + responseVideos.data);
      responseAudiosExercise = await Dio().get(
          "https://intranet.movitronia.com/api/mobile/audiosExercisesZip?token=$token");
      print("RESPONSE AUDIOS EXERCISE " + responseAudiosExercise.data);
      responseAudiosLevel = await Dio().get(
          "https://intranet.movitronia.com/api/mobile/audiosLevelZip/$level?token=$token");
      print("RESPONSE AUDIOS TIPS ${responseAudiosLevel.data}");
    } else {
      if (notaccepted != true && notaccepted != null) {
        prefs.setBool("downloaded", false);
        downloaded = prefs.getBool("downloaded");
        print("Value of Not Accepted Downloading Videos");
        responseVideos = await Dio().post(
            "https://intranet.movitronia.com/api/mobile/videosZip?token=$token",
            data: {"platform": platform});
        print("RESPONSE VIDEOS " + responseVideos.data);
        responseAudiosExercise = await Dio().get(
            "https://intranet.movitronia.com/api/mobile/audiosExercisesZip?token=$token");
        print("RESPONSE AUDIOS EXERCISE " + responseAudiosExercise.data);
        responseAudiosLevel = await Dio().get(
            "https://intranet.movitronia.com/api/mobile/audiosLevelZip/$level?token=$token");
        print("RESPONSE AUDIOS TIPS ${responseAudiosLevel.data}");
      }
    }

    var downloadedVideo = prefs.getBool("downloadedVideo" ?? false);
    var downloadAudio = prefs.getBool("downloadedAudioExercises" ?? false);

    if (Platform.isIOS) {
      if (downloaded == false && notaccepted != true ||
          downloaded == null && notaccepted != null) {
        print("Value of Not Downloading Message");
        prVideos.style(message: "Iniciando descarga de videos...");
        if (downloadedVideo == false || downloadedVideo == null) {
          await prVideos.show();
          await downloadVideos(responseVideos.data, "videos.zip", context, "",
              "videos", platform, prVideos);
        }
        if (downloadAudio == null || downloadAudio == false) {
          await prAudios.show();
          await downloadAudios(responseAudiosExercise.data,
              "audiosExercise.zip", context, "", "audios", platform, prAudios);
        }
        await prTips.show();
        await downloadTips(responseAudiosLevel.data, "audiosLevel.zip", context,
            "", "audios", platform, prTips);
      } else {
        await DownloadData().downloadAll(context: context, level: level);
      }
    } else {
      if (downloaded == false || downloaded == null) {
        prVideos.style(message: "Iniciando descarga de videos...");
        if (downloadedVideo == false || downloadedVideo == null) {
          await prVideos.show();
          var res = await downloadVideos(responseVideos.data, "videos.zip",
              context, "", "videos", platform, prVideos);
          if (res == false) {
            await downloadVideos(responseVideos.data, "videos.zip", context, "",
                "videos", platform, prVideos);
          }
        }
        if (downloadAudio == null || downloadAudio == false) {
          await prAudios.show();
          await downloadAudios(responseAudiosExercise.data,
              "audiosExercise.zip", context, "", "audios", platform, prAudios);
        }
        await prTips.show();
        await downloadTips(responseAudiosLevel.data, "audiosLevel.zip", context,
            "", "audios", platform, prTips);
      }
      await DownloadData().downloadAll(context: context, level: level);
    }

    return true;
  }

  Future downloadVideos(
      String url,
      String filename,
      BuildContext context,
      String messageAlert,
      String route,
      String platform,
      ProgressDialog pr) async {
    var prefs = await SharedPreferences.getInstance();
    var dir = await getApplicationDocumentsDirectory();
    setState(() {
      // ignore: deprecated_member_use
      dio.options.headers[HttpHeaders.connectionHeader] = "keep-alive";
    });

    try {
      await retry(
          numberOfRetries: 100,
          function: () async {
            await dio.download(url, "${dir.path}/$route/$filename",
                onReceiveProgress: (rec, total) {
              setState(() {
                progressVideos = ((rec / total) * 100).floor().toString();
                pr.update(
                    progressWidget: Image.asset(
                      "Assets/videos/loading.gif",
                      fit: BoxFit.contain,
                    ),
                    message: "Descargando vídeos... $progressVideos%");
              });
            });
            await pr.hide();
            if (route == "videos") {
              await unarchiveAndSaveVideos(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            } else {
              await unarchiveAndSave(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            }
            prefs.setBool("downloadedVideo", true);
            print("finish");
            return true;
          });
    } catch (e) {
      toast(context, "Error al descargar vídeos. Reintentando...", red);
      print(e.toString());
      return false;
    }
  }

  Future downloadAudios(
      String url,
      String filename,
      BuildContext context,
      String messageAlert,
      String route,
      String platform,
      ProgressDialog pr) async {
    var dir = await getApplicationDocumentsDirectory();
    var prefs = await SharedPreferences.getInstance();
    try {
      await retry(
          numberOfRetries: 100,
          function: () async {
            await dio.download(url, "${dir.path}/$route/$filename",
                onReceiveProgress: (rec, total) {
              setState(() {
                progressAudios = ((rec / total) * 100).floor().toString();
                pr.update(
                    progressWidget: Image.asset(
                      "Assets/videos/loading.gif",
                      fit: BoxFit.contain,
                    ),
                    message:
                        "Descargando audios de ejercicios... $progressAudios%");
              });
            });
            await pr.hide();
            if (route == "videos") {
              await unarchiveAndSaveVideos(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            } else {
              await unarchiveAndSave(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            }
            print("finish");
            prefs.setBool("downloadedAudioExercises", true);
          });
    } catch (e) {
      print(e.toString());
    }
  }

  Future downloadTips(
      String url,
      String filename,
      BuildContext context,
      String messageAlert,
      String route,
      String platform,
      ProgressDialog pr) async {
    var dir = await getApplicationDocumentsDirectory();
    try {
      await retry(
          numberOfRetries: 100,
          function: () async {
            var res = await dio.download(url, "${dir.path}/$route/$filename",
                options: Options(
                    responseType: ResponseType.bytes,
                    followRedirects: false,
                    validateStatus: (status) {
                      return status < 500;
                    }), onReceiveProgress: (rec, total) {
              setState(() {
                progressTips = ((rec / total) * 100).floor().toString();
                pr.update(
                    progressWidget: Image.asset(
                      "Assets/videos/loading.gif",
                      fit: BoxFit.contain,
                    ),
                    message: "Descargando audios de tips... $progressTips%");
              });
            });
            await pr.hide();
            if (route == "videos") {
              await unarchiveAndSaveVideos(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            } else {
              await unarchiveAndSave(File("${dir.path}/$route/$filename"),
                  context, route, platform);
            }
            print(res.data);
          });
    } catch (e) {
      print("EEEEEEEERRORRR");
      print(e.toString());
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
    return null;
  }

  void _restartApp() async {
    FlutterRestart.restartApp();
  }

  @override
  void initState() {
    setState(() {
      loaded = false;
    });

    dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    if (Platform.isAndroid) {
      getAllAndroid();
    } else if (Platform.isIOS) {
      getAllIos();
    }

    // getData();
    super.initState();
  }

  compareVersions() async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    String platform = "";
    if (Platform.isAndroid) {
      setState(() {
        platform = "android";
      });
    } else if (Platform.isIOS) {
      setState(() {
        platform = "ios";
      });
    }
    if (hasInternet) {
      try {
        Response response = await dio.post("$urlServer/api/mobile/version",
            data: {"platform": platform, "type": "appVersion"});
        if (response.data["version"] != versionApp) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (_) {
                return WillPopScope(
                  onWillPop: pop,
                  child: AlertDialog(
                    title: Text(
                      '${response.data["message"]}',
                      style: TextStyle(color: blue),
                      textAlign: TextAlign.center,
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Quizás más tarde',
                          style: TextStyle(fontSize: 6.0.w, color: red),
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          _launchURL();
                        },
                        child: Text(
                          'Descargar',
                          style: TextStyle(fontSize: 6.0.w, color: blue),
                        ),
                      ),
                    ],
                  ),
                );
              });
        } else {
          print("ya está actualizado");
        }
      } catch (e) {
        print(e);
        toast(context, "Ha ocurrido un error, inténtalo más tarde.", red);
      }
    }
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }

  void _launchURL() async => await canLaunch(Platform.isAndroid
          ? _urlAndroid
          : Platform.isIOS
              ? _urlIphone
              : null)
      ? await launch(Platform.isAndroid
          ? _urlAndroid
          : Platform.isIOS
              ? _urlIphone
              : null)
      : throw 'Could not launch';

  iosPopup() async {
    var prefs = await SharedPreferences.getInstance();
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) => CupertinoActionSheet(
              title: Text(
                "Descarga de datos adicionales",
                style: TextStyle(fontSize: 10.0.sp),
              ),
              message: Text(
                  "Para poder realizar las clases es necesario descargar los videos y audios correspondientes. Los datos pesan aproximadamente 300 Mb. (megabytes)",
                  style: TextStyle(fontSize: 9.0.sp)),
              actions: [
                CupertinoButton(
                  child: Text('Aceptar y Descargar',
                      style: TextStyle(fontSize: 10.0.sp)),
                  onPressed: () async {
                    prefs.setBool("notaccepted", false);
                    // Do something
                    Navigator.of(context).pop();
                    notaccepted = false;
                    await getEvidence();
                    await getData();
                    await getClasses();
                    await getPhase();
                    await DownloadData().downloadCustomClasses(context);
                    setState(() {
                      loaded = true;
                    });
                    prefs.setBool("downloaded", true);
                    print('I agreed');
                  },
                )
              ],
              cancelButton: CupertinoButton(
                  child: Text(
                    'Cancelar',
                    style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 10.0.sp),
                  ),
                  onPressed: () {
                    setState(() {});
                    Navigator.of(context).pop();
                  }),
            ));
  }

  getAllIos() async {
    var prefs = await SharedPreferences.getInstance();
    var downloaded = prefs.getBool("downloaded" ?? false);
    notaccepted = prefs.getBool("notaccepted" ?? true);
    if (downloaded == null || downloaded == false) {
      try {
        if (Device.get().isIos) {
          await getEvidence();
          await getData();
          await getClasses();
          await getPhase();
          await DownloadData().downloadCustomClasses(context);
          setState(() {
            loaded = true;
          });
          prefs.setBool("downloaded", true);
          _restartApp();
        } else {
          await getEvidence();
          await getData();
          await getClasses();
          await getPhase();
          await DownloadData().downloadCustomClasses(context);
          setState(() {
            loaded = true;
          });
          prefs.setBool("downloaded", true);
          _restartApp();
        }
      } catch (e) {
        print(e);
      }
    } else {
      try {
        CourseDataRepository courseDataRepository = GetIt.I.get();
        var course = await courseDataRepository.getAllCourse();
        print(course[0].courseId);
        await getEvidence();
        await getClasses();
        await getPhase();
        await DownloadData().downloadCustomClasses(context);
        setState(() {
          loaded = true;
        });
        //compareVersions();
      } catch (e) {
        print(e);
      }
    }
  }

  getAllAndroid() async {
    await DownloadData().downloadEvidencesData(context);
    var prefs = await SharedPreferences.getInstance();
    var downloaded = prefs.getBool("downloaded" ?? false);
    if (downloaded == null || downloaded == false) {
      try {
        await getEvidence();
        await getData();
        await getClasses();
        await getPhase();
        await DownloadData().downloadCustomClasses(context);
        setState(() {
          loaded = true;
        });
        prefs.setBool("downloaded", true);
        _restartApp();
      } catch (e) {
        print(e);
      }
    } else {
      try {
        CourseDataRepository courseDataRepository = GetIt.I.get();
        var course = await courseDataRepository.getAllCourse();
        print(course[0].courseId);
        await getEvidence();
        await getClasses();
        await getPhase();
        await DownloadData().downloadCustomClasses(context);
        setState(() {
          loaded = true;
        });
        compareVersions();
      } catch (e) {
        print(e);
      }
    }
  }

  Widget build(BuildContext context) {
    return noData
        ? Center(
            child: Text(
              "No existen clases aún.",
              style: TextStyle(color: Colors.white, fontSize: 7.0.w),
            ),
          )
        : loaded
            ? body()
            : notaccepted == false
                ? body()
                : Center(
                    child: Image.asset(
                      "Assets/videos/loading.gif",
                      fit: BoxFit.contain,
                      width: 30.0.w,
                    ),
                  );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            Flexible(
              flex: 1,
              child: Scrollbar(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 5.0.w,
                          ),
                          Image.asset(
                            "Assets/images/LogoCompleto.png",
                            width: 13.5.w,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 1.0.h,
                      ),
                      Stack(
                        children: [
                          InkWell(
                              onTap: () async {
                                // await DownloadData().downloadCustomClasses(context);
                                // setState(() {});
                                // getClasses();
                              },
                              child: divider(yellow, "FASE 1")),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 1
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 1 ? false : true,
                                dataClasses[0],
                                dataClasses[0].number,
                                true,
                                "1",
                                dataClasses[0].isCustom),
                            //fourth
                            item(
                                phasePhone >= 1 && evidences[2]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 1 ? false : true,
                                dataClasses[3],
                                dataClasses[3].number,
                                evidences[2] == true ? true : false,
                                "1",
                                dataClasses[3].isCustom),
                            //second
                            item(
                                phasePhone >= 1 && evidences[0]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 1 ? false : true,
                                dataClasses[1],
                                dataClasses[1].number,
                                evidences[0] ? true : false,
                                "1",
                                dataClasses[1].isCustom),
                            //third
                            item(
                                phasePhone >= 1 && evidences[1]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 1 ? false : true,
                                dataClasses[2],
                                dataClasses[2].number,
                                evidences[1] ? true : false,
                                "1",
                                dataClasses[2].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(green, "FASE 2"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 2 && evidences[3]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 2 ? false : true,
                                dataClasses[4],
                                dataClasses[4].number,
                                evidences[3] ? true : false,
                                "2",
                                dataClasses[4].isCustom),
                            //fourth
                            item(
                                phasePhone >= 2 && evidences[6]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 2 ? false : true,
                                dataClasses[7],
                                dataClasses[7].number,
                                evidences[6] ? true : false,
                                "2",
                                dataClasses[7].isCustom),
                            //second
                            item(
                                phasePhone >= 2 && evidences[4]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 2 ? false : true,
                                dataClasses[5],
                                dataClasses[5].number,
                                evidences[4] ? true : false,
                                "2",
                                dataClasses[5].isCustom),
                            //third
                            item(
                                phasePhone >= 2 && evidences[5]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 2 ? false : true,
                                dataClasses[6],
                                dataClasses[6].number,
                                evidences[5] ? true : false,
                                "2",
                                dataClasses[6].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(red, "FASE 3"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 3 && evidences[7]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 3 ? false : true,
                                dataClasses[8],
                                dataClasses[8].number,
                                evidences[7] ? true : false,
                                "3",
                                dataClasses[8].isCustom),
                            //fourth
                            item(
                                phasePhone >= 3 && evidences[10]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 3 ? false : true,
                                dataClasses[11],
                                dataClasses[11].number,
                                evidences[10] ? true : false,
                                "3",
                                dataClasses[11].isCustom),
                            //second
                            item(
                                phasePhone >= 3 && evidences[8]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 3 ? false : true,
                                dataClasses[9],
                                dataClasses[9].number,
                                evidences[8] ? true : false,
                                "3",
                                dataClasses[9].isCustom),
                            //third
                            item(
                                phasePhone >= 3 && evidences[9]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 3 ? false : true,
                                dataClasses[10],
                                dataClasses[10].number,
                                evidences[9] ? true : false,
                                "3",
                                dataClasses[10].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(yellow, "FASE 4"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 4 && evidences[11]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 4 ? false : true,
                                dataClasses[12],
                                dataClasses[12].number,
                                evidences[11] ? true : false,
                                "4",
                                dataClasses[12].isCustom),
                            //fourth
                            item(
                                phasePhone >= 4 && evidences[14]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 4 ? false : true,
                                dataClasses[15],
                                dataClasses[15].number,
                                evidences[14] ? true : false,
                                "4",
                                dataClasses[15].isCustom),
                            //second
                            item(
                                phasePhone >= 4 && evidences[12]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 4 ? false : true,
                                dataClasses[13],
                                dataClasses[13].number,
                                evidences[12] ? true : false,
                                "4",
                                dataClasses[13].isCustom),
                            //third
                            item(
                                phasePhone >= 4 && evidences[13]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 4 ? false : true,
                                dataClasses[14],
                                dataClasses[14].number,
                                evidences[13] ? true : false,
                                "4",
                                dataClasses[14].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(green, "FASE 5"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 5 && evidences[15]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 5 ? false : true,
                                dataClasses[16],
                                dataClasses[16].number,
                                evidences[15] ? true : false,
                                "5",
                                dataClasses[16].isCustom),
                            //fourth
                            item(
                                phasePhone >= 5 && evidences[18]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 5 ? false : true,
                                dataClasses[19],
                                dataClasses[19].number,
                                evidences[18] ? true : false,
                                "5",
                                dataClasses[19].isCustom),
                            //second
                            item(
                                phasePhone >= 5 && evidences[16]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 5 ? false : true,
                                dataClasses[17],
                                dataClasses[17].number,
                                evidences[16] ? true : false,
                                "5",
                                dataClasses[17].isCustom),
                            //third
                            item(
                                phasePhone >= 5 && evidences[17]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 5 ? false : true,
                                dataClasses[18],
                                dataClasses[18].number,
                                evidences[17] ? true : false,
                                "5",
                                dataClasses[18].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(red, "FASE 6"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 6 && evidences[19]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 6 ? false : true,
                                dataClasses[20],
                                dataClasses[20].number,
                                evidences[19] ? true : false,
                                "6",
                                dataClasses[20].isCustom),
                            //fourth
                            item(
                                phasePhone >= 6 && evidences[22]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 6 ? false : true,
                                dataClasses[23],
                                dataClasses[23].number,
                                evidences[22] ? true : false,
                                "6",
                                dataClasses[23].isCustom),
                            //second
                            item(
                                phasePhone >= 6 && evidences[20]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 6 ? false : true,
                                dataClasses[21],
                                dataClasses[21].number,
                                evidences[20] ? true : false,
                                "6",
                                dataClasses[21].isCustom),
                            //third
                            item(
                                phasePhone >= 6 && evidences[21]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 6 ? false : true,
                                dataClasses[22],
                                dataClasses[22].number,
                                evidences[21] ? true : false,
                                "6",
                                dataClasses[22].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(yellow, "FASE 7"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 7 && evidences[23]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 7 ? false : true,
                                dataClasses[24],
                                dataClasses[24].number,
                                evidences[23] ? true : false,
                                "7",
                                dataClasses[24].isCustom),
                            //fourth
                            item(
                                phasePhone >= 7 && evidences[26]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 7 ? false : true,
                                dataClasses[27],
                                dataClasses[27].number,
                                evidences[26] ? true : false,
                                "7",
                                dataClasses[27].isCustom),
                            //second
                            item(
                                phasePhone >= 7 && evidences[24]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 7 ? false : true,
                                dataClasses[25],
                                dataClasses[25].number,
                                evidences[24] ? true : false,
                                "7",
                                dataClasses[25].isCustom),
                            //third
                            item(
                                phasePhone >= 7 && evidences[25]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 7 ? false : true,
                                dataClasses[26],
                                dataClasses[26].number,
                                evidences[25] ? true : false,
                                "7",
                                dataClasses[26].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(green, "FASE 8"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 8 && evidences[27]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 8 ? false : true,
                                dataClasses[28],
                                dataClasses[28].number,
                                evidences[27] ? true : false,
                                "8",
                                dataClasses[28].isCustom),
                            //fourth
                            item(
                                phasePhone >= 8 && evidences[30]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 8 ? false : true,
                                dataClasses[31],
                                dataClasses[31].number,
                                evidences[30] ? true : false,
                                "8",
                                dataClasses[31].isCustom),
                            //second
                            item(
                                phasePhone >= 8 && evidences[28]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 8 ? false : true,
                                dataClasses[29],
                                dataClasses[29].number,
                                evidences[28] ? true : false,
                                "8",
                                dataClasses[29].isCustom),
                            //third
                            item(
                                phasePhone >= 8 && evidences[29]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 8 ? false : true,
                                dataClasses[30],
                                dataClasses[30].number,
                                evidences[29] ? true : false,
                                "8",
                                dataClasses[30].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(red, "FASE 9"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 9 && evidences[31]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 9 ? false : true,
                                dataClasses[32],
                                dataClasses[32].number,
                                evidences[31] ? true : false,
                                "9",
                                dataClasses[32].isCustom),
                            //fourth
                            item(
                                phasePhone >= 9 && evidences[34]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 9 ? false : true,
                                dataClasses[35],
                                dataClasses[35].number,
                                evidences[34] ? true : false,
                                "9",
                                dataClasses[35].isCustom),
                            //second
                            item(
                                phasePhone >= 9 && evidences[32]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 9 ? false : true,
                                dataClasses[33],
                                dataClasses[33].number,
                                evidences[32] ? true : false,
                                "9",
                                dataClasses[33].isCustom),
                            //third
                            item(
                                phasePhone >= 9 && evidences[33]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 9 ? false : true,
                                dataClasses[34],
                                dataClasses[34].number,
                                evidences[33] ? true : false,
                                "9",
                                dataClasses[34].isCustom),
                          ]),
                        ],
                      ),
                      Stack(
                        children: [
                          divider(yellow, "FASE 10"),
                          createPhase([
                            //first
                            item(
                                phasePhone >= 10 && evidences[35]
                                    ? "Assets/images/buttons/2unlock.png"
                                    : "Assets/images/buttons/2lock.png",
                                phasePhone == 10 ? false : true,
                                dataClasses[36],
                                dataClasses[36].number,
                                evidences[35] ? true : false,
                                "10",
                                dataClasses[36].isCustom),
                            //fourth
                            item(
                                phasePhone >= 10 && evidences[38]
                                    ? "Assets/images/buttons/3unlock.png"
                                    : "Assets/images/buttons/3lock.png",
                                phasePhone == 10 ? false : true,
                                dataClasses[39],
                                dataClasses[39].number,
                                evidences[38] ? true : false,
                                "10",
                                dataClasses[39].isCustom),
                            //second
                            item(
                                phasePhone >= 10 && evidences[36]
                                    ? "Assets/images/buttons/1unlock.png"
                                    : "Assets/images/buttons/1lock.png",
                                phasePhone == 10 ? false : true,
                                dataClasses[37],
                                dataClasses[37].number,
                                evidences[36] ? true : false,
                                "10",
                                dataClasses[37].isCustom),
                            //third
                            item(
                                phasePhone >= 10 && evidences[37]
                                    ? "Assets/images/buttons/4unlock.png"
                                    : "Assets/images/buttons/4lock.png",
                                phasePhone == 10 ? false : true,
                                dataClasses[38],
                                dataClasses[38].number,
                                evidences[37] ? true : false,
                                "10",
                                dataClasses[38].isCustom),
                          ])
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 25.0.w,
          height: 9.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Center(
              child: Text(
            "$text",
            style: TextStyle(color: Colors.white, fontSize: 5.0.w),
          )),
        )
      ],
    );
  }

  Widget item(String route, bool phase, var data, int number, bool lock,
      String phaseNumber, bool isCustom) {
    return InkWell(
      onTap: () {
        if (Platform.isIOS && notaccepted == true ||
            Platform.isIOS && notaccepted == null) {
          iosPopup();
        } else {
          print(evidences.toString());
          print(lock);
          if (lock == true) {
            goToPlanification(data, number, false, null, phaseNumber, isCustom);
          } else {
            print(lock);
            toast(context, "Debes completar las clases anteriores.", red);
          }
        }
      },
      child: Device.get().isTablet
          ? Container(
              //Tablet
              height: 25.0.h,
              width: 40.0.w,
              child: Image.asset(
                route,
                fit: BoxFit.contain,
              ),
            )
          : Container(
              height: 25.0.h,
              width: 40.0.w,
              child: Image.asset(
                route,
                fit: BoxFit.contain,
              ),
            ),
    );
  }

  Widget circularActivity(
      String title, double percentage, String img, String number, bool lock) {
    return Padding(
      padding: const EdgeInsets.only(left: 9.0, right: 9),
      child: InkWell(
          onTap: () {},
          child: Stack(
            children: [
              Container(
                width: 35.0.w,
                // color: red,
                child: CircularPercentIndicator(
                  percent: percentage,
                  progressColor: green,
                  lineWidth: 7,
                  radius: 29.0.w,
                  center: CircleAvatar(
                    radius: 12.8.w,
                    backgroundColor: lock ? Colors.grey : yellow,
                    child: ColorFiltered(
                      colorFilter: lock
                          ? ColorFilter.mode(
                              Colors.grey,
                              BlendMode.saturation,
                            )
                          : ColorFilter.mode(
                              Colors.transparent,
                              BlendMode.multiply,
                            ),
                      child: Container(
                        margin: lock ? EdgeInsets.all(6.5) : EdgeInsets.all(0),
                        color: Colors.transparent,
                        child: Image.asset(
                          "$img",
                          fit: lock ? BoxFit.contain : BoxFit.cover,
                          width: lock ? 14.0.w : 20.0.w,
                          height: lock ? 20.0.h : 20.0.h,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 20.0.w,
                left: 22.0.w,
                child: CircularPercentIndicator(
                  lineWidth: 7,
                  radius: 9.0.w,
                  center: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                        child: lock
                            ? Image.asset(
                                "Assets/images/lock.png",
                                width: 4.0.w,
                              )
                            : Image.asset(
                                "Assets/images/unlock.png",
                                width: 5.0.w,
                              )),
                  ),
                ),
              )
            ],
          )),
    );
  }

  Widget createPhase(List sessions) {
    return Container(
      height: Device.get().isTablet ? 60.0.h : 57.0.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                height: 0.5.h,
              ),
              sessions[0],
              // item("Assets/images/buttons/2unlock.png"),
              SizedBox(
                height: Device.get().isTablet ? 9.5.h : 6.0.h,
              ),
              sessions[1],
              // item("Assets/images/buttons/2lock.png"),
            ],
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    sessions[2],
                    // item("Assets/images/buttons/1lock.png"),
                    Device.get().isTablet
                        ? SizedBox(
                            width: 20.0.w,
                          )
                        : SizedBox(
                            width: 20.0.w,
                          ),
                    sessions[3],
                    // item("Assets/images/buttons/4lock.png"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
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
