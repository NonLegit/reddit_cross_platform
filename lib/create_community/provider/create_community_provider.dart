import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/create_community_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';

class CreateCommunityProvider with ChangeNotifier {
  CreateCommunityModel? createCommunityModel;
//Get community using name the user typed to check if it existed before or not
// return true if existed
// false if it doesn't exist before
  Future<bool> getCommunity(String userName, BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      subredditName = userName;
      final response = await DioClient.get(path: '/subreddits/$userName');
      notifyListeners();
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }

  //Create New Community
  // return true if created succesfully
  //return false if error occured

  Future<bool> postCommunity(
      Map<String, dynamic> data, BuildContext context) async {
    var response;
    try {
      //final response =
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      response = await DioClient.post(path: createCommunity, data: data);
      if (response.statusCode == 200) {
        notifyListeners();
      }
      return true;
    } on DioError catch (e) {
      if (e.response!.statusCode != 404) {
        HandleError.errorHandler(e, context);
      }
      return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      return false;
    }
  }
}
