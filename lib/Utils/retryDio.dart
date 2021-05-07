import "package:dio/dio.dart";
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movitronia/Utils/retryDioConnectivity.dart';

class RetryOnConnectionChangeInterceptor extends Interceptor {
  final DioConnectivityRequestRetrier requestRetrier;

  RetryOnConnectionChangeInterceptor({
    @required this.requestRetrier
  });

  @override
  Future onError(DioError err) async {
    print("entra al onError $err");
    print(err.type);
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
    // Let the error pass through if it's not the error we're looking for
    return err;
  }

  bool _shouldRetry(DioError err) {
    return err.type == DioErrorType.DEFAULT;
  }
}
