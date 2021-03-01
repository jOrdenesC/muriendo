import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';

class ShowPhases extends StatefulWidget {
  @override
  _ShowPhasesState createState() => _ShowPhasesState();
}

class _ShowPhasesState extends State<ShowPhases> {
  double currentindex = 0;
  String title;
  dynamic arguments;
  List phases = [
    {"number": 1},
    {"number": 2},
    {"number": 3},
    {"number": 4},
    {"number": 5},
    {"number": 6},
    {"number": 7},
    {"number": 8},
    {"number": 9},
    {"number": 10}
  ];
  @override
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    setState(() {
      title = args["title"];
      arguments = args;
    });
    return Scaffold(
        backgroundColor: args["cycle"] == 1
            ? green
            : args["cycle"] == 2
                ? red
                : yellow,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 9.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: cyan,
          title: Column(
            children: [
              SizedBox(
                height: 2.0.h,
              ),
              FittedBox(fit: BoxFit.fitWidth, child:Text(args["title"])),
            ],
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5.0.h,
            ),
            arguments["isEvidence"]
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "NOMBRE APELLIDO _8° A",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 5.5.w),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "COLEGIO SANTO TOMAS, CURICO",
                              style:
                                  TextStyle(color: blue, fontSize: 5.5.w),
                            )
                          ],
                        ),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 3.0.h,
            ),
            Container(
              height: 60.0.h,
              child: PageView.builder(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                itemBuilder: (context, index) {
                  return phase(phases[index]["number"]);
                },
                itemCount: phases.length,
                onPageChanged: (index) {
                  setState(() {
                    currentindex = (index).toDouble();
                  });
                },
              ),
            ),
            DotsIndicator(
              dotsCount: phases.length,
              position: currentindex,
              decorator: DotsDecorator(
                  color: Colors.white,
                  activeColor: blue,
                  size: Size(15, 15),
                  activeSize: Size(20, 20)),
            )
          ],
        ));
  }

  Widget phase(int index) {
    return Column(
      children: [
        buttonRounded(context,
            width: 90.0.w,
            text: "FASE",
            textStyle: TextStyle(fontSize: 8.0.w, color: Colors.white),
            height: 9.0.h,
            circleRadius: 8.0.w,
            icon: Center(
                child: Text(
              "$index",
              style: TextStyle(color: blue, fontSize: 8.0.w),
            ))),
        SizedBox(height: 3.0.h),
        buttonRounded(context,
            backgroudColor: Colors.white,
            circleColor: blue,
            width: 90.0.w,
            text: "CLASE 1",
            textStyle: TextStyle(fontSize: 8.0.w, color: blue),
            height: 9.0.h,
            circleRadius: 8.0.w,
            icon: Center(
                child: Icon(
              Icons.check,
              color: arguments["cycle"] == 1
                  ? green
                  : arguments["cycle"] == 2
                      ? red
                      : yellow,
              size: 15.0.w,
            ))),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () {
            if (index == 2) {
              goToCreateClass();
            } else {
              print("Nothing");
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
              width: 90.0.w,
              text: "CLASE 2",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: 8.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 15.0.w,
              ))),
        ),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () {
            if (index == 2) {
              goToCreateClass();
            } else {
              print("Nothing");
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
              width: 90.0.w,
              text: "CLASE 3",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: 8.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 15.0.w,
              ))),
        ),
        SizedBox(height: 3.0.h),
        InkWell(
          onTap: () {
            if (index == 2) {
              goToCreateClass();
            } else {
              print("Nothing");
            }
          },
          child: buttonRounded(context,
              backgroudColor: Colors.white,
              circleColor: title == "POR DEFECTO"
                  ? blue
                  : index == 2
                      ? arguments["cycle"] == 1
                          ? green
                          : arguments["cycle"] == 2
                              ? red
                              : yellow
                      : blue,
              width: 90.0.w,
              text: "CLASE 4",
              textStyle: TextStyle(fontSize: 8.0.w, color: blue),
              height: 9.0.h,
              circleRadius: 8.0.w,
              icon: Center(
                  child: Icon(
                Icons.check,
                color: arguments["cycle"] == 1
                    ? green
                    : arguments["cycle"] == 2
                        ? red
                        : yellow,
                size: 15.0.w,
              ))),
        ),
        SizedBox(height: 3.0.h),
      ],
    );
  }
}
