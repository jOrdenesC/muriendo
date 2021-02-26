import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';
import './../../../Utils/UrlServer.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Utils/ConnectionState.dart';

class RecoverPass extends StatefulWidget {
  @override
  _RecoverPassState createState() => _RecoverPassState();
}

class _RecoverPassState extends State<RecoverPass> {
  bool loadingg = false;
  bool appeared = false;
  TextEditingController mail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("Assets/images/LogoCompleto.png", width: 30.0.w),
              ],
            ),
            SizedBox(
              height: 5.0.h,
            ),
            Container(
              width: 80.0.w,
              // height: .0.h,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: TextFormField(
                controller: mail,
                textAlign: TextAlign.center,
                style: TextStyle(color: blue, fontSize: 20),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: InkWell(
                      onTap: () {
                        sendMailRecuperation();
                      },
                      child: CircleAvatar(
                        radius: 7.0.w,
                        backgroundColor: blue,
                        child: Center(
                          child: Icon(
                            Icons.arrow_forward_ios,
                            size: 7.0.w,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  border: InputBorder.none,
                  counterText: "",
                  labelStyle: TextStyle(color: blue),
                  hintText: "CORREO",
                  hintStyle: TextStyle(color: blue, fontSize: 7.0.w),
                ),
              ),
            )
          ],
        ),
        loadingg
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedContainer(
                        curve: Curves.easeIn,
                        duration: Duration(seconds: 1),
                        decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        width: appeared ? 40.0.w : 10.0.w,
                        height: appeared ? 40.0.w : 10.0.w,
                        child: Center(
                          child: Image.asset(
                            "Assets/videos/loading.gif",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
            : SizedBox.shrink()
      ],
    ));
  }

  sendMailRecuperation() async {
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
          ));
      try {
        var dio = Dio();
        var response = await dio.post("$urlServer/restore-password",
            data: {"email": mail.text.trim(), "entity": "mobile"});
        if (response.statusCode == 200) {
          toastTop(context, "Se ha enviado un correo a la dirección indicada.",
              green);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (response.statusCode == 404) {
          toastTop(context,
              "El correo indicado no está registrado en nuestro sistema.", red);
          Navigator.pop(context);
        }
      } catch (e) {
        print({"email": mail.text.trim(), "entity": "mobile"});
        print(e);
        toastTop(context, "Ha ocurrido un error, por favor inténtalo más tarde",
            red);
        Navigator.pop(context);
      }
    } else {
      toastTop(
          context,
          "Necesitas estar conectado a internet para recuperar tu contraseña.",
          red);
    }
  }

  validation() {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(mail.text);
    if (mail.text.isEmpty) {
      toastTop(context, "Indica una dirección de correo electrónico", red);
    } else if (emailValid == false) {
      toastTop(context, "Indica un correo válido.", red);
    } else {
      sendMailRecuperation();
    }
  }
}
