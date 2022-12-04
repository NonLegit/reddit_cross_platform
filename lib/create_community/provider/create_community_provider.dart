import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/create_community_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateCommunityProvider with ChangeNotifier {
  CreateCommunityModel? createCommunityModel;
//Get community using name the user typed to check if it existed before or not
// return true if existed
// false if it doesn't exist before
  Future<bool> getCommunity(String userName) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      print(prefs);
      DioClient.init(prefs);
      subredditName = userName;
      final response = await DioClient.get(path: '/subreddits/$userName');
      notifyListeners();
      if (response.statusCode != 200) return false;
      return true;
    } catch (error) {
      print(error);
      // notifyListeners();
      return false;
    }
  }

  //Create New Community
  // return true if created succesfully
  //return false if error occured

  Future<bool> postCommunity(Map<String, dynamic> data) async {
    var response;
    try {
      //final response =
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      response = await DioClient.post(path: createCommunity, data: data);
      print('hamada................');
      if (response.statusCode == 200) {
        print('successs');
        notifyListeners();
        return true;
      } else {
        print('failedddddddddddddddddddddddddddddd');
        print(response.data['errorMessage']);
        return false;
      }
    } catch (error) {
      print('errorrrrrrrrrrrrrrrrr');
      print(response);
      //notifyListeners();
      return false;
    }
  }
}
