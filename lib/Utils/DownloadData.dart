import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';

Future<bool> download() async {
  var dio = Dio();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  dio.download(
      "https://www.callicoder.com/assets/images/post/large/spring-boot-file-upload-download-rest-api-service-example-application.jpg, savePath",
      "$appDocDir/image1.jpg", onReceiveProgress: (rec, total) {
    print(rec);
    print(total);
  });
  return true;
}
