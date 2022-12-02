import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/others_profile_data.dart';
import 'dart:convert';

//using in heighest widget to use
class OtherProfileprovider with ChangeNotifier {
  OtherProfileData? loadProfile;
  OtherProfileData? get gettingOtherProfileData {
    return loadProfile;
  }

  Future<void> fetchAndSetOtherProfile(String otherUserName) async {
    try {
      userName = otherUserName;
      DioClient.init();

      await DioClient.get(path: otherprofile).then((response) {
        loadProfile = OtherProfileData.fromJson(response.data['data']);
        notifyListeners();
      });
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
