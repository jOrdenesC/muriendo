import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class FinishCreateClass extends StatefulWidget {
  @override
  _FinishCreateClassState createState() => _FinishCreateClassState();
}

class _FinishCreateClassState extends State<FinishCreateClass> {
  @override
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
              goToAssignCreatedClass();
            }, text: "   SUBE AQUÍ")
          ],
        ),
      ),
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 9.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
        title: Column(
          children: [
            SizedBox(
                height: 2.0.h,
              ),
            FittedBox(fit: BoxFit.fitWidth, child: Text("FIN SESIÓN")),
          ],
        ),
        backgroundColor: cyan,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Image.asset("Assets/images/wall4.png")],
          ),
          Column(
            children: [
              SizedBox(
                height: 20.0.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "¡FELICITACIONES!",
                    style: TextStyle(color: blue, fontSize: 10.0.w),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: green,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    width: 70.0.w,
                    height: 5.0.h,
                    child: Center(
                      child: Text(
                        "Has finalizado tu clase",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
