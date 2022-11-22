import 'dart:convert';

import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/material.dart';

import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/moderator_tools.dart';

class ModerationSettingProvider with ChangeNotifier {
  ModeratorToolsModel? moderatorToolsModel1;

  ModeratorToolsModel? get moderatorToolsModel {
    return moderatorToolsModel1;
  }

  Future<void> getCommunity(Map<String, dynamic> query) async {
    //Return the moderated community data to get the topic choosen before if exist
    try {
      final response =
          await DioClient.get(path: '$createCommunity/done', query: query);
      moderatorToolsModel1 = ModeratorToolsModel.fromJson(response.data);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }

  Future<void> patchCommunity(Map<String, dynamic> data) async {
    //If the topic changed call patch to update the community topic
    try {
      final response = await DioClient.patch(path: createCommunity, data: data);
      notifyListeners();
    } catch (error) {
      print(error);
    }
  }
}
