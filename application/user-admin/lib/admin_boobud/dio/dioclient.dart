import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as Gets;
// import 'package:get/get.dart';
import 'package:medicare/admin_boobud/uttils/constant.dart';
import 'package:medicare/admin_boobud/uttils/debug.dart';
import 'package:medicare/admin_boobud/uttils/env.dart';
import 'package:medicare/helpers/storage/local_storage.dart';

class DioClient {
  final CancelToken cancelToken = CancelToken();
  final Dio dio;

  DioClient(BuildContext context,
      {String? baseUrl,
        bool useToken = false,
        bool isApiKeyUse = false,
        bool isJson = false})
      : dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      baseUrl: baseUrl ?? Env.baseUrl1,
    ),
  ) {
    Debug.printLog("✅ API Base URL: ${dio.options.baseUrl}");

    dio.options.headers = {
      "Content-Type":
      isJson ? "application/json" : "application/x-www-form-urlencoded",
    };

    if (useToken && LocalStorage.getToken() != null) {
      dio.options.headers["Authorization"] = "Bearer ${LocalStorage.getToken()}";
      Debug.printLog("AuthToken----${LocalStorage.getToken()}");
    }


    dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));

    dio.interceptors.add(AppInterceptors());
  }
}

class AppInterceptors extends Interceptor {
  AppInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    Debug.printLog("On Request ==>> ");
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException e, ErrorInterceptorHandler handler) {
    Debug.printLog("❌ DioError: ${e.response?.statusCode} - ${e.message}");
    Debug.printLog("❌ DioError Response Data: ${e.response?.data}");

    if (e.response != null) {
      Debug.printLog("Error Status Status: ${e.response?.data["status"]}");
      Debug.printLog("Error Status message: ${e.response?.data["message"]}");
      if (e.response?.statusCode == 404) {
        Debug.printLog("Resource not found! Handle 404 error here.");
        Constant.errorShankBar(Gets.Get.context!, "${e.response?.data["message"].toString()}");
      } else {
        Constant.errorShankBar(Gets.Get.context!, "${e.response?.data["message"].toString()}");
        Debug.printLog("Other Error: ${e.response?.statusMessage}");
        Debug.printLog("Other Error: ${e.response?.data}");
      }
    } else {
      Constant.errorShankBar(Gets.Get.context!, "${e.response?.statusMessage.toString()}");
      Debug.printLog("Dio Error1: ${e.message}");
    }
    super.onError(e, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    Debug.printLog("On Response ==>> ");
    super.onResponse(response, handler);
  }
}
