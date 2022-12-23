import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../model/send_post_model.dart';
class PostServices
{
  static var dio = Dio();
  //static var client =http.Client();
  sendPost(SendPostModel model, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      final response =
      await DioClient.post(path: createPost, data: model.toJson());
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("response of sending post ${response.data}");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("sent successfuly",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      print("error in sending the post -> $e");
    }
  }
  Future<void> uploadImage(File file,Future<String> id) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "file":
      await MultipartFile.fromFile(file.path, filename:fileName),
    });
    final response = await dio.post("/posts/$id/images", data: formData);
  }

}
