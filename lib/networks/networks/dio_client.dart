import 'dart:convert';
import 'package:dio/dio.dart';
import 'const_endpoint_data.dart';
//=====================================Providers====================================================//

class DioClient {
  static Dio? dio;

  static init(prefs) async {
    String token = '';
    try {
      token = prefs.getString('token') as String;
      print('hi');
      print(token);
    } catch (error) {
      print('dio error $error');
    }
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: 5000, //why ther is this here ?
        receiveTimeout: 20 * 1000, //why ther is this here ?
        responseType: ResponseType.json,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ' + token,
        },
      ),
    );
  }

  // Post:----------------------------------------------------------------------
  static Future<Response> post(
      {required String path,
      required Map<String, dynamic>? data,
      Map<String, dynamic>? query}) async {
    print('datain dio post : $data');
    return await dio!.post(path, data: json.encode(data));
  }
//------------------------PHOTO------------------------------//

  //---------------------------------------------------------//
  static Future<Response> get(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio!.get(path, queryParameters: query);
  }

  static Future<Response> patch(
      {required String path, Map<String, dynamic>? data}) async {
    return await dio!.patch(path, data: data);
  }

  static Future<Response> delete({required String path}) async {
    return await dio!.delete(path);
  }
}
