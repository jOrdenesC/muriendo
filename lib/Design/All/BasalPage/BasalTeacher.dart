import 'dart:convert';
import '../../Widgets/Loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BasalTeacher extends StatefulWidget {
  @override
  _BasalTeacherState createState() => _BasalTeacherState();
}

class _BasalTeacherState extends State<BasalTeacher> {
  TextEditingController rut = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController comune = TextEditingController();

  getInitDataTeacher() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      rut.text = prefs.getString("rut") ?? "";
      name.text = prefs.getString("name") ?? "";
      mail.text = prefs.getString("email") ?? "";
    });
  }

  @override
  void initState() {
    getInitDataTeacher();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              // goToWelcome(role);
              validate();
            }, text: "   ENVIAR")
          ],
        ),
      ),
      backgroundColor: blue,
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            child: Column(
              children: [
                SizedBox(
                  height: 5.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      width: 80.0.w,
                      child: Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Datos personales",
                          style: TextStyle(color: blue, fontSize: 6.0.w),
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5.0.h,
                ),
                Container(
                  height: 70.0.h,
                  child: SingleChildScrollView(
                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        item(
                            child: TextField(
                                enabled: false,
                                controller: rut,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu rut')),
                            name: "Rut"),
                        item(
                            child: TextField(
                                controller: name,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu nombre')),
                            name: "Nombre"),
                        // item(
                        //     child: TextField(
                        //         controller: college,
                        //         keyboardType: TextInputType.text,
                        //         style: TextStyle(color: Colors.white),
                        //         decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintStyle: TextStyle(color: Colors.white),
                        //             hintText: 'Ingresa tu colegio')),
                        //     name: "Colegio"),
                        item(
                            child: TextField(
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu número de teléfono')),
                            name: "Teléfono móvil"),
                        item(
                            child: TextField(
                                controller: mail,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu correo')),
                            name: "Correo electrónico"),
                        // item(
                        //     child: TextField(
                        //         controller: comune,
                        //         keyboardType: TextInputType.text,
                        //         style: TextStyle(color: Colors.white),
                        //         decoration: InputDecoration(
                        //             border: InputBorder.none,
                        //             hintStyle: TextStyle(color: Colors.white),
                        //             hintText: 'Ingresa tu comuna')),
                        //     name: "Comuna"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget item({Widget child, String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$name",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 3.0.h),
        ),
        Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                color: Colors.transparent,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            width: 80.0.w,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: child,
            )),
        SizedBox(
          height: 2.0.h,
        )
      ],
    );
  }

  validate() {
    if (rut.text.isEmpty) {
      toast(context, "No puedes dejar el rut vacío.", red);
    } else if (name.text.isEmpty) {
      toast(context, "No puedes dejar el nombre vacío.", red);
    } else if (mail.text.isEmpty) {
      toast(context, "No puedes dejar el correo vacío.", red);
    } else {
      finishData();
    }
  }

  finishData() async {
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
            "Enviando información...",
            textAlign: TextAlign.center,
          ));
      var prefs = await SharedPreferences.getInstance();
      var token = prefs.getString("token");
      try {
        var dio = Dio();
        var response = await dio.post(
            "$urlServer/api/mobile/uploadProfessorData?token=$token",
            data: {
              "name": name.text,
              "phone": phone.text.isEmpty ? "" : phone.text,
            });
        if (response.statusCode == 200) {
          toast(context, "Se han enviado los datos ingresados.", green);
          prefs.setString("token", response.data);
          var token = prefs.getString("token");
          final parts = token.split('.');
          final payload = parts[1];
          var decoded = B64urlEncRfc7515.decodeUtf8(payload);
          var encode = jsonDecode(decoded);
          print(decoded);
          //Datos del token traído actualizados
          prefs.setString("rut", encode["rut"].toString());
          //Datos enviados que se guardarán en el dispositivo
          prefs.setString("name", name.text);

          if (phone.text.isNotEmpty) {
            prefs.setString("phone", phone.text);
          } else {
            prefs.setString("phone", "Sin número de teléfono");
          }
          goToWelcome(encode["scope"] == "professor" ? "teacher" : "user");
        } else {
          toast(context, "Por favor inténtalo nuevamente.", red);
        }
      } catch (e) {
        print(e.response);
      }
    } else {
      toastTop(
          context,
          "No cuentas con conexión a internet. Por favor conéctate a una red estable.",
          red);
    }
  }
}
