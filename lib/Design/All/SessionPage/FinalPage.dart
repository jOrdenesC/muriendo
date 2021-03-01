import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class FinalPage extends StatefulWidget {
  @override
  _FinalPageState createState() => _FinalPageState();
}

class _FinalPageState extends State<FinalPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  // GravitySimulation simulation;

  @override
  void initState() {
    super.initState();

    // simulation = GravitySimulation(
    //   200.0, // acceleration
    //   0.0, // starting point
    //   100.0.h, // end point
    //   1.0, // starting velocity
    // );

    // controller = AnimationController(vsync: this, upperBound: 70.0.h)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    // controller.animateWith(simulation);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToHomeReplacement();
              // Get.to(HomePage(
              //   role: "user",
              // ));
            }, text: "   FINALIZAR")
          ],
        ),
      ),
      backgroundColor: blue,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(""),
        backgroundColor: cyan,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                height: 13.0.h,
              ),
              Container(
                child: Image.asset(
                  "Assets/images/buttons.png",
                  width: 100.0.w,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          Column(
            children: [
              SizedBox(
                height: 4.0.h,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10.0.w,
                  ),
                  Image.asset(
                    "Assets/images/LogoCompleto.png",
                    width: 27.0.w,
                  )
                ],
              ),
              SizedBox(
                height: 5.0.h,
              ),
              Text(
                "¡Se han subido los datos!\n ¡FELICIDADES!",
                style: TextStyle(color: Colors.white, fontSize: 10.0.w),
                textAlign: TextAlign.center,
              )
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
