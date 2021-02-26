import 'package:flutter/material.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:sizer/sizer.dart';

class Cycles extends StatefulWidget {
  @override
  _CyclesState createState() => _CyclesState();
}

class _CyclesState extends State<Cycles> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return body();
  }

  Widget body() {
    return Stack(
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                SizedBox(
                  width: 5.0.w,
                ),
                Image.asset(
                  "Assets/images/LogoCompleto.png",
                  width: 18.0.w,
                )
              ],
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(
                      height: 7.0.h,
                    ),
                    divider(green, "PRIMER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(""),
                        element(green, 1, "RO", true, "primero básico", 1),
                        element(green, 2, "DO", false, "segundo básico", 1),
                        element(green, 3, "RO", false, "tercero básico", 1),
                        element(green, 4, "TO", false, "cuarto básico", 1),
                        Text("")
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(red, "SEGUNDO CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(red, 5, "TO", true, "quinto básico", 2),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(red, 6, "TO", true, "sexto básico", 2),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    divider(yellow, "TERCER CICLO"),
                    SizedBox(
                      height: 3.0.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        element(yellow, 7, "TO", true, "séptimo básico", 3),
                        SizedBox(
                          width: 5.0.w,
                        ),
                        element(yellow, 8, "VO", true, "octavo básico", 3),
                        SizedBox(
                          width: 10.0.w,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.0.h,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget element(Color color, int course, String fin, bool check,
      String nameCycle, int cycle) {
    return InkWell(
      onTap: () {
        goToshowCycle(nameCycle, cycle);
      },
      child: Container(
        width: 16.0.w,
        child: Stack(
          children: [
            CircleAvatar(
              radius: 8.0.w,
              backgroundColor: color,
              child: CircleAvatar(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("$course",
                            style: TextStyle(color: blue, fontSize: 9.0.w)),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 1.0.h,
                        ),
                        Text(
                          "$fin",
                          style: TextStyle(
                            color: blue,
                            fontSize: 3.0.w,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                radius: 6.5.w,
                backgroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider(Color color, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 65.0.w,
          height: 8.0.h,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3),
              color: color,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 7.0.w,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 6.5.w,
                    child: Image.asset(
                      "Assets/images/sessionIcon.png",
                      fit: BoxFit.contain,
                      width: 10.0.w,
                      color: color,
                    )),
              ),
              Center(
                  child: Text(
                "$text ",
                style: TextStyle(color: Colors.white, fontSize: 5.0.w),
              )),
            ],
          ),
        )
      ],
    );
  }
}
