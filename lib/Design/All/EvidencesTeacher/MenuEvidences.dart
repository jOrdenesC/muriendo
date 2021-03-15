import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class MenuEvidences extends StatefulWidget {
  final List data;
  MenuEvidences({this.data});
  @override
  _MenuEvidencesState createState() => _MenuEvidencesState();
}

class _MenuEvidencesState extends State<MenuEvidences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cyan,
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
            FittedBox(fit: BoxFit.fitWidth, child: Text("EVIDENCIAS")),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20.0.h,
          ),
          InkWell(
            onTap: () {
              // goToShowPhases(2, "GASTO CALÓRICO", true, false, null);
              goToCaloricExpenditure(true, widget.data);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80.0.w,
                  height: 8.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 7.0.w,
                        child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6.5.w,
                            child: Icon(
                              Icons.bar_chart,
                              color: blue,
                              size: 10.0.w,
                            )),
                      ),
                      Center(
                          child: Text(
                        "  GASTO CALÓRICO",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          InkWell(
            onTap: () {
              // goToReports(true, true, widget.data);
               goToApplicationUse(true, widget.data);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  width: 80.0.w,
                  height: 8.0.h,
                  decoration: BoxDecoration(
                      color: red,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                          topLeft: Radius.circular(50))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 7.0.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 6.5.w,
                          child: Image.asset(
                            "Assets/images/reportIcon.png",
                            color: blue,
                            width: 6.0.w,
                          ),
                        ),
                      ),
                      Center(
                          child: Text(
                        "  USO DE APP",
                        style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "PUEDES VISUALIZAR LAS EVIDENCIAS INGRESANDO A LA INTRANET DESDE TU NAVEGADOR, YA SEA DESDE UN COMPUTADOR O TU DISPOSITIVO MÓVIL.",
              style: TextStyle(color: Colors.white, fontSize: 5.0.w),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 3.0.h,
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     buttonRounded(context,
          //         text: "TU CLAVE: 342452",
          //         icon: Icon(
          //           Icons.lock_open_rounded,
          //           color: Colors.white,
          //           size: 10.0.w,
          //         ),
          //         circleColor: blue,
          //         circleRadius: 7.0.w,
          //         backgroudColor: Colors.white,
          //         width: 90.0.w,
          //         height: 8.0.h,
          //         textStyle: TextStyle(color: blue, fontSize: 6.0.w))
          //   ],
          // ),
        ],
      ),
    );
  }
}
