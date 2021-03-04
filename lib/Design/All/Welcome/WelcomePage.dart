import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class WelcomePage extends StatefulWidget {
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  List colleges = [];
  bool loading = false;
  String name;
  getName() async {
    var prefs = await SharedPreferences.getInstance();
    var nameLocal = prefs.getString("name") ?? "";
    setState(() {
      var res = nameLocal.toString().split(" ");
      name = res[0].toUpperCase();
    });
    await getData();
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  getData() async {
    var dio = Dio();
    setState(() {
      loading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    var resProfessorData =
        await dio.get("$urlServer/api/mobile/user/course?token=$token");
    for (var i = 0; i < resProfessorData.data.length; i++) {
      print(resProfessorData.data[i].toString());
      if (colleges
          .toString()
          .contains(resProfessorData.data[i]["college"]["_id"].toString())) {
        print("Ya existe");
      } else {
        colleges.add({
          "_id": resProfessorData.data[i]["college"]["_id"],
          "name": resProfessorData.data[i]["college"]["name"],
          "selected": false
        });
      }
    }
    print(colleges.toList().toString());
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    final dynamic role =
        (ModalRoute.of(context).settings.arguments as RouteArguments).args;
    return Scaffold(
      bottomNavigationBar: Container(
        width: 100.0.w,
        height: 10.0.h,
        color: cyan,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading == false
                ? buttonRounded(context, func: () {
                    if (role == "user") {
                      goToHome(
                        role,
                        {}
                      );
                    } else {
                      if (colleges.length > 1) {
                        goToTeacherSelectCollege();
                      } else {
                        goToHome(
                          role,
                          colleges[0]
                        );
                      }
                    }
                  }, text: "   COMENZAR")
                : SizedBox.shrink()
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "Assets/images/wall2.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "BIENVENIDO(A) ${name.toString()}",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blue, fontSize: 7.0.w),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    role == "user"
                        ? 'Descubre el mundo MOVITRONIA, una forma entrenida de hacer actividad física, sigue las instrucciones y vivirás una experiencia distinta de hacer ejercicio, sólo oprime "comenzar" y empieza esta aventura.'
                        : 'Descubre el mundo MOVITRONIA, una forma entrenida de PLANIFICAR TUS CLASES y construir evaluaciones estándarizadas para tus alumnos.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: blue, fontSize: 5.5.w),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
