import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Utils/retryDioConnectivity.dart';
import 'package:sizer/sizer.dart';
import 'Colors.dart';

class RetryOnConnectionChangeInterceptorDialog extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;
  final BuildContext context;
  final Function function;

  RetryOnConnectionChangeInterceptorDialog(
      {@required this.requestRetrier,
      @required this.context,
      @required this.function});

  @override
  Future onError(DioError err) async {
    print("entra al onError $err");
    print(err.type);
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(
              'Ha ocurrido un error mientras se subían los datos. ¿Quieres reintentarlo?',
              style: TextStyle(color: blue),
            ),
            actions: [
              FlatButton(
                onPressed: () => Navigator.pop(context, false), // passing false
                child: Text(
                  'Guardar local',
                  style: TextStyle(fontSize: 6.0.w, color: green),
                ),
              ),
              FlatButton(
                onPressed: () => Navigator.pop(context, true), // passing true
                child: Text(
                  'Reintentar',
                  style: TextStyle(fontSize: 6.0.w, color: red),
                ),
              ),
            ],
          );
        }).then((retry) {
      if (retry == null) return;

      if (retry) {
        print("yes");
        if (_shouldRetry(err)) {
          try {
            print("retry init");
            return requestRetrier.scheduleRequestRetry(err.request);
          } catch (e) {
            print("return error $e");
            // Let any new error from the retrier pass through
            return e;
          }
        }
        // user pressed Yes button
      } else {
        function();
        // user pressed No button
      }
    });
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT && err.error != null;
  }
}
