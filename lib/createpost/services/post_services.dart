import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:post/createpost/controllers/posts_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../../home/screens/home_layout.dart';
import '../model/send_post_model.dart';
import '../model/subreddits_of_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostServices {
  // were final instead of static var

final PostController controller =Get.put(PostController(),permanent: false) ;

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
      if(controller.typeOfPost.value=="image")
        {
         try
         {
           final response2 =
           await DioClient.post(path: '/posts/${response.data["data"]["_id"]}/images');
         }
         catch(e)
          {
         print("error in uploading media");
          }
        }
        // print(response.statusCode);
        // print(json.decode(response.data)['message']);
      }
    } catch (e) {
      print("error in sending the post -> $e");
    }
  }


}
