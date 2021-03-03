import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/evidencesSend.dart';
import 'package:movitronia/Database/Repository/EvidencesSentRepository.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'dart:developer';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  Timer timer;
  int _start = 10;
  int _text = 2;
  bool text = false;
  bool createdEvidence = false;

  @override
  void initState() {
    startText();
    insertEvidencesFalse();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            "Assets/images/wall.jpg",
            fit: BoxFit.cover,
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.30,
              ),
              Center(
                child: ElasticIn(
                  duration: Duration(seconds: 2),
                  child: Image.asset(
                    "Assets/images/logoTextBlue.png",
                    scale: 1.0,
                    width: 50.0.w,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              text == false
                  ? SizedBox()
                  : Center(
                      child: InkWell(
                        // onTap: () => gotoIntro(),
                        child: FadeIn(
                          duration: Duration(seconds: 1),
                          child: Image.asset(
                            "Assets/images/LogoText.png",
                            scale: 1.5,
                            color: blue,
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ]),
    );
  }

  void startTimer() async {
    List colleges = [];
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token") ?? null;
    String scope = prefs.getString("scope");
    var dio = Dio();
    Response resProfessorData;
    if (scope == "professor") {
      resProfessorData =
          await dio.get("$urlServer/api/mobile/user/course?token=$token");
    }

    _start = 2;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            print(token.toString());
            if (token != null) {
              getPhase(token);
            }
            // OtherController().insertData();
            bool logged = prefs.getBool("logged") ?? false;

            if (logged) {
              if (scope == "user") {
                goToHome(scope);
              } else {
                for (var i = 0; i < resProfessorData.data.length; i++) {
                  print(resProfessorData.data[i].toString());
                  if (colleges.toString().contains(
                      resProfessorData.data[i]["college"]["_id"].toString())) {
                    print("Ya existe");
                  } else {
                    colleges.add({
                      "_id": resProfessorData.data[i]["college"]["_id"],
                      "name": resProfessorData.data[i]["college"]["name"],
                      "selected": false
                    });
                  }
                }
                log(resProfessorData.data.toString());
                if (colleges.length > 1) {
                  goToTeacherSelectCollege();
                } else {
                  goToHome(scope);
                }
              }
            } else {
              goToLogin();
            }
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  void startText() async {
    _text = 1;
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_text < 1) {
            timer.cancel();
            text = true;
            startTimer();
          } else {
            _text = _text - 1;
          }
        },
      ),
    );
  }

  getPhase(String token) async {
    bool hasInternet = await ConnectionStateClass().comprobationInternet();
    var prefs = await SharedPreferences.getInstance();
    if (hasInternet) {
      try {
        var dio = Dio();
        var response = await dio.get(
          "$urlServer/api/mobile/phase/chile?token=$token",
        );
        if (response.statusCode == 200) {
          print(response.data);
          prefs.setInt("phase", int.parse(response.data));
          print("Se ha actualizado la phase");
        } else if (response.statusCode == 404) {
          print("ERROR 404 $response");
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("SIN INTERNET");
    }
  }

  insertEvidencesFalse() async {
    var prefs = await SharedPreferences.getInstance();
    var createdEvidence1 = prefs.getBool("createdEvidence");
    if (createdEvidence1 == null) {
      setState(() {
        createdEvidence = false;
      });
    } else {
      setState(() {
        createdEvidence = createdEvidence1;
      });
    }
    if (createdEvidence) {
      print("ok");
    } else {
      EvidencesRepository evidencesRepository = GetIt.I.get();
      for (var i = 0; i < 40; i++) {
        print(i);
        EvidencesSend evidencesSend = EvidencesSend(
            number: i + 1,
            kilocalories: null,
            idEvidence: null,
            phase: null,
            classObject: null,
            finished: false);
        await evidencesRepository.insertEvidence(evidencesSend);
        prefs.setBool("createdEvidence", true);
      }
    }
  }
}
