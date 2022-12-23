import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../networks/dio_client.dart';
import '../../widgets/handle_error.dart';
import '../models/user_message.dart';

class MessageProvider with ChangeNotifier {
  Map<String, List<ShowMessagesModel>> messageShow = {};
  List<ShowMessagesModel> allMessage = [];
  List<ShowMessagesModel> unreadMessage = [];
  List<ShowMessagesModel> sentMessage = [];
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
          if (message.type == 'userMessage') {
            id = message.subjectId!;
          } else {
            id = message.sId!;
          }
          print('**********************IDS*****************************');
          print(message.sId);
          messageShow.putIfAbsent(id, () => []).add(message);
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

  Future<void> getUnreadMessages(context, page, limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      unreadMessage = [];
      await DioClient.get(
          path: '/messages/unread',
          query: {'page': page, 'limit': limit}).then((value) {
        print(value.data['data']);
        value.data['data'].forEach((element) {
          final message = ShowMessagesModel.fromJson(element);
          unreadMessage.add(message);
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

  Future<void> getSentMessages(context, page, limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      sentMessage = [];
      await DioClient.get(
          path: '/messages/sent',
          query: {'page': page, 'limit': limit}).then((value) {
        print(value.data['data']);
        value.data['data'].forEach((element) {
          final message = ShowMessagesModel.fromJson(element);
          print('**********************IDS*****************************');
          print(message.sId);
          sentMessage.add(message);
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

  Future<void> getMessages(context, page, limit) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      allMessage = [];
      await DioClient.get(
          path: '/messages/all',
          query: {'page': page, 'limit': limit}).then((value) {
        print(value.data['data']);
        value.data['data'].forEach((element) {
          final message = ShowMessagesModel.fromJson(element);

          allMessage.add(message);
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

  Future<void> deleteMessage(context, messageId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(messageId);

      DioClient.delete(path: '/messages/$messageId');
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }

  Future<void> markAllAsRead(context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      DioClient.patch(path: '/messages/mark_as_read');
    } on DioError catch (e) {
      HandleError.errorHandler(e, context);
      //return false;
    } catch (error) {
      HandleError.handleError(error.toString(), context);
      //return false;
    }
  }
}
