import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class Manuals extends StatefulWidget {
  @override
  _ManualsState createState() => _ManualsState();
}

class _ManualsState extends State<Manuals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cyan,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text("MANUALES")),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "MARCO TEÓRICO DE \nPLANIFICACIÓN",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 6.0.w),
              ),
              Image.asset(
                "Assets/images/LogoCompleto.png",
                width: 20.0.w,
              )
            ],
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Container(
            height: 0.5.h,
            color: Colors.white,
            width: 90.0.w,
          ),
          SizedBox(
            height: 3.0.h,
          ),
          button(
              MainAxisAlignment.start,
              Text(
                "  MANUAL CLASES",
                style: TextStyle(color: Colors.white, fontSize: 7.0.w),
              ),
              Container(
                child: Center(
                    child: Image.asset(
                  "Assets/images/docImage.png",
                  color: Colors.white,
                  width: 18.0.w,
                )),
                width: 50.0.w,
                height: 15.0.h,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(80),
                        bottomRight: Radius.circular(80))),
              )),
          SizedBox(
            height: 1.0.h,
          ),
          button2(
              MainAxisAlignment.end,
              Text(
                "  MANUAL EJERCICIOS",
                style: TextStyle(color: Colors.white, fontSize: 7.0.w),
              ),
              Container(
                child: Center(
                    child: Image.asset(
                  "Assets/images/docImage.png",
                  color: red,
                  width: 18.0.w,
                )),
                width: 50.0.w,
                height: 15.0.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(80),
                        topLeft: Radius.circular(80))),
              ))
        ],
      ),
    );
  }

  Widget button(MainAxisAlignment alignment, Text title, Widget child) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: alignment,
          children: [title],
        ),
        Text(""),
        Row(
          mainAxisAlignment: alignment,
          children: [child],
        )
      ],
    );
  }

  Widget button2(MainAxisAlignment alignment, Text title, Widget child) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: alignment,
          children: [child],
        ),
        Text(""),
        Row(
          mainAxisAlignment: alignment,
          children: [title],
        ),
      ],
    );
  }
}
