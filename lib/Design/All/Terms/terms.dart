import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    final dynamic role =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: 5.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/images/logo.png",
                width: 20.0.w,
              )
            ],
          ),
          Text(
            "Términos y acuerdos de privacidad",
            style: TextStyle(fontSize: 5.0.w),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              child: Column(
                children: [
                  Text(
                    """    Lea atentamente estas condiciones generales de acceso y utilización. Definen las condiciones y restricciones de utilización que usted acepta cuando descarga, acceda  y utiliza la Aplicación MOVITRONIA y los  servicios, incluyendo las limitaciones de  garantía y responsabilidad.  
   Usted reconoce que estas condiciones  generales son efectivas del mismo modo  que cualquier otro contrato escrito y que se  compromete a respectarlos. En su defecto,  no está autorizado a descargar y utilizar la  Aplicación móvil MOVITRONIA.  
   Las condiciones generales se pueden  consultar en cualquier momento en la  Aplicación MOVITRONIA y en la página web  movitronia.com  La Aplicación MOVITRONIA y los servicios  asociados con la misma están por ofrecidos  por la sociedad GRUPO TRONIA SPA, con  domicilio en Santa Maria del Boldo, la  sequia 02081, Curico,CHILE, Para  contactar con nosotros, puede enviar un  email contacto@movitronia.com ¡Bienvenido a MOVITRONIA Con la ayuda 
""",
                    style: TextStyle(
                        color: Colors.black, fontFamily: "", fontSize: 4.5.w),
                    textAlign: TextAlign.justify,
                  )
                ],
              ),
            ),
            width: 90.0.w,
            height: 60.0.h,
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                buttonColor: cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                minWidth: 90.0.w,
                height: 5.0.h,
                child: RaisedButton(
                  onPressed: () {
                    goToBasal(role);
                    // Get.to(WelcomePage(
                    //   role: widget.role,
                    // ));
                  },
                  child: Text(
                    "Acepto",
                    style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 1.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonTheme(
                buttonColor: cyan,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                minWidth: 90.0.w,
                height: 5.0.h,
                child: RaisedButton(
                  onPressed: () {
                    rechazo();
                  },
                  child: Text(
                    "Rechazo",
                    style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  rechazo() {
    return Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                  backgroundColor: Colors.white,
                  appBar: null,
                  body: Column(
                    children: [
                      SizedBox(
                        height: 30.0.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 85.0.w,
                            child: Text(
                              "DEBES ACEPTAR LOS TÉRMINOS Y CONDICIONES PARA CONTINUAR EN MOVITRONIA.",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 5.5.w),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.0.h,
                      ),
                      Container(
                        width: 90.0.w,
                        height: 5.0.h,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: green,
                          textColor: Colors.white,
                          child: Text("Continuar en Movitronia".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 5.0.w, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 3.0.h,
                      ),
                      Container(
                        width: 90.0.w,
                        height: 5.0.h,
                        child: RaisedButton(
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          onPressed: () {},
                          color: green,
                          textColor: Colors.white,
                          child: Text("Salir de Movitronia".toUpperCase(),
                              style: TextStyle(
                                  fontSize: 5.0.w, color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0.h,
                      ),
                      Image.asset(
                        "Assets/images/logo.png",
                        width: 20.0.w,
                      )
                    ],
                  ));
            }));
  }
}
