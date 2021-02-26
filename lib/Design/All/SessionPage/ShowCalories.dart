import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class ShowCalories extends StatefulWidget {
  @override
  _ShowCaloriesState createState() => _ShowCaloriesState();
}

class _ShowCaloriesState extends State<ShowCalories> {
  @override
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return WillPopScope(
      onWillPop: pop,
      child: Scaffold(
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 10.0.h,
            color: cyan,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buttonRounded(context, func: () {
                  log(args.toString());
                  // goToEvidencesSession(
                  //     questionnaire: args["questionnaire"],
                  //     mets: args["mets"],
                  //     number: args["number"],
                  //     idClass: args["idClass"]);
                }, text: "   CONTINUAR")
              ],
            ),
          ),
          appBar: AppBar(
            // leading: IconButton(
            //   icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
            //   onPressed: () => Navigator.pop(context),
            // ),
            title: Column(
              children: [
                SizedBox(
                  height: 2.0.h,
                ),
                FittedBox(fit: BoxFit.fitWidth, child: Text("FIN SESIÓN")),
              ],
            ),
            centerTitle: true,
            backgroundColor: cyan,
            elevation: 0,
          ),
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.asset(
                  "Assets/images/wall3.jpg",
                  width: MediaQuery.of(context).size.width * 0.4,
                  fit: BoxFit.fill,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.0.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        """Felicidades
has quemado 199 KCal""",
                        style: TextStyle(
                          fontSize: 7.0.w,
                          color: blue,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )),
    );
  }

  Future<bool> pop() async {
    print("back");
    return false;
  }
}
