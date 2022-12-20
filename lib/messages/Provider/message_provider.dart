import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networks/dio_client.dart';
import '../../widgets/handle_error.dart';
import '../models/user_message.dart';

class MessageProvider with ChangeNotifier {
  Map<String, List<ShowMessagesModel>> messageShow = {};
//http://localhost:8000/api/v1/subreddits/{subredditName}/moderators/{moderatorName}
  Future<void> getAllMessages(context, page, limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      messageShow = {};
      await DioClient.get(
          path: '/messages',
          query: {'page': page, 'limit': limit}).then((value) {
        print(value.data['data']);
        value.data['data'].forEach((element) {
          print(element);
          String id;
          final message = ShowMessagesModel.fromJson(element);
          print('herrree');
          // print(element);

          // if(newList == null){
          //newList = List<ShowMessagesModel>;
          if (message.type == 'userMessage') {
            id = message.subjectId!;
          } else {
            id = message.sId!;
          }
          // var newList = messageShow.entries
          //     .firstWhere((element) => element.value == id)
          //     .value;
          // if (newList == null) {
          //   newList = [];
          // }
          //List<ShowMessagesModel> newList = [];
          // newList.add(message);
          print('**********************IDS*****************************');
          print(message.sId);
          messageShow.putIfAbsent(id, () => []).add(message);
          // } else{

          // }

          // messageShow.addEntries(newEntries)
          // print(messageShow[message.subjectId].runtimeType);
          // messageShow.
          // messageShow.addEntries('${message.subjectId}':message);
          // messageShow.update(message.subjectId!,
          //     (value) => (value.add(message)) as List<ShowMessagesModel>);
          // messageShow.putIfAbsent(
          //     message.subjectId!,
          //     () => messageShow[message.subjectId!]!.add(message)
          //         as List<ShowMessagesModel>);
          // messageShow[message.subjectId!]!.add(message);

          // print(messageShow[message.subjectId]);
        });
        notifyListeners();
      });
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  Future<void> createMessage(data, context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      DioClient.post(path: '/messages', data: data);
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  Future<void> replyMessage(data, context, messageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(messageId);

      DioClient.post(path: '/messages/$messageId/reply', data: data);
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  Future<void> blockUser(context, userName) async {
    //http://localhost:8000/api/v1/users/{userName}/block_user
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      DioClient.post(path: '/users/$userName/block_user', data: {});
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  Future<void> acceptSubredditInvite(context, subredditName) async {
    try {
      print(subredditName);
      //http://localhost:8000/api/v1/subreddits/{subredditName}/{action}/invitation
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      DioClient.post(
          path: '/subreddits/$subredditName/accept/invitation', data: {});
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }
}
