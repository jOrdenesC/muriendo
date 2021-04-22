import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class Support extends StatefulWidget {
  final bool isFull;
  Support({this.isFull});
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  String urlWhatsapp = "https://wa.link/svmpc6";

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isFull
          ? AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              title: Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: 2.0.h,
                      ),
                      FittedBox(fit: BoxFit.fitWidth, child: Text("SOPORTE")),
                    ],
                  ),
                ],
              ),
              backgroundColor: cyan,
              centerTitle: true,
              elevation: 0,
            )
          : null,
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          // button("CLAVE INTRANET", "342452"),
          SizedBox(
            height: 6.0.h,
          ),
          InkWell(
              onTap: () {
                _launchURL("tel:+56 442021189");
              },
              child: button("FONO SOPORTE", "+56 442021189")),
          SizedBox(
            height: 3.0.h,
          ),
          InkWell(
              onTap: () {
                _launchURL("mailto:contacto@movitronia.com");
              },
              child: button("CORREO ELECTRÓNICO", " CONTACTO@MOVITRONIA.COM ")),
          SizedBox(
            height: 3.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "MENSAJE POR WHATSAPP",
                style: TextStyle(color: Colors.white, fontSize: 6.0.w),
              ),
            ],
          ),
          Text(""),
          FlatButton.icon(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              height: 7.0.h,
              minWidth: 80.0.w,
              color: Colors.white,
              onPressed: () {
                _launchURL(urlWhatsapp);
              },
              icon: Image.asset(
                "Assets/images/logoWhats.png",
                width: 10.0.w,
              ),
              label: Text(
                "Enviar mensaje".toUpperCase(),
                style: TextStyle(color: blue, fontSize: 6.0.w),
              )),
          SizedBox(
            height: 7.0.h,
          ),
          Text(
            "Versión $versionApp",
            style: TextStyle(color: Colors.white, fontSize: 5.0.w),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Image.asset(
          //       "Assets/images/LogoCompleto.png",
          //       width: 20.0.w,
          //     )
          //   ],
          // )
        ],
      ),
    );
  }

  Widget button(String text, String data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: Colors.white, fontSize: 6.0.w)),
          ],
        ),
        Text(""),
        Container(
          width: 80.0.w,
          height: 7.0.h,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Center(
              child: FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Text(data,
                      style: TextStyle(color: blue, fontSize: 6.0.w)))),
        )
      ],
    );
  }
}
