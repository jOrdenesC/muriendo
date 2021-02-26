import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movitronia/Utils/Colors.dart';

Widget svgIcon2(Color color) {
  return SvgPicture.asset(
    "Assets/images/figure3.svg",
    color: color,
    width: 150,
  );
}

dialog(
  double height, {
  BuildContext context,
  String text,
  String desc,
  List<Widget> buttons,
}) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0)), //this right here
          child: Container(
              decoration: BoxDecoration(
                  color: blue,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              height: height * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.05,
                  ),
                  FadeIn(
                      duration: Duration(milliseconds: 200),
                      child: Stack(
                        children: [
                          Center(child: svgIcon2(green)),
                          Column(
                            children: [
                              SizedBox(
                                height: height * 0.056,
                              ),
                              Center(
                                  child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: height * 0.09,
                              )),
                            ],
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      text,
                      style: TextStyle(
                          color: Colors.white, fontSize: height * 0.04),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    desc,
                    style:
                        TextStyle(color: Colors.white, fontSize: height * 0.03),
                    textAlign: TextAlign.center,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: buttons,
                  ),
                ],
              )),
        );
      });
}
