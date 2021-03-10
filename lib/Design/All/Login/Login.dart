import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:dart_rut_validator/dart_rut_validator.dart';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'dart:developer';
import 'package:get_it/get_it.dart';
import '../../../Database/Models/evidencesSend.dart';
import '../../../Database/Repository/EvidencesSentRepository.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController rut = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool validated = false;
  bool isValid = false;
  bool passIsValid = false;
  bool passIsHide = true;
  bool accessWithEmail = false;
  var uuid;
  int count = 0;

  validateRutOrEMail(String data) {
    if (data.contains("@") || data.length > 12) {
      bool emailValid =
          RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
              .hasMatch(data);
      print(emailValid);
      setState(() {
        accessWithEmail = true;
      });
      if (emailValid) {
        setState(() {
          isValid = true;
        });
      } else {
        toast(context, "Ingresa un correo válido.", red);
        setState(() {
          isValid = false;
        });
      }
    } else {
      data = data.replaceAll("-", "").replaceAll(".", "");
      var text = data;
      var numbers = int.parse(text.substring(0, text.length - 1));
      var dv = text.substring(text.length - 1);
      if (RUTValidator(numbers: numbers, dv: dv).isValid) {
        setState(() {
          rut.text = RUTValidator.formatFromText(data);
          isValid = true;
        });
      } else {
        setState(() {
          isValid = false;
          accessWithEmail = false;
        });
        toast(context, "Ingresa un rut válido.", red);
      }
    }
  }

  void onChangedPass(String text) {
    _formKey.currentState.validate();
    if (_formKey.currentState.validate()) {
      setState(() {
        passIsValid = true;
      });
    } else {
      setState(() {
        passIsValid = false;
      });
    }
  }

  obtainUuid() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      setState(() {
        uuid = iosInfo.identifierForVendor;
      });
      print(iosInfo.identifierForVendor);
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      setState(() {
        uuid = androidInfo.androidId;
      });
      print(androidInfo.androidId);
    }
  }

  @override
  void initState() {
    obtainUuid();
    super.initState();
  }

  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: w,
              height: h,
              color: blue,
            ),
            SingleChildScrollView(
              physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: size.height,
                    child: Column(
                      children: [
                        SizedBox(
                          height: h * 0.25,
                        ),
                        FadeIn(
                          duration: Duration(milliseconds: 1500),
                          child: Container(
                            width: w * 0.5,
                            height: h * 0.2,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "Assets/images/LogoCompleto.png"),
                                    fit: BoxFit.contain)),
                          ),
                        ),
                        SizedBox(
                          height: h * 0.05,
                        ),
                        //
                        Column(
                          children: [
                            ZoomIn(
                              duration: Duration(seconds: 1),
                              child: Form(
                                key: _formKey,
                                child: FadeInLeft(
                                  duration: Duration(milliseconds: 500),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(right: 10.0, left: 10),
                                    child: isValid
                                        ? FlipInY(
                                            duration: Duration(seconds: 1),
                                            child: Container(
                                              width: w * 0.8,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(50))),
                                              child: TextFormField(
                                                  obscureText: passIsHide,
                                                  // validator: (value) => pass
                                                  //             .text.length <=
                                                  //         7
                                                  //     ? "La contraseña es demasiado corta"
                                                  //     : null,
                                                  onChanged: onChangedPass,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: blue,
                                                      fontSize: w * 0.07),
                                                  decoration: InputDecoration(
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 2.0),
                                                      child: InkWell(
                                                        onTap: () {
                                                          print("a");
                                                          validateRutOrEMail(
                                                              rut.text);
                                                          if (isValid &&
                                                              pass.text
                                                                  .isNotEmpty) {
                                                            loginConnect();
                                                          }
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 6.0.w,
                                                          backgroundColor: blue,
                                                          child: Center(
                                                            child: Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 7.0.w,
                                                              color:
                                                                  Colors.white,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    suffixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 8.0),
                                                      child: IconButton(
                                                          iconSize: w * 0.07,
                                                          icon: Icon(
                                                            Icons
                                                                .remove_red_eye,
                                                            color: passIsHide
                                                                ? Colors.grey
                                                                : blue,
                                                          ),
                                                          onPressed: () {
                                                            setState(() {
                                                              passIsHide =
                                                                  !passIsHide;
                                                            });
                                                          }),
                                                    ),
                                                    border: InputBorder.none,
                                                    counterText: "",
                                                    labelStyle:
                                                        TextStyle(color: blue),
                                                    hintText: "CONTRASEÑA",
                                                    hintStyle: TextStyle(
                                                        color: blue,
                                                        fontSize: w * 0.07),
                                                  ),
                                                  controller: pass),
                                            ))
                                        : FlipInX(
                                            child: Container(
                                                width: w * 0.8,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: TextFormField(
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: blue,
                                                        fontSize: w * 0.07),
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                      prefixIcon: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 2.0),
                                                        child: InkWell(
                                                          onTap: () {
                                                            print("A");
                                                            validateRutOrEMail(
                                                                rut.text);
                                                            if (isValid &&
                                                                pass.text
                                                                    .isNotEmpty) {
                                                              loginConnect();
                                                            }
                                                          },
                                                          child: CircleAvatar(
                                                            radius: 6.0.w,
                                                            backgroundColor:
                                                                blue,
                                                            child: Center(
                                                              child: Icon(
                                                                Icons
                                                                    .arrow_forward_ios,
                                                                size: 7.0.w,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      border: InputBorder.none,
                                                      counterText: "",
                                                      labelStyle: TextStyle(
                                                          color: blue,
                                                          fontSize: w * 0.07),
                                                      hintText: "RUT O EMAIL",
                                                      hintStyle: TextStyle(
                                                          color: blue,
                                                          fontSize: w * 0.07),
                                                    ),
                                                    validator: RUTValidator(
                                                            validationErrorText:
                                                                '         Rut no válido')
                                                        .validator,
                                                    controller: rut)),
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3.0.h,
                            ),
                            InkWell(
                              onTap: () {
                                goToRecoverPass();
                              },
                              child: Text(
                                "¿Olvidaste tu contraseña?",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 6.0.w),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ],
        ),
      ),
    );
  }

  loginConnect() async {
    List colleges = [];
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
            "Cargando...",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 6.0.w),
          ));
      var prefs = await SharedPreferences.getInstance();
      try {
        var dio = Dio();
        var response = await dio.post("$urlServer/api/mobile/login", data: {
          accessWithEmail ? "email" : "rut": accessWithEmail
              ? rut.text.trim()
              : rut.text.trim().replaceAll(".", "").replaceAll("-", ""),
          "password": pass.text.trim(),
          "uuid": uuid.toString()
        });
        if (response.statusCode == 200) {
          prefs.setString("token", response.data);
          var token = prefs.getString("token");
          final parts = token.split('.');
          final payload = parts[1];
          var decoded = B64urlEncRfc7515.decodeUtf8(payload);
          var encode = jsonDecode(decoded);
          prefs.setBool("logged", true);
          prefs.setString("rut", encode["rut"].toString());
          prefs.setString("id", encode["iss"].toString());
          prefs.setString("uuid", uuid.toString());
          prefs.setString("email", encode["email"].toString());
          prefs.setString("name", encode["name"].toString());
          prefs.setString("scope", encode["scope"].toString());
          prefs.setString("charge", encode["charge"].toString());
          prefs.setBool("dev", encode["dev"]);
          prefs.setBool("termsAccepted", encode["termsAccepted"]);
          toastBottom(context, "Ingresando...", green);

          print(prefs.getBool("dev").toString());
          print(encode.toString());

          bool termsAccepted = prefs.getBool("termsAccepted") ?? false;
          String role = prefs.getString("scope");
          getPhase(token);
          if (termsAccepted) {
            var responseAllData = await dio.get(
              "$urlServer/api/mobile/userData?token=$token",
            );
            log(responseAllData.data.toString());
            if (role == "user") {
              prefs.setString(
                  "phone", responseAllData.data["phone"].toString());
              prefs.setString(
                  "weight", responseAllData.data["weight"].toString());
              prefs.setString(
                  "height", responseAllData.data["height"].toString());
              prefs.setString(
                  "birthday", responseAllData.data["birthday"].toString());
              prefs.setString(
                  "gender", responseAllData.data["gender"].toString());
              prefs.setString(
                  "frequencyOfPhysicalActivity",
                  responseAllData.data["frequencyOfPhysicalActivity"]
                      .toString());
              prefs.setString("nationality",
                  responseAllData.data["nationality"].toString());
              prefs.setString(
                  "status", responseAllData.data["status"].toString());
              prefs.setString(
                  "membership", responseAllData.data["membership"].toString());

              EvidencesRepository evidencesRepository = GetIt.I.get();
              for (var i = 0; i < 40; i++) {
                print(i);

                var res = await evidencesRepository.getEvidenceNumber(i + 1);
                if (res.isEmpty) {
                  EvidencesSend evidencesSend = EvidencesSend(
                      number: i + 1,
                      kilocalories: null,
                      idEvidence: null,
                      phase: null,
                      classObject: null,
                      finished: false);
                  print("Se nsertó una evidencia");
                  await evidencesRepository.insertEvidence(evidencesSend);
                } else {
                  EvidencesSend evidencesSend = EvidencesSend(
                      number: i + 1,
                      kilocalories: res[0].kilocalories,
                      idEvidence: res[0].idEvidence,
                      phase: res[0].phase,
                      classObject: res[0].classObject,
                      finished: res[0].finished);
                  print("Se actualizó una evidencia");
                  await evidencesRepository.updateEvidence(evidencesSend);
                }
              }
              goToHome("user", {});
            } else {
              print("TOKEEEEEEEEEEN $token");
              var resProfessorData = await dio
                  .get("$urlServer/api/mobile/user/course?token=$token");
              log(resProfessorData.data.toString());
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
              if (colleges.length == 0) {
                toast(context, "No posees colegios asignados.", red);
                Navigator.pop(context);
              } else if (colleges.length > 1) {
                goToTeacherSelectCollege();
              } else {
                goToHome("professor", colleges[0]);
              }
            }
          } else {
            print(token);
            print(encode);
            goToTerms(encode["scope"] == "professor" ? "teacher" : "user");
          }
          // goToTeacherSelectCollege();

        }
      } catch (e) {
        print(e);
        if (e is DioError) {
          Navigator.pop(context);
          toastTop(
              context,
              e.response.toString().contains("Incorrect")
                  ? "Usuario y/o contraseña incorrecto. Inténtalo nuevamente con datos válidos."
                  : "Ha ocurrido un error. Por favor inténtalo más tarde.",
              red);
        } else {
          Navigator.pop(context);
          toastTop(context, e.toString(), red);
        }
      }
    } else {
      toastTop(
          context,
          "No cuentas con conexión a internet. Por favor conéctate a una red estable.",
          red);
    }
  }

  Future<bool> pop() async {
    if (isValid == true) {
      setState(() {
        isValid = false;
      });
    } else {
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
        closeApp();
      } else if (count <= 1) {
        toast(context, "Vuelve atrás dos veces para salir de la aplicación.",
            red);
      }
    }
    return false;
  }

  closeApp() {
    SystemNavigator.pop();
  }

  @override
  void dispose() {
    super.dispose();
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
}
