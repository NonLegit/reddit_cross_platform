import 'dart:convert';
import 'package:dio/dio.dart';
import 'constant_endpoint_data.dart';

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

  // Profile:----------------------------------------------------------------------
  static Future<Response> get(
      {required String path,
      Map<String, dynamic>? query}) async {
    return await dio!
        .get(path, queryParameters: query);
  }
}

