import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../models/myprofile_data.dart';
import '../models/myprofile_followers_data.dart';
import '../../widgets/handle_error.dart';


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
  // ===================================this function used to===========================================//
//==================fetch and set date===========================//
  Future<void> fetchAndSetMyProfile(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: myprofile).then((response) {
        loadProfile = MyProfileData.fromJson(response.data['user']);
        notifyListeners();
      });
    } on DioError catch (e) {
        HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
  // ===================================this function used to===========================================//
//==================fetch and set date of Followers===========================//
  Future<void> fetchAndSetFollowersData(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      await DioClient.get(path: '/users/followers').then((response) {
        List<MyProfileFollowersData> tempData = [];
        response.data['followers'].forEach((follower) {
          tempData.add(MyProfileFollowersData.fromJson(follower));
        });
        followersData = tempData;
        notifyListeners();
      });
    } on DioError catch (e) {
        HandleError.errorHandler(e, context);
    } catch (error) {
      HandleError.handleError(error.toString(), context);
    }
  }
}
