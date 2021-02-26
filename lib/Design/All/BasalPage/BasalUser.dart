import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:sizer/sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_rut_validator/dart_rut_validator.dart';

class BasalUser extends StatefulWidget {
  @override
  _BasalUserState createState() => _BasalUserState();
}

class _BasalUserState extends State<BasalUser> {
  DateTime birthday;
  String gender;
  TextEditingController rut = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  String frequentlyActivity;
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  final f = new DateFormat('yyyy-MM-dd');

  getInitDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      rut.text = RUTValidator.formatFromText(prefs.getString("rut")) ?? "";
      name.text = prefs.getString("name") ?? "";
      mail.text = prefs.getString("email") ?? "";
    });
  }

  @override
  void initState() {
    super.initState();
    getInitDataUser();
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
              validate();
              // goToBasal(widget.role);
              //Get.to(Terms(role: widget.role));
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
                                readOnly: true,
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
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu nombre')),
                            name: "Nombre"),
                        item(
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              underline: SizedBox.shrink(),
                              hint: gender == null
                                  ? Text(
                                      "Selecciona tu sexo",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      gender,
                                      style: TextStyle(color: Colors.white),
                                    ),
                              items: <String>['Femenino', 'Masculino']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  gender = val;
                                  print(gender);
                                });
                              },
                            ),
                            name: "Sexo"),
                        item(
                            child: InkWell(
                              onTap: () {
                                datePicker();
                              },
                              child: Container(
                                child: Row(
                                  children: [
                                    birthday != null
                                        ? Text(
                                            f
                                                .format(birthday)
                                                .toString()
                                                .substring(0, 10),
                                            style:
                                                TextStyle(color: Colors.white))
                                        : Text(
                                            "Selecciona tu fecha de nacimiento",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ],
                                ),
                                width: 80.0.w,
                                height: 6.5.h,
                              ),
                            ),
                            name: "Fecha de nacimiento"),
                        item(
                            child: TextField(
                                maxLength: 3,
                                style: TextStyle(color: Colors.white),
                                controller: height,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu estatura (cm)')),
                            name: "Estatura"),
                        item(
                            child: TextField(
                                maxLength: 2,
                                style: TextStyle(color: Colors.white),
                                controller: weight,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    counterText: "",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu peso')),
                            name: "Peso"),
                        item(
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.white,
                              underline: SizedBox.shrink(),
                              hint: frequentlyActivity == null
                                  ? Text(
                                      "Frecuencia de actividad física",
                                      style: TextStyle(color: Colors.white),
                                    )
                                  : Text(
                                      frequentlyActivity,
                                      style: TextStyle(color: Colors.white),
                                    ),
                              items: <String>[
                                'Baja (0 - 1 vez por semana)',
                                'Media (2 - 3 vez por semana)',
                                'Alta (4 - 5 vez por semana)'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  frequentlyActivity = val;
                                });
                              },
                            ),
                            name: "Frec. actividad física"),
                        item(
                            child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: phone,
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu número de teléfono')),
                            name: "Teléfono móvil"),
                        item(
                            child: TextField(
                                readOnly: true,
                                style: TextStyle(color: Colors.white),
                                controller: mail,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(color: Colors.white),
                                    hintText: 'Ingresa tu correo')),
                            name: "Correo electrónico"),
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

  datePicker() async {
    final DateTime picked = await showDatePicker(
      cancelText: "CANCELAR",
      helpText: "SELECCIONA TU FECHA DE NACIMIENTO",
      fieldHintText: "SELECCIONA TU FECHA DE NACIMIENTO",
      confirmText: "ACEPTAR",
      // locale: Locale("es"),
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != birthday)
      setState(() {
        birthday = picked;
      });
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
    } else if (height.text.isEmpty) {
      toast(context, "No puedes dejar tu altura vacía.", red);
    } else if (birthday.toString().isEmpty) {
      toast(context, "Debes indicar tu fecha de nacimiento.", red);
    } else if (mail.text.isEmpty) {
      toast(context, "No puedes dejar el correo vacío.", red);
    } else if (weight.text.isEmpty) {
      toast(context, "No puedes dejar tu peso vacío.", red);
    } else if (frequentlyActivity.isEmpty) {
      toast(context, "Debes indicar tu actividad física.", red);
    } else if (gender.isEmpty) {
      toast(context, "Debes indicar tu sexo.", red);
    } else if (int.parse(height.text) >= 300) {
      toast(context, "El peso indicado debe ser menor a 300 kg.", red);
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
        var response = await dio
            .post("$urlServer/api/mobile/uploadUserData?token=$token", data: {
          "name": name.text,
          "birthday": f.format(birthday).toString().substring(0, 10),
          "height": height.text.replaceAll(".", "").replaceAll("-", ""),
          "weight": weight.text.replaceAll(".", "").replaceAll("-", ""),
          "gender": gender == "Masculino" ? "male" : "female",
          "frequencyOfPhysicalActivity": frequentlyActivity.contains("Baja")
              ? "low"
              : frequentlyActivity.contains("Media")
                  ? "mid"
                  : "high",
          "phone": phone.text
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
          prefs.setString("email", encode["email"].toString());
          prefs.setString("name", encode["name"].toString());
          prefs.setString("scope", encode["scope"].toString());
          prefs.setString("charge", encode["charge"].toString());
          prefs.setBool("termsAccepted", encode["termsAccepted"]);

          //Datos enviados que se guardarán en el dispositivo
          prefs.setString("gender", encode["charge"].toString());
          prefs.setString(
            "birthday",
            f.format(birthday).toString().substring(0, 10),
          );
          prefs.setString(
              "weight", weight.text.replaceAll(".", "").replaceAll("-", ""));
          prefs.setString(
              "height", height.text.replaceAll(".", "").replaceAll("-", ""));
          prefs.setString(
              "frequencyOfPhysicalActivity",
              frequentlyActivity.contains("Baja")
                  ? "low"
                  : frequentlyActivity.contains("Media")
                      ? "mid"
                      : "high");
          if (phone.text.isNotEmpty) {
            prefs.setString("phone", phone.text);
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
