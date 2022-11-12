import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/others_profile_data.dart';
import 'dart:convert';

//using in heighest widget to use
class OtherProfileprovider with ChangeNotifier {
  OtherProfileData? myProfile;
     OtherProfileData? get gettingOtherProfileData {
    return myProfile;
  }
  Future<void> fetchAndSetOtherProfile(String myUserName, otherUserName) async {
    var url =
        Uri.parse('http://localhost:8000/api/v1/users/{$myUserName}/about');
    try {
      final response = await http.get(url);
      final otherprofileeData = json.decode(response.body);
      if (response.statusCode == 200) {
        myProfile = OtherProfileData.fromJson(otherprofileeData);
      }
      notifyListeners();
      return Future.delayed(Duration(seconds: 3));
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
