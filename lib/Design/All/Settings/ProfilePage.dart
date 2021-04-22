import 'package:flutter/material.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_cupertino_date_picker_fork/flutter_cupertino_date_picker_fork.dart';

class ProfilePage extends StatefulWidget {
  final bool isMenu;
  ProfilePage({this.isMenu});
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool enabledTextfields = false;
  TextEditingController name = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController role = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController mail = TextEditingController();
  TextEditingController college = TextEditingController();
  TextEditingController courseText = TextEditingController();

  getDataUser() async {
    var prefs = await SharedPreferences.getInstance();
    CourseDataRepository courseDataRepository = GetIt.I.get();
    var course = await courseDataRepository.getAllCourse();

    setState(() {
      college.text = course[0].college["name"].toString().toUpperCase();
      courseText.text = "${course[0].number} ${course[0].letter}".toUpperCase();
      name.text = prefs.getString("name");
      height.text = prefs.getString("height");
      weight.text = prefs.getString("weight");
      phone.text = prefs.getString("phone") ?? "Sin datos de teléfono";
      mail.text = prefs.getString("email");
      birthday.text = prefs.getString("birthday");
      role.text = prefs.getString("role");
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isMenu == false) {
      setState(() {
        enabledTextfields = true;
      });
    } else {
      setState(() {
        enabledTextfields = false;
      });
    }
    getDataUser();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: widget.isMenu == null || widget.isMenu
            ? null
            : AppBar(
                backgroundColor: cyan,
                leading: IconButton(
                  icon:
                      Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Column(
                  children: [
                    SizedBox(
                      height: 2.0.h,
                    ),
                    FittedBox(fit: BoxFit.fitWidth, child: Text("PERFIL")),
                  ],
                ),
                centerTitle: true,
                elevation: 0,
              ),
        body: Scrollbar(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            child: Column(children: [
              SizedBox(
                height: 3.0.h,
              ),
              Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: red,
                        radius: 20.0.w,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Center(
                            child: Icon(
                              Icons.person,
                              color: blue,
                              size: 30.0.w,
                            ),
                          ),
                          radius: 18.0.w,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 30.0.w,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: 12.0.h,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 8.0.w,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  child: Image.asset(
                                    "Assets/images/LogoMovi.png",
                                    width: 11.0.w,
                                  ),
                                  radius: 7.0.w,
                                  backgroundColor: blue,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 2.0.h,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 2.0.h,
                  ),
                  item(
                      name: "Colegio",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: college,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      name: "Curso",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: courseText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      name: "Nombres",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  InkWell(
                    onTap: () {
                      DatePicker.showDatePicker(context,
                          locale: DateTimePickerLocale.es,
                          dateFormat: "yyyy-MMMM-dd", onConfirm: (date, list) {
                        print(date.toString());
                        setState(() {
                          birthday.text = "${date.toString().substring(0, 10)}";
                        });
                      });
                    },
                    child: item(
                        name: "Fecha de nacimiento",
                        child: TextFormField(
                          // initialValue: birthday.text,
                          enabled: false,
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: birthday,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 5.5.w),
                        )),
                  ),
                  item(
                      name: "Estatura (cm.)",
                      child: TextFormField(
                        // initialValue: height.text + " cm.",
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: height,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      name: "Peso (kg.)",
                      child: TextFormField(
                        // initialValue: weight.text + " kg.",
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: weight,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      name: "Celular",
                      child: TextFormField(
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      name: "Correo",
                      child: TextFormField(
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: mail,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                      )),
                  SizedBox(
                    height: 10.0.h,
                  ),
                ],
              )
            ]),
          ),
        ));
  }

  Widget item({Widget child, String name}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          "$name",
          textAlign: TextAlign.end,
          style: TextStyle(color: Colors.white, fontSize: 6.0.w),
        ),
        Container(
            decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.all(Radius.circular(18))),
            width: 80.0.w,
            height: 5.5.h,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: child,
            )),
        SizedBox(
          height: 2.0.h,
        )
      ],
    );
  }
}
