import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';

class SearchEvidences extends StatefulWidget {
  @override
  _SearchEvidencesState createState() => _SearchEvidencesState();
}

class _SearchEvidencesState extends State<SearchEvidences> {
  String school;
  String grade;
  TextEditingController rut = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final dynamic args =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: Container(
        width: double.infinity,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buttonRounded(context, func: () {
              goToMenuEvidences();
            }, text: "   CONTINUAR")
          ],
        ),
      ),
      appBar: args == true
          ? AppBar(
            leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 12.0.w,
              color: Colors.white
            ),
            onPressed: () => Navigator.pop(context),
          ),
              title: Column(
                children: [
                  SizedBox(
                height: 2.0.h,
              ),
                  FittedBox(fit: BoxFit.fitWidth, child:Text("EVIDENCIAS")),
                ],
              ),
              backgroundColor: cyan,
              elevation: 0,
              centerTitle: true,
            )
          : null,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
        child: Column(
          children: [
            SizedBox(
              height: 10.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Center(
                    child: Text(
                      "EVIDENCIA ALUMNO",
                      style: TextStyle(color: blue, fontSize: 6.5.w),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  width: 80.0.w,
                  height: 6.0.h,
                )
              ],
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("COLEGIO",
                        style: TextStyle(color: Colors.white, fontSize: 7.0.w)),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Container(
                      child: Center(
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          underline: SizedBox.shrink(),
                          hint: school == null
                              ? Text(
                                  "Selecciona tu colegio",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  school,
                                  style: TextStyle(color: Colors.white),
                                ),
                          items: <String>[
                            'Colegio 1',
                            'Colegio 2',
                            'Colegio 3',
                            'Colegio 4'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              school = val;
                            });
                          },
                        ),
                      ),
                      width: 80.0.w,
                      height: 6.0.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("CURSO",
                        style: TextStyle(color: Colors.white, fontSize: 7.0.w)),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Container(
                      child: Center(
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.white,
                          underline: SizedBox.shrink(),
                          hint: grade == null
                              ? Text(
                                  "Selecciona tu curso",
                                  style: TextStyle(color: Colors.white),
                                )
                              : Text(
                                  grade,
                                  style: TextStyle(color: Colors.white),
                                ),
                          items: <String>[
                            'Curso 1',
                            'Curso 2',
                            'Curso 3',
                            'Curso 4'
                          ].map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              grade = val;
                            });
                          },
                        ),
                      ),
                      width: 80.0.w,
                      height: 6.0.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 3.0.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text("RUT ALUMNO",
                        style: TextStyle(color: Colors.white, fontSize: 7.0.w)),
                    SizedBox(
                      height: 1.0.h,
                    ),
                    Container(
                      child: Center(
                        child: TextField(
                          controller: rut,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 6.0.w),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Ingresa su rut",
                              hintStyle: TextStyle(color: Colors.white)),
                        ),
                      ),
                      width: 80.0.w,
                      height: 6.0.h,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
