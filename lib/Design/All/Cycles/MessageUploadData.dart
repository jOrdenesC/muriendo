import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class MessageUploadData extends StatefulWidget {
  @override
  _MessageUploadDataState createState() => _MessageUploadDataState();
}

class _MessageUploadDataState extends State<MessageUploadData> {
  @override
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
              goToHomeTeacher();
            }, text: "   FINALIZAR")
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 12.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        backgroundColor: cyan,
        centerTitle: true,
        title: Text(""),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10.0.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "Assets/images/LogoCompleto.png",
                width: 25.0.w,
              ),
              SizedBox(
                width: 10.0.w,
              )
            ],
          ),
          SizedBox(
            height: 20.0.h,
          ),
          Text(
            "¡Se han subido los datos!",
            style: TextStyle(color: Colors.white, fontSize: 7.0.w),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
