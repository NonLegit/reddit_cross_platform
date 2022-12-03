import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:post/other_profile/widgets/other_profile_app.dart';
import 'const_endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
//=====================================Providers====================================================//

class DioClient {
  static Dio? dio;

  static init(prefs) async {
    String token = '';
    try {
      token = prefs.getString('token') as String;
    } catch (error) {
      print(error);
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
      required Map<String, dynamic> data,
      Map<String, dynamic>? query}) async {
    return await dio!
        .post(path, data: json.encode(data), queryParameters: query);
  }

  static Future<Response> get(
      {required String path, Map<String, dynamic>? query}) async {
    return await dio!.get(path, queryParameters: query);
  }

  static Future<Response> patch(
      {required String path, required Map<String, dynamic> data}) async {
    return await dio!.patch(path, data: data);
  }
}
