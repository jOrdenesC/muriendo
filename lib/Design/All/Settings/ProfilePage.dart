import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Design/Widgets/Loading.dart';
import 'package:movitronia/Design/Widgets/Toast.dart';
import 'package:movitronia/Functions/createError.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:movitronia/Database/Repository/CourseRepository.dart';
import 'package:get_it/get_it.dart';

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
  bool modify = false;
  var dio = Dio();

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
      phone.text = prefs.getString("phone");
      mail.text = prefs.getString("email");
      birthday.text = prefs.getString("birthday");
      role.text = prefs.getString("role");
    });
  }

  @override
  void initState() {
    super.initState();
    getDataUser();
  }

  validate() {
    if (height.text.isEmpty) {
      toast(context, "Ingresa una estatura válida.", red);
    } else if (weight.text.isEmpty) {
      toast(context, "Ingresa un peso válido.", red);
    } else {
      updateInfo();
    }
  }

  updateInfo() async {
    var prefs = await SharedPreferences.getInstance();
    var heightText = prefs.getString("height");
    var weightText = prefs.getString("weight");
    var phoneText = prefs.getString("phone");
    var token = prefs.getString("token");

    if (heightText == height.text &&
        weightText == weight.text &&
        phoneText == phone.text) {
      toast(context, "No se realizaron cambios en los datos del perfil.", cyan);
    } else {
      loading(context,
          content: Center(
            child: Image.asset(
              "Assets/videos/loading.gif",
              width: 70.0.w,
              height: 15.0.h,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(
            "Actualizando datos...",
            textAlign: TextAlign.center,
          ));

      try {
        Response response = await dio
            .post("$urlServer/api/mobile/changeUserInfo?token=$token", data: {
          "height": height.text,
          "weight": weight.text,
          "phone": phone.text
        });
        if (response.statusCode == 200) {
          prefs.setString("height", height.text);
          prefs.setString("weight", weight.text);
          prefs.setString("phone", phone.text);
          toast(context, "Se han actualizado tus datos.", green);
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          CreateError().createError(
              dio, "error else profilePage ${response.data}", "Profile page");
          toast(
              context,
              "Ha ocurrido un error al intentar actualizar los datos. Inténtalo nuevamente.",
              red);
        }
      } catch (e) {
        print(e.toString());
        Navigator.pop(context);
        CreateError().createError(dio, e.toString(), "Profile page");
        toast(
            context,
            "Ha ocurrido un error al intentar actualizar los datos. Inténtalo nuevamente.",
            red);
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: modify
            ? Container(
                width: 100.0.w,
                height: 10.0.h,
                color: cyan,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buttonRounded(context, func: () {
                      validate();
                    },
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: blue,
                          size: 4.0.h,
                        ),
                        text: "  ACTUALIZAR")
                  ],
                ),
              )
            : SizedBox.shrink(),
        appBar: widget.isMenu == null || widget.isMenu
            ? null
            : AppBar(
                actions: [
                  IconButton(
                    icon: modify
                        ? Icon(
                            Icons.close,
                            size: 7.0.w,
                            color: Colors.white,
                          )
                        : Icon(
                            Icons.edit,
                            size: 7.0.w,
                            color: Colors.white,
                          ),
                    color: Colors.white,
                    onPressed: () {
                      setState(() {
                        modify = !modify;
                        enabledTextfields = modify;
                      });
                    },
                  )
                ],
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
                      color: red,
                      name: "Colegio",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: college,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      color: red,
                      name: "Curso",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: courseText,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      color: red,
                      name: "Nombre",
                      child: TextFormField(
                        // initialValue: name.text,
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: name,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  InkWell(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // onTap: () {
                    //   if (modify) {
                    //     return DatePicker.showDatePicker(context,
                    //         minDateTime: DateTime.parse("2000-01-01"),
                    //         locale: DateTimePickerLocale.es,
                    //         maxDateTime: DateTime.now(),
                    //         dateFormat: "yyyy-MMMM-dd",
                    //         onConfirm: (date, list) {
                    //       print(date.toString());
                    //       setState(() {
                    //         birthday.text =
                    //             "${date.toString().substring(0, 10)}";
                    //       });
                    //     });
                    //   } else {
                    //     print("nothing");
                    //   }
                    // },
                    child: item(
                        color: red,
                        name: "Fecha de nacimiento",
                        child: TextFormField(
                          enabled: false,
                          // initialValue: birthday.text,
                          decoration: InputDecoration(border: InputBorder.none),
                          controller: birthday,
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(color: Colors.white, fontSize: 5.5.w),
                        )),
                  ),
                  item(
                      color: modify ? Colors.grey : red,
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
                      color: modify ? Colors.grey : red,
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
                      color: modify ? Colors.grey : red,
                      name: "Celular",
                      child: TextFormField(
                        enabled: enabledTextfields,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: phone,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.5.w),
                      )),
                  item(
                      color: red,
                      name: "Correo",
                      child: TextFormField(
                        enabled: false,
                        decoration: InputDecoration(border: InputBorder.none),
                        controller: mail,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 5.0.w),
                      )),
                  SizedBox(
                    height: 5.0.h,
                  )
                ],
              )
            ]),
          ),
        ));
  }

  Widget item({Widget child, String name, Color color}) {
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
                color: color,
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
