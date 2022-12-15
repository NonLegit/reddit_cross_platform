import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../models/comments_data.dart';
import '../../networks/dio_client.dart';

//using in heighest widget to use
class ProfileCommentsProvider with ChangeNotifier {
  List<CommentsData>? data;

  List<CommentsData>? get gettingProfileComments {
    return data;
  }

  Future<void> fetchandSetProfileComments(
      String userName, int page, int limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);

      await DioClient.get(path: '/users/${userName}/comments').then((response) {
        print(response.data);
        List<CommentsData> tempData = [];
        response.data['posts'].forEach((post) {
          post['comments']
            .forEach((comment) {
              tempData.add(CommentsData.fromJson(comment));
            });
        });
        data = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }
}
