import 'package:flutter/material.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/myprofile_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

//using in heighest widget to use
class MyProfileProvider with ChangeNotifier {
  MyProfileData? loadProfile;

  MyProfileData? get gettingMyProfileData {
    return loadProfile;
  }

  Future<void> fetchAndSetMyProfile(String userName) async {
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
}
