import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/myprofile_data.dart';
import 'dart:convert';

//using in heighest widget to use
class MyProfileProvider with ChangeNotifier {
  MyProfileData? myProfile;

  MyProfileData? get gettingMyProfileData {
    return myProfile;
  }

  Future<void> fetchAndSetMyProfile(String userName) async {
    var url = Uri.parse(
        'https://7b436585-e793-4ff0-a6a1-96a2c9529198.mock.pstmn.io/users/{$userName}/about'
        // 'http://localhost:8000/api/v1/users/{$userName}/about'
        );
    try {
      final response = await http.get(url);
      final profileeData = json.decode(response.body);
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      print(profileeData);
      if (response.statusCode == 200) {
        myProfile = MyProfileData.fromJson(profileeData);
      }
      notifyListeners();
      return Future.delayed(Duration(seconds: 3));
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
