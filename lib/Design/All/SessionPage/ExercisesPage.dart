import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Routes/RoutePageControl.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:sizer/sizer.dart';
import '../../../Database/Repository/ExcerciseRepository/ExcerciseDataRepository.dart';

class ExcercisesPage extends StatefulWidget {
  @override
  _ExcercisesPageState createState() => _ExcercisesPageState();
}

class _ExcercisesPageState extends State<ExcercisesPage>
    with TickerProviderStateMixin {
  ExcerciseDataRepository excerciseDataRepository = GetIt.I.get();
  var name;
  var thumbnails = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      setState(() {
        name =
            (ModalRoute.of(context).settings.arguments as RouteArguments).args;
      });
      getThumbnails(name);
    });
    super.initState();
  }

  getThumbnails(var name) async {
    for (var i = 0; i < name["data"].length; i++) {
      print(name["data"][i].toString());
      var res = await excerciseDataRepository.getExcerciseName(name["data"][i]);
      setState(() {
        thumbnails.add(res[0].videoName);
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 6.0.h,
        backgroundColor: cyan,
        elevation: 0,
        leading: IconButton(
          icon: Device.get().isTablet
              ? Icon(Icons.arrow_back, size: 8.0.w, color: Colors.white)
              : Icon(Icons.arrow_back, size: 9.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 1.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text("${name["name"].toUpperCase()}",
                    style: TextStyle(fontSize: 14.0.sp))),
          ],
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Container(
            width: w,
            height: h,
            color: name["name"] == "calentamiento"
                ? cyan
                : name["name"] == "desarrollo"
                    ? green
                    : yellow,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.rotate(
                    origin: Offset(-3.0.w, -3.0.w),
                    angle: pi * 1,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: blue, height: 30.0.h),
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Transform.rotate(
                    // origin: Offset(-5.0.w, 1.0.w),
                    angle: pi * 2,
                    child: SvgPicture.asset("Assets/images/figure2.svg",
                        color: blue, height: 30.0.h),
                  ),
                ],
              ),
              // SizedBox(
              //   height: 3.0.h,
              // ),
            ],
          ),
          Scrollbar(
            child: name["name"] == "calentamiento"
                ? ListView.builder(
                    physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                    itemCount: name["data"].length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 5.0.h,
                          ),
                          InkWell(
                            onTap: () async {
                              var res = await excerciseDataRepository
                                  .getExcerciseName(name["data"][index]);
                              goToDetailsExcercises(
                                  res[0].videoName,
                                  "${name["data"][index]}",
                                  "${res[0].mets}",
                                  "${res[0].recommendation}",
                                  name["isTeacher"]);
                            },
                            child: Container(
                              color: Colors.white,
                              width: w,
                              child: Image.asset(
                                "Assets/thumbnails/${thumbnails[index]}.jpeg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(""),
                          FittedBox(
                            fit: BoxFit.fitWidth,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${name["data"][index]}",
                                  style: TextStyle(
                                      fontSize: 15.0.sp, color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    })
                : name["name"] == "desarrollo"
                    ? ListView.builder(
                        itemCount: name["data"].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 4.0.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  var res = await excerciseDataRepository
                                      .getExcerciseName(name["data"][index]);
                                  goToDetailsExcercises(
                                      res[0].videoName,
                                      "${name["data"][index]}",
                                      "${res[0].mets}",
                                      "${res[0].recommendation}",
                                      name["isTeacher"]);
                                },
                                child: Container(
                                  color: Colors.white,
                                  width: w,
                                  child: Image.asset(
                                    "Assets/thumbnails/${thumbnails[index]}.jpeg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(""),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${name["data"][index]}",
                                      style: TextStyle(
                                          fontSize: 15.0.sp,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        })
                    : ListView.builder(
                        itemCount: name["data"].length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              SizedBox(
                                height: 4.0.h,
                              ),
                              InkWell(
                                onTap: () async {
                                  var res = await excerciseDataRepository
                                      .getExcerciseName(name["data"][index]);
                                  goToDetailsExcercises(
                                      res[0].videoName,
                                      "${name["data"][index]}",
                                      "${res[0].mets}",
                                      "${res[0].recommendation}",
                                      name["isTeacher"]);
                                },
                                child: Container(
                                  color: Colors.white,
                                  width: w,
                                  child: Image.asset(
                                    "Assets/thumbnails/${thumbnails[index]}.jpeg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Text(""),
                              FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${name["data"][index]}",
                                      style: TextStyle(
                                          fontSize: 15.0.sp,
                                          color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
          )
        ],
      ),
    );
  }

  viewInfo(String asset, int duration, String recomendation, String name,
      int calories) {
    Navigator.push(
        context,
        new MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) {
              return new Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: FloatingActionButton.extended(
                  onPressed: () => Navigator.pop(context),
                  label: Icon(
                    Icons.close,
                    size: 40,
                  ),
                  icon: Text(
                    "   Cerrar   ",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                backgroundColor: Colors.white,
                appBar: new AppBar(
                  backgroundColor: cyan,
                  leading: SizedBox.shrink(),
                  elevation: 0,
                  centerTitle: true,
                  title: new FittedBox(
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: new BorderRadius.circular(10.0),
                            child: new Image(
                              width: MediaQuery.of(context).size.width * 0.9,
                              fit: BoxFit.fill,
                              image: new AssetImage('$asset'),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                backgroundImage:
                                    AssetImage("Assets/images/calories.png"),
                              ),
                              Text("$calories",
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.height *
                                              0.043))
                            ],
                          ),
                          Column(
                            children: [
                              CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius:
                                    MediaQuery.of(context).size.height * 0.05,
                                backgroundImage:
                                    AssetImage("Assets/images/duration.png"),
                              ),
                              Text(
                                "$duration S",
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            0.043),
                              )
                            ],
                          )
                        ],
                      ),
                      Divider(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Recomendación:",
                              style: TextStyle(
                                  fontSize:
                                      MediaQuery.of(context).size.height * 0.03,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20),
                        child: Text("$recomendation",
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.02)),
                      ),
                    ],
                  ),
                ),
              );
            }));
  }
}
