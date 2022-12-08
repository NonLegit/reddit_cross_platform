import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../../home/screens/home_layout.dart';
import '../model/post_model.dart';
import '../model/subreddits_of_user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostServices {
  // were final instead of static var
  static var dio = Dio();
  //static var client =http.Client();
  sendPost(PostModel model, BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    DioClient.init(prefs);
    try {
      int x = 2;
      final response =
          await DioClient.post(path: createPost, data: model.toJson());

      //data: json.encode(model.toJson())
      //     data: {
      // "title": "<string>",
      // "kind": "<string>",
      // "text": "<string>",
      // "url": "<string>",
      // "owner": "<string>",
      // "ownerType": "<string>",
      // "nsfw": "<boolean>",
      // "spoiler": "<boolean>",
      // "sendReplies": "<boolean>",
      // "flairId": "<string>",
      // "flairText": "<string>",
      // "suggestedSort": "<string>",
      // "scheduled": "<boolean>",
      // "sharedFrom": "<string>"
      // }
      //);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print(response.data);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("sent successfuly",
                  style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.green),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => homeLayoutScreen()));
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }
//  static Future<List<userSubredditsResponse>> getUserSubreddits(String type, BuildContext context) async {
//     var response=await dio.get("https://303292b3-af7a-40a5-87b5-7ca0524741e0.mock.pstmn.io/posts"
//     );
//    if (response.statusCode ==200)
//      {
//        var jsonString =response.body;
//        return productFromJson(jsonString);
//      }else
//        {
//          return null ;
//        }
//   }

}
