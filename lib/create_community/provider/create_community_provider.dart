import 'dart:convert';

import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/create_community_model.dart';



class CreateCommunityProvider with ChangeNotifier {
  CreateCommunityModel? createCommunityModel;
//Get community using name the user typed to check if it existed before or not
// return true if existed 
// false if it doesn't existt before
  Future<bool> getCommunity( Map<String, dynamic> query) async {
    try{
        final response = await DioClient.get(path: createCommunity, query:query );
        notifyListeners();
        return true;
    } catch(error){
      print(error);
      notifyListeners();
      return false;
    }
  }
  //Create New Community
  // return true if created succesfully
  //return false if error occured
  Future<bool> postCommunity(Map<String, dynamic> data) async {
    try{
        final response = await DioClient.post(path: createCommunity,data: data);
        notifyListeners();
        return true;
    } catch(error){
      print(error);
      notifyListeners();
      return false;
    }
  }
  
}
