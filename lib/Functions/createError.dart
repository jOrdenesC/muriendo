import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:dio/dio.dart';
import 'package:movitronia/Utils/UrlServer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateError {
  createError(Dio dio, var error, String routeScreen) async {
    var prefs = await SharedPreferences.getInstance();
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    var uuid = prefs.getString("uuid");
    var token = prefs.getString("token");
    var infoDevice;
    if (Platform.isAndroid) {
      infoDevice = await deviceInfo.androidInfo;
    } else if (Platform.isIOS) {
      infoDevice = await deviceInfo.iosInfo;
    } else {
      infoDevice = "unknown";
    }
    try {
      dio.post("$urlServer/api/mobile/error?token=$token", data: {
        "device": infoDevice == "unknown"
            ? "unknown device"
            : Platform.isIOS
                ? "${infoDevice.name} - ${infoDevice.model}"
                : "${infoDevice.manufacturer} ${infoDevice.brand} - ${infoDevice.model}",
        "error": "$error",
        "deviceUuid": uuid,
        "versionApp": "$versionApp",
        "routeScreen": routeScreen
      });
    } catch (e) {
      print(e);
    }
  }
}
