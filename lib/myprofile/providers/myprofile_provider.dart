import 'package:flutter/material.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/myprofile_data.dart';
import '../models/myprofile_followers_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

//using in heighest widget to use
class MyProfileProvider with ChangeNotifier {
  MyProfileData? loadProfile;
  List<MyProfileFollowersData>? followersData;
  MyProfileData? get gettingMyProfileData {
    return loadProfile;
  }

  List<MyProfileFollowersData>? get gettingMyProfileFollowersData {
    return followersData;
  }

  Future<void> fetchAndSetMyProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: myprofile).then((response) {
        print(response.data);
        loadProfile = MyProfileData.fromJson(response.data['user']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      print('heelo');
      throw (error);
    }
  }

  Future<void> fetchAndSetFollowersData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/users/followers').then((response) {
        print(
            '===========================Followers=========================================');
       // print(response.data);
        List<MyProfileFollowersData> tempData = [];
        response.data['followers'].forEach((follower) {
          tempData.add(MyProfileFollowersData.fromJson(follower));
        });
        followersData = tempData;
        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
