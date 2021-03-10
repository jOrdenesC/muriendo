import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class Support extends StatefulWidget {
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          // button("CLAVE INTRANET", "342452"),
          SizedBox(
            height: 6.0.h,
          ),
          button("FONO SOPORTE", "+56 9 2341 3425"),
          SizedBox(
            height: 3.0.h,
          ),
          button("CORREO ELECTRÓNICO", "CONTACTO@MOVITRONIA.COM"),
          SizedBox(
            height: 7.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "Assets/images/LogoCompleto.png",
                width: 20.0.w,
              )
            ],
          )
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
              child: Text(
            data,
            style: TextStyle(color: blue, fontSize: 5.0.w)
          )),
        )
      ],
    );
  }
}
