import 'package:flutter/material.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import '../../../Utils/Colors.dart';
import 'package:dio/dio.dart';
import '../../../Utils/ConnectionState.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../Utils/UrlServer.dart';
import '../../Widgets/Toast.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';
import './DetailsEvidence.dart';
import '../../../Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import '../../../Database/Models/ClassLevel.dart';
import 'package:flutter/cupertino.dart';

class MailBox extends StatefulWidget {
  @override
  _MailBoxState createState() => _MailBoxState();
}

class _MailBoxState extends State<MailBox> {
  Dio dio = Dio();
  bool loading = false;
  List evidences = [];
  List<ClassLevel> classes = [];
  int newEvidences = 0;
  String idCourse;

  getMailBoxitems() async {
    setState(() {
      loading = true;
    });
    var prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("token");
    CourseDataRepository courseDataRepository = GetIt.I.get();
    var course = await courseDataRepository.getAllCourse();
    if (course.isNotEmpty) {
      setState(() {
        idCourse = course[0].courseId;
      });
    }
    bool hasInternet = await ConnectionStateClass().comprobationInternet();

    if (hasInternet) {
      try {
        Response response = await dio.get(
            "$urlServer/api/mobile/evidence/getNotStudentReviewed/$idCourse?token=$token");
        Response response2 = await dio.get(
            "$urlServer/api/mobile/evidence/getWithProfessorObservation/$idCourse?token=$token");
            print("$urlServer/api/mobile/evidence/getWithProfessorObservation/$idCourse?token=$token");
        setState(() {
          newEvidences = response.data.length;
        });
        for (var i = 0; i < response.data.length; i++) {
          if (evidences.toString().contains(response.data[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              evidences.add(response.data[i]);
            });
          }
        }
        for (var i = 0; i < response2.data.length; i++) {
          if (evidences.toString().contains(response2.data[i].toString())) {
            print("ya existe");
          } else {
            setState(() {
              evidences.add(response2.data[i]);
            });
          }
        }
        print(response2.data);
      } catch (e) {
        print(e);
      }
    } else {
      toast(context, "Debes tener conexión a internet para actualizar datos.",
          red);
    }
    print(evidences);
    getDataClasses();
  }

  @override
  void initState() {
    super.initState();
    getMailBoxitems();
  }

  getDataClasses() async {
    ClassDataRepository _classRepository = GetIt.I.get();
    for (var i = 0; i < evidences.length; i++) {
      var responseclass =
          await _classRepository.getClassID(evidences[i]["class"]);
      if (responseclass.isNotEmpty) {
        classes.add(responseclass[0]);
      } else {
        print("clase no encontrada");
      }
    }
    setState(() {
      loading = false;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: cyan,
          title: Text("Nuevas revisiones"),
          centerTitle: true,
        ),
        body: loading
            ? Center(
                child: Image.asset(
                  "Assets/videos/loading.gif",
                  width: 70.0.w,
                  height: 15.0.h,
                  fit: BoxFit.contain,
                ),
              )
            : loading == false && newEvidences == 0 && evidences.isEmpty
                ? Center(
                    child: Text(
                      "No tienes nuevas revisiones.",
                      style: TextStyle(color: Colors.white, fontSize: 16.0.sp),
                    ),
                  )
                : CupertinoScrollbar(
                    child: ListView.builder(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemBuilder: (context, index) {
                        return item(index);
                      },
                      itemCount: evidences.length,
                    ),
                  ));
  }

  Widget item(int index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          setState(() {
            evidences[index]["studentReviewed"] = true;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (ctx) => DetailsEvidence(
                        dataEvidence: evidences[index],
                        dataClass: {"number": classes[index].number},
                      )));
        },
        child: Card(
            color: evidences[index]["studentReviewed"] == true
                ? Colors.grey[300]
                : Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: ListTile(
              title: Text(
                "Nueva revisión:",
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                "Clase número: ${classes[index].number}",
                style: TextStyle(
                  color: evidences[index]["studentReviewed"] == true
                      ? Colors.black
                      : Colors.grey,
                ),
              ),
              isThreeLine: false,
              trailing: CircleAvatar(
                radius: 2.0.w,
                backgroundColor: evidences[index]["studentReviewed"] == true
                    ? Colors.transparent
                    : cyan,
              ),
            )),
      ),
    );
  }
}
