import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../model/send_post_model.dart';
import 'package:dio/dio.dart';
import 'dart:io';

class PostServices {
  // were final instead of static var

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
          SnackBar(
              content: Text("sent successfuly",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );

        // print(response.statusCode);
        // print(json.decode(response.data)['message']);
      }
    } catch (e) {
      print("error in sending the post -> $e");
    }
  }

  Future<void> uploadImage(XFile file, String id) async {
    String fileName = file.path.split('/').last;
    FormData formData = FormData.fromMap({
      "fileName": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    final response = await dio.post("/posts/$id/images", data: formData);
  }
}
