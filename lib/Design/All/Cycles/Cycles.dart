import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Functions/createError.dart';
import 'package:movitronia/Functions/downloadTeacher.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import '../../../Utils/UrlServer.dart';
import '../../Widgets/Toast.dart';
import 'dart:developer';
import 'package:archive/archive.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Utils/ConnectionState.dart';

class Cycles extends StatefulWidget {
  final String courseId;
  Cycles({this.courseId});
  @override
  _CyclesState createState() => _CyclesState();
}

class _CyclesState extends State<Cycles> {
  bool downloaded = false;
  bool downloading = false;
  List courses = [];
  bool loaded = false;
  List coursesNumber = [];
  var progress = "0.0";
  var maxTotal = 100.0;
  var _url =
      'https://play.google.com/store/apps/details?id=com.movitronia.michcom';

  downloadAll() async {
    ProgressDialog prInfo;
    prInfo = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var down = prefs.getBool("downloaded" ?? false);
    var downloadedVideo = prefs.getBool("downloadedVideo" ?? false);

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
    var dio = Dio();
    Response responseVideos = await dio.post(
        "https://intranet.movitronia.com/api/mobile/videosZip?token=$token",
        data: {"platform": platform});

    if (downloaded == false || downloaded == null) {
      if (downloadedVideo == false || downloadedVideo == null) {
        await downloadFiles(
            url: responseVideos.data,
            platform: platform,
            filename: "videos.zip",
            context: context,
            messageAlert: "Descargando vídeos...",
            route: "videos");

        // await downloadFiles(response.data, "videos.zip");
        // downloadFiles(url, filenames)
      } else {
        print("Ya descargados los videos");
      }
    }

    if (downloaded == false || downloaded == null) {
      prInfo.show();
      setState(() {
        prInfo.update(message: "Descargando datos de ejercicios...");
      });
      await DownloadTeacher().getExercises(context);
      prInfo.hide();
    }
  }

  getCourses() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var dio = Dio();
    log("TESTING " +
        "$urlServer/api/mobile/professor/course/${widget.courseId}?token=$token");
    try {
      Response responseCourses = await dio.get(
          "$urlServer/api/mobile/professor/course/${widget.courseId}?token=$token");
      log(responseCourses.data.toString());
      for (var i = 0; i < responseCourses.data.length; i++) {
        setState(() {
          courses.add(responseCourses.data[i]);
          coursesNumber.add(int.parse(responseCourses.data[i]["number"]));
        });
      }
      setState(() {
        loaded = true;
      });
    } catch (e) {
      CreateError().createError(dio, e.response.toString(), "Cycles");
      log(e.response.toString());
    }
  }

  compareVersions() async {
    var dio = Dio();
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
                      'Hay una nueva versión disponible en la tienda, será necesario que actualices para continuar.',
                      style: TextStyle(color: blue),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          _launchURL();
                        },
                        child: Text(
                          'Descargar',
                          style: TextStyle(fontSize: 6.0.w, color: red),
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
        CreateError().createError(
            dio,
            "${e.toString()} No se ha podido verificar la versión de la aplicación",
            "Cycles");
        print(e);
        toast(context, "No se ha podido verificar la versión de la aplicación.",
            red);
      }
    }
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  Future<bool> pop() async {
    print("back");
    return false;
  }

  @override
  void initState() {
    if (downloaded == false) {
      downloadAll();
    }
    compareVersions();
    getCourses();
    super.initState();
  }

  Widget build(BuildContext context) {
    return loaded
        ? body()
        : Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          );
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5.0.w,
                ),
                Image.asset(
                  "Assets/images/LogoCompleto.png",
                  width: 18.0.w,
                )
              ],
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.0.h,
                    ),
                    divider(green, "PRIMER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(""),
                        element(green, 1, "RO",
                            coursesNumber.contains(1) ? true : false, "1", 1),
                        element(green, 2, "DO",
                            coursesNumber.contains(2) ? true : false, "2", 1),
                        element(green, 3, "RO",
                            coursesNumber.contains(3) ? true : false, "3", 1),
                        element(green, 4, "TO",
                            coursesNumber.contains(4) ? true : false, "4", 1),
                        Text("")
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(red, "SEGUNDO CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(red, 5, "TO",
                            coursesNumber.contains(5) ? true : false, "5", 2),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(red, 6, "TO",
                            coursesNumber.contains(6) ? true : false, "6", 2),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(yellow, "TERCER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(yellow, 7, "TO",
                            coursesNumber.contains(7) ? true : false, "7", 3),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(yellow, 8, "VO",
                            coursesNumber.contains(8) ? true : false, "8", 3),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget element(Color color, int course, String fin, bool check,
      String nameCycle, int cycle) {
    return InkWell(
      onTap: () {
        // print(courses.toString());
        if (check) {
          goToshowCycle(nameCycle, cycle, courses);
        } else {
          toast(context, "No tienes este curso asignado.".toUpperCase(), red);
        }
      },
      child: Container(
        width: 16.0.w,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 8.0.w,
              backgroundColor: check ? color : Colors.grey,
              child: CircleAvatar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$course",
                            style: TextStyle(
                                color: check ? blue : Colors.grey,
                                fontSize: 9.0.w)),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text(
                          "$fin",
                          style: TextStyle(
                            color: check ? blue : Colors.grey,
                            fontSize: 3.0.w,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                radius: 6.5.w,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 65.0.w,
          height: 8.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 7.0.w,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 6.5.w,
                    child: Image.asset(
                      "Assets/images/sessionIcon.png",
                      fit: BoxFit.contain,
                      width: 10.0.w,
                      color: color,
                    )),
              ),
              Center(
                  child: Text(
                "$text ",
                style: TextStyle(color: Colors.white, fontSize: 5.0.w),
              )),
            ],
          ),
        )
      ],
    );
  }

  Future downloadFiles(
      {String url,
      String filename,
      BuildContext context,
      String messageAlert,
      String route,
      String platform}) async {
    ProgressDialog pr;
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: false);
    var prefs = await SharedPreferences.getInstance();
    var dir = await getApplicationDocumentsDirectory();
    var dio = Dio();
    await pr.show();
    pr.style(message: "Comenzando descarga de vídeos...");
    await dio.download(url, "${dir.path}/$route/$filename",
        onReceiveProgress: (rec, total) {
      setState(() {
        progress = ((rec / total) * 100).floor().toString();
        pr.update(
          progressWidget: Image.asset(
            "Assets/videos/loading.gif",
            fit: BoxFit.contain,
          ),
          message: "Descargando vídeos...$progress%",
        );
      });
    });

    setState(() {
      prefs.setBool("downloadedVideo", true);
      pr.update(message: "Extrayendo vídeos...");
    });
    if (route == "videos") {
      await unarchiveAndSaveVideos(
          File("${dir.path}/$route/$filename"), context, route, platform);
    } else {
      await unarchiveAndSave(
          File("${dir.path}/$route/$filename"), context, route, platform);
    }

    setState(() {
      pr.hide();
    });
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
}
