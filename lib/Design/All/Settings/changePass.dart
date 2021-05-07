import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Functions/createError.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/ConnectionState.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class ChangePass extends StatefulWidget {
  @override
  _ChangePassState createState() => _ChangePassState();
}

class _ChangePassState extends State<ChangePass> {
  TextEditingController myPass = TextEditingController();
  TextEditingController pass1 = TextEditingController();
  TextEditingController pass2 = TextEditingController();
  bool showPass = false;
  bool activateBottom = false;
  var dio = Dio();

  @override
  void initState() {
    super.initState();
    show();
  }

  void show() async {
    Future.delayed(Duration.zero, () => {showFormPass(context)});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: activateBottom
            ? Container(
                width: 100.0.w,
                height: 10.0.h,
                color: cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonRounded(context, func: () {
                      validate();
                    },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: blue,
                          size: 4.0.h,
                        ),
                        text: "  CONTINUAR")
                  ],
                ),
              )
            : SizedBox.shrink(),
        appBar: AppBar(
          backgroundColor: cyan,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(
                  fit: BoxFit.fitWidth, child: Text("CAMBIAR CONTRASEÑA")),
            ],
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                item(
                    color: Colors.white,
                    name: "Nueva contraseña",
                    child: TextFormField(
                      onChanged: (value) {
                        if (pass1.text.isNotEmpty && pass2.text.isNotEmpty) {
                          setState(() {
                            activateBottom = true;
                          });
                        } else {
                          setState(() {
                            activateBottom = false;
                          });
                        }
                      },
                      // initialValue: height.text + " cm.",
                      enabled: true,
                      obscureText: showPass ? false : true,
                      decoration: InputDecoration(border: InputBorder.none),
                      controller: pass1,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: blue, fontSize: 5.5.w),
                    )),
              ],
            ),
            item(
                color: Colors.white,
                name: "Repite la contraseña",
                child: TextFormField(
                  onChanged: (value) {
                    if (pass1.text.isNotEmpty && pass2.text.isNotEmpty) {
                      setState(() {
                        activateBottom = true;
                      });
                    } else {
                      setState(() {
                        activateBottom = false;
                      });
                    }
                  },
                  // initialValue: height.text + " cm.",
                  enabled: true,
                  obscureText: showPass ? false : true,
                  decoration: InputDecoration(border: InputBorder.none),
                  controller: pass2,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: blue, fontSize: 5.5.w),
                )),
            SizedBox(
              height: 3.0.h,
            ),
            Container(
              width: 80.0.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Mostrar contraseñas",
                    style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                  ),
                  Theme(
                    data: Theme.of(context).copyWith(
                      unselectedWidgetColor: Colors.white,
                    ),
                    child: Checkbox(
                      checkColor: blue,
                      activeColor: Colors.white,
                      value: showPass,
                      onChanged: (bool value) {
                        setState(() {
                          showPass = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  comparePass() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
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
            "Obteniendo información...",
            textAlign: TextAlign.center,
          ));
      try {
        Response response = await dio.post(
            "$urlServer/api/mobile/userVerifyPassword?token=$token",
            data: {"password": myPass.text});
        if (response.data == true) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          print(response.data);
          toast(
              context,
              "La contraseña que has ingresado es incorrecta. Inténtalo nuevamente.",
              red);
          myPass.clear();
          Navigator.pop(context);
        }
      } catch (e) {
        print(e.toString());
        Navigator.pop(context);
        CreateError().createError(dio, e.toString(), "Change pass");
      }
    } else {
      toast(
          context,
          "Es necesario que estés conectado a internet para modificar tu contraseña. Conéctate e inténtalo nuevamente.",
          red);
    }
  }

  validateMyPass() async {
    if (myPass.text.isEmpty) {
      toast(context, "Debes ingresar una contraseña.", red);
    } else {
      comparePass();
    }
  }

  validate() async {
    if (pass1.text.isEmpty) {
      toast(context, "No puedes dejar el campo vacío.", red);
    } else if (pass2.text.isEmpty) {
      toast(context, "No puedes dejar el campo vacío.", red);
    } else if (pass1.text.length < 6) {
      toast(context, "La contraseña debe tener 6 o más carácteres.", red);
    } else if (pass2.text.length < 6) {
      toast(context, "La contraseña debe tener 6 o más carácteres.", red);
    } else if (pass1.text == pass2.text && pass1.text == myPass.text) {
      toast(
          context,
          "La contraseña es igual a la anterior. Indica una contraseña diferente.",
          red);
    } else if (pass1.text != pass2.text) {
      toast(
          context,
          "Las contraseñas indicadas no coinciden. Verifica que estén escritas correctamente.",
          red);
    } else {
      updatePass();
    }
  }

  updatePass() async {
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
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
            "Obteniendo información...",
            textAlign: TextAlign.center,
          ));
      try {
        Response response = await dio.post(
            "$urlServer/api/mobile/changeUserPassword?token=$token",
            data: {"password": pass1.text});
        if (response.statusCode == 200) {
          print(response.data);
          toast(
              context, "Se ha modificado correctamente tu contraseña.", green);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          toast(context,
              "Ha ocurrido un error indesperado. Inténtalo nuevamente.", red);
          CreateError()
              .createError(dio, response.data.toString(), "Change pass else");
          print(response.data);
          Navigator.pop(context);
          Navigator.pop(context);
        }
      } catch (e) {
        toast(context,
            "Ha ocurrido un error indesperado. Inténtalo nuevamente.", red);
        print(e.toString());
        Navigator.pop(context);
        Navigator.pop(context);
        CreateError().createError(dio, e.toString(), "Change pass");
      }
    } else {
      toast(
          context,
          "Es necesario que estés conectado a internet para modificar tu contraseña. Conéctate e inténtalo nuevamente.",
          red);
    }
  }

  showFormPass(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return WillPopScope(
            onWillPop: pop,
            child: AlertDialog(
              title: Column(
                children: [
                  Text(
                    'Para continuar debes indicar tu contraseña actual.',
                    style: TextStyle(color: blue, fontSize: 6.0.w),
                  ),
                  Text(""),
                  // Text(
                  //   "Si olvidaste tu contraseña presiona aquí para recuperarla",
                  //   style: TextStyle(color: Colors.grey, fontSize: 4.0.w),
                  // ),
                ],
              ),
              content: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: blue, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: TextField(
                  onChanged: (val) {
                    print(val);
                  },
                  obscureText: true,
                  textAlign: TextAlign.center,
                  controller: myPass,
                  style: TextStyle(color: blue, fontSize: 5.0.w),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Contraseña".toUpperCase(),
                      hintStyle: TextStyle(color: blue, fontSize: 5.0.w)),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  color: red,
                  textColor: Colors.white,
                  child: Text('CANCELAR'),
                  onPressed: () {
                    setState(() {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    });
                  },
                ),
                FlatButton(
                  color: green,
                  textColor: Colors.white,
                  child: Text('CONTINUAR'),
                  onPressed: () {
                    validateMyPass();
                  },
                ),
              ],
            ),
          );
        });
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }

  Widget item({Widget child, String name, Color color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$name",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 6.0.w),
        ),
        Container(
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            width: 80.0.w,
            height: 5.5.h,
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
}
