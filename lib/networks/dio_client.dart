import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:post/other_profile/widgets/other_profile_app.dart';
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

  // Post:----------------------------------------------------------------------
  static Future<Response> post(
      {required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? query}) async {
    return await dio!
        .post(path, data: json.encode(data), queryParameters: query);
  }

static Future<Response> get({required String path,Map<String, dynamic>? query}) async {
    return await dio!.get(path, queryParameters: query);
  }

  static Future<Response> patch({required String path,required Map<String, dynamic> data}) async{
    return await dio!.patch(path,data: data);
  }
}
