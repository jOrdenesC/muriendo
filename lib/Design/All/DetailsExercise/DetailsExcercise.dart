import 'package:flutter/material.dart';
import 'package:movitronia/Design/Widgets/Button.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:orientation_helper/orientation_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

class DetailsExcercise extends StatefulWidget {
  @override
  _DetailsExcerciseState createState() => _DetailsExcerciseState();
}

class _DetailsExcerciseState extends State<DetailsExcercise> {
  @override
  void initState() {
    super.initState();
    getWeight();
  }

  var weight;
  getWeight() async {
    var prefs = await SharedPreferences.getInstance();
    var res = prefs.getString("weight");
    setState(() {
      weight = res;
    });
  }

  Widget build(BuildContext context) {
    final dynamic args =
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
              Navigator.pop(context);
            }, text: "   CERRAR")
          ],
        ),
      ),
      backgroundColor: blue,
      appBar: AppBar(
        backgroundColor: cyan,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, size: 12.0.w, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          children: [
            SizedBox(
              height: 2.0.h,
            ),
            FittedBox(
                fit: BoxFit.fitWidth,
                child: Text('${args["name"]}'.toUpperCase())),
          ],
        ),
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
                  " ${int.parse(args["kcal"]) * 0.0175 * int.parse(weight)} Kcal/min",
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
                  image: AssetImage('Assets/thumbnails/${args["name"]}.png'),
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
                // Text(
                //   "${args["duration"]} Seg ",
                //   style: TextStyle(color: cyan, fontSize: 6.0.w),
                // ),
                // Icon(Icons.alarm, color: cyan, size: 7.0.w,)
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
                args["desc"],
                style: TextStyle(color: Colors.white, fontSize: 6.0.w),
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
  }
}
