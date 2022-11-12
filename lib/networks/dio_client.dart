import 'dart:convert';

import 'package:dio/dio.dart';
import 'const_endpoint_data.dart';

class DioClient {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: 5000,
          receiveTimeout: 20 * 1000,
          responseType: ResponseType.json
          // headers: {'Content-type': 'text/plain'},
          ),
    );
  }

  static initCreateCoumunity() {
    dio = Dio(
      BaseOptions(
          baseUrl: createcommunity_baseUrl2,
          receiveDataWhenStatusError: true,
          connectTimeout: 5000,
          receiveTimeout: 20 * 1000,
          responseType: ResponseType.json
          // headers: {'Content-type': 'text/plain'},
          ),
    );
  }

  static initNotification() {
    dio = Dio(
      BaseOptions(
          baseUrl: notification_baseUrl3,
          receiveDataWhenStatusError: true,
          connectTimeout: 5000,
          receiveTimeout: 20 * 1000,
          responseType: ResponseType.json
          // headers: {'Content-type': 'text/plain'},
          ),
    );
  }

  // Post:----------------------------------------------------------------------
  static Future<Response> post(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query}) async {
    return await dio!
        .post(path, data: json.encode(data), queryParameters: query);
  }

  static Future<Response> get({required String path}) async {
    return await dio!.get(path);
  }
}
