import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:movitronia/Database/Models/ClassLevel.dart';
import 'package:movitronia/Database/Models/OfflineData.dart';
import 'package:movitronia/Database/Repository/ClassLevelRepository/ClassDataRepository.dart';
import 'package:movitronia/Database/Repository/OfflineRepository.dart';
import 'package:movitronia/Design/All/Settings/offlineDataPage.dart';
import 'package:movitronia/Utils/Colors.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class OfflineDataList extends StatefulWidget {
  @override
  _OfflineDataListState createState() => _OfflineDataListState();
}

class _OfflineDataListState extends State<OfflineDataList> {
  bool loading = false;
  List<OfflineData> res = [];
  List<ClassLevel> classes = [];
  List<String> thumbs = [];

  @override
  void initState() {
    getAllData();
    super.initState();
  }

  Future<List<OfflineData>> getData() async {
    res.clear();
    OfflineRepository offlineRepository = GetIt.I.get();
    res = await offlineRepository.getAll();
    return res;
  }

  Future getDataClasses(OfflineData offlineData) async {
    ClassDataRepository classDataRepository = GetIt.I.get();
    var classData = await classDataRepository.getClassID(offlineData.idClass);
    for (var i = 0; i < classData.length; i++) {
      classes.add(classData[i]);
    }
    return true;
  }

  getAllData() async {
    setState(() {
      loading = true;
    });
    var offlineData = await getData();
    for (var i = 0; i < offlineData.length; i++) {
      await getDataClasses(offlineData[i]);
      await getThumbnails(offlineData[i]);
    }
    setState(() {
      loading = false;
    });
  }

  Future getThumbnails(OfflineData offlineData) async {
    final fileName = await VideoThumbnail.thumbnailFile(
      video: offlineData.uriVideo,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.JPEG,
      maxHeight:
          64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
      quality: 75,
    );
    print("FILE: $fileName");
    setState(() {
      thumbs.add(fileName);
    });
    return true;
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
            FittedBox(fit: BoxFit.fitWidth, child: Text("DATOS LOCALES")),
          ],
        ),
        elevation: 0,
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
          : loading == false && res.length == 0
              ? Center(
                  child: Text(
                  "Sin datos locales.",
                  style: TextStyle(color: Colors.white, fontSize: 6.0.w),
                ))
              : Scrollbar(
                  child: ListView.builder(
                      itemCount: res.length,
                      itemBuilder: (context, index) {
                        return item(res[index], index);
                      }),
                ),
    );
  }

  Widget item(OfflineData offlineData, int index) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (ctx) => OfflineDataPage(
                      offlineData: offlineData,
                      session: classes[index].number.toString(),
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(File(thumbs[index])),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "FASE DE EVIDENCIA: ${offlineData.phase}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "N° DE SESIÓN: ${classes[index].number}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 15.0.w,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
