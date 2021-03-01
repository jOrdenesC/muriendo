import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class AddExcercises extends StatefulWidget {
  @override
  _AddExcercisesState createState() => _AddExcercisesState();
}

class _AddExcercisesState extends State<AddExcercises> {
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  bool _switchValue3 = false;
  bool _switchValue4 = false;
  bool _switchValue5 = false;

  @override
  Widget build(BuildContext context) {
    final dynamic title =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToFinishCreateClass();
            }, text: "   ENVIAR")
          ],
        ),
      ),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 9.0.w,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: cyan,
        centerTitle: true,
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(fit: BoxFit.fitWidth, child: Text(title)),
          ],
        ),
        elevation: 0,
      ),
      body: Column(
        children: [
          SizedBox(height: 3.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(50),
                      bottomRight: Radius.circular(50)),
                  border: Border.all(color: Colors.white, width: 3),
                  color: red,
                ),
                width: 95.0.w,
                height: 8.0.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "ESCOGE SÓLO 5 EJERCICIOS",
                          style:
                              TextStyle(color: Colors.white, fontSize: 5.0.w),
                        ),
                      ],
                    ),
                    CircleAvatar(
                      backgroundColor: red,
                      radius: 7.0.w,
                      child: CircleAvatar(
                        radius: 6.0.w,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Text(
                            "5",
                            style: TextStyle(color: red, fontSize: 8.0.w),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 3.0.h),
          InkWell(
            onTap: () {
              viewInfo(
                  "Assets/images/C1.gif",
                  10,
                  "Mantén la zona abdominal contraída. Mueve los brazos al ritmo de las piernas. Mantén la espalda erguida.",
                  "SKIPPING",
                  12);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "Assets/images/C1.gif",
                      fit: BoxFit.fill,
                      width: 100.0.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Container(
                  width: 55.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(
                            activeColor: red,
                            value: _switchValue1,
                            onChanged: (value) {
                              setState(() {
                                _switchValue1 = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "SKIPPING",
                            style: TextStyle(color: blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          InkWell(
            onTap: () {
              viewInfo(
                  "Assets/images/C2.gif",
                  10,
                  "Contrae el abdomen. No encojas los hombros. Amortigua los pies con suavidad al momento de la caída.",
                  "SKIPPING",
                  12);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "Assets/images/C2.gif",
                      fit: BoxFit.fill,
                      width: 100.0.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Container(
                  width: 55.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(
                            activeColor: red,
                            value: _switchValue2,
                            onChanged: (value) {
                              setState(() {
                                _switchValue2 = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "JUMPING JACKS",
                            style: TextStyle(color: blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          InkWell(
            onTap: () {
              viewInfo(
                  "Assets/images/C3.gif",
                  10,
                  "Mantén la espalda erguida. No te inclines hacia adelante. Contrae los glúteos cuando te levantes. Mantén tres puntos de apoyo del pie: el dedo gordo, el dedo pequeño y el talón. Evita llevar las rodillas hacia adentro. Mantén la zona abdominal apretada.",
                  "SENTADILLAS",
                  12);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "Assets/images/C3.gif",
                      fit: BoxFit.fill,
                      width: 100.0.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Container(
                  width: 55.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(
                            activeColor: red,
                            value: _switchValue3,
                            onChanged: (value) {
                              setState(() {
                                _switchValue3 = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "SENTADILLAS",
                            style: TextStyle(color: blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          InkWell(
            onTap: () {
              viewInfo(
                  "Assets/images/C4.gif",
                  10,
                  "Aprieta los abdominales. Mantén la espalda plana. No gires la pelvis. Alinea los hombros encima de las muñecas. Mantén cabeza y pelvis alineados con la columna.",
                  "ESCALADOR",
                  12);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "Assets/images/C4.gif",
                      fit: BoxFit.fill,
                      width: 100.0.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Container(
                  width: 55.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(
                            activeColor: red,
                            value: _switchValue4,
                            onChanged: (value) {
                              setState(() {
                                _switchValue4 = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "ESCALADOR",
                            style: TextStyle(color: blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 1.5.h,
          ),
          InkWell(
            onTap: () {
              viewInfo(
                  "Assets/images/C5.gif",
                  10,
                  "Levanta tu rodilla sobre la cintura y haz un aplauso por debajo de esta. Mantén la parte inferior de la espalda recta. Lleva el ritmo.",
                  "ATRAPA MOSCAS",
                  12);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 35.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Center(
                    child: Image.asset(
                      "Assets/images/C5.gif",
                      fit: BoxFit.fill,
                      width: 100.0.w,
                    ),
                  ),
                ),
                SizedBox(
                  width: 3.0.w,
                ),
                Container(
                  width: 55.0.w,
                  height: 10.0.h,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CupertinoSwitch(
                            activeColor: red,
                            value: _switchValue5,
                            onChanged: (value) {
                              setState(() {
                                _switchValue5 = value;
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "ATRAPA MOSCAS",
                            style: TextStyle(color: blue),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget rowGif(String name, String asset, switchValue) {
    return InkWell(
      onTap: () {
        viewInfo(asset, 10, "recomendation", name, 10);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 35.0.w,
            height: 10.0.h,
            color: Colors.white,
            child: Center(
              child: Image.asset(
                asset,
                fit: BoxFit.fill,
                width: 100.0.w,
              ),
            ),
          ),
          SizedBox(
            width: 3.0.w,
          ),
          Container(
            width: 55.0.w,
            height: 10.0.h,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CupertinoSwitch(
                      activeColor: red,
                      value: switchValue,
                      onChanged: (value) {
                        setState(() {
                          switchValue = value;
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      " $name",
                      style: TextStyle(color: blue),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  viewInfo(String asset, int duration, String recomendation, String name,
      int calories) {
    Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return Scaffold(
                bottomNavigationBar: Container(
                  width: 100.0.w,
                  height: 10.0.h,
                  color: cyan,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buttonRounded(context, func: () {
                        Navigator.pop(context);
                      }, text: "   CERRAR")
                    ],
                  ),
                ),
                backgroundColor: blue,
                appBar: AppBar(
                  leading: SizedBox.shrink(),
                  backgroundColor: cyan,
                  elevation: 0,
                  centerTitle: true,
                  title: FittedBox(
                      fit: BoxFit.fitWidth, child: Text('$name'.toUpperCase())),
                ),
                body: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: cyan,
                            size: 7.0.w,
                          ),
                          Text(
                            " $calories Kcal",
                            style: TextStyle(color: cyan, fontSize: 6.0.w),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.03,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                            width: 100.0.w,
                            fit: BoxFit.fill,
                            image: AssetImage('$asset'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Text(
                            "$duration Seg",
                            style: TextStyle(color: cyan, fontSize: 6.0.w),
                          ),
                          Icon(
                            Icons.alarm,
                            color: cyan,
                            size: 7.0.w,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Center(
                                child: Text(
                              "RECOMENDACIÓN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 5.0.w,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            )),
                            decoration: BoxDecoration(
                                color: green,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(50),
                                    topLeft: Radius.circular(50))),
                            width: 70.0.w,
                            height: 6.0.h,
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Text(
                          "$recomendation",
                          style:
                              TextStyle(color: Colors.white, fontSize: 6.0.w),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
