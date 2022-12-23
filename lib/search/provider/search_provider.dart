import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../networks/dio_client.dart';
import '../../networks/const_endpoint_data.dart';
import '../models/search_community.dart';
import '../models/search_people.dart';
import '../models/search_post.dart';
import '../models/search_comment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/handle_error.dart';

class SearchProvider with ChangeNotifier {
  bool initPost = true;
  bool initComments = true;
  bool initCommunity = true;
  bool initPeople = true;
  SearchCommunity? searchCommunity = SearchCommunity.fromJson({"data": []});
  SearchPeople? searchPeople = SearchPeople.fromJson({"data": []});
  SearchPost? searhPost = SearchPost.fromJson({"data": []});
  SearchComment? searhComment = SearchComment.fromJson({"data": []});
  bool isError = false;
  String errorMessage = '';
  Future<void> getsearch(
      {String quiry = '',
      String type = 'posts',
      required BuildContext context,
      String sort = 'new',
      String time = 'day',
      int page = 1,
      int limit = 10,
      bool withPage = false}) async {
    if (!withPage &&
        ((type == 'posts' && (initPost == false)) ||
            (type == 'communities' && (initCommunity == false)) ||
            (type == 'people' && (initPeople == false)) ||
            (type == 'comments' && (initComments == false)))) {
      return;
    }
    try {
      String path = '/search';
      path = path +
          '?q=$quiry&type=$type&sort=$sort&time=$time&page=$page&limit=$limit';
      final prefs = await SharedPreferences.getInstance();
      DioClient.init(prefs);
      print(path);
      // sort=$sort&time=$time&page=$page&limit=$limit

      await DioClient.get(path: path, query: {}).then((response) {
        print(response);
        isError = !(response.statusCode! < 310);
        if (isError == false) {
          if (type == 'communities') {
            ///
            searchCommunity!.data?.addAll(
                SearchCommunity.fromJson(response.data).data
                    as List<CommunityData>);
            initCommunity = false;
          } else if (type == 'people') {
            searchPeople!.data
              ?..addAll(SearchPeople.fromJson(response.data).data
                  as List<PeopleData>);
            initPeople = false;
          } else if (type == 'posts') {
            searhPost!.data
              ?..addAll(
                  SearchPost.fromJson(response.data).data as List<PostData>);
            initPost = false;
          } else if (type == 'comments') {
            searhComment!.data
              ?..addAll(SearchComment.fromJson(response.data).data
                  as List<CommentData>);
            initComments = false;
          }
        }
      });
      notifyListeners();
    } on DioError catch (e) {
      print('erro');
      isError = true;
      errorMessage = e.message;
      // HandleError.errorHandler(e, context);
    } catch (error) {
      print('erro2');
      isError = true;
      errorMessage = error.toString();
      // HandleError.handleError(error.toString(), context);
    }
  }

  Future<void> joinDisjoinSubreddit(int index, BuildContext context) async {
    if (searchCommunity!.data != null &&
        index < searchCommunity!.data!.length) {
      try {
        String action = '';
        if (searchCommunity!.data?[index].isJoined == true) {
          action = 'unsub';
        } else {
          action = 'sub';
        }
        String path =
            '/subreddits/${searchCommunity!.data?[index].fixedName}/subscribe';
        final prefs = await SharedPreferences.getInstance();
        DioClient.init(prefs);
        print(path);
        await DioClient.post(path: path, data: {}, query: {'action': action})
            .then((response) {
          print('suze');
          isError = !(response.statusCode! < 310);
          if (isError == false) {
            print(response.data.runtimeType);
            print(response.data);
            searchCommunity!.data?[index].isJoined =
                (searchCommunity!.data?[index].isJoined == false);
          }
        });
        notifyListeners();
      } on DioError catch (e) {
        searchCommunity!.data?[index].isJoined =
            (searchCommunity!.data?[index].isJoined == false);
        isError = false;
        print('erro');
        isError = true;
        errorMessage = e.message;
        HandleError.errorHandler(e, context);
      } catch (error) {
        print('erro2');
        isError = true;
        errorMessage = error.toString();
        HandleError.handleError(error.toString(), context);
      }
    }
  }

  Future<void> followUnfollow(int index, BuildContext context) async {
    try {
      // String path = '/search/$quiry/posts';
      // final prefs = await SharedPreferences.getInstance();
      // DioClient.init(prefs);
      // print(path);
      // await DioClient.post(
      //   path: path,
      // data:{},
      // ).then((response) {
      //   print('suze');
      //   isError = !(response.statusCode! < 310);
      //   if (isError == false) {
      //     print(response.data.runtimeType);
      //     print(response.data);
      //     // errorMessage = json.decode(response.data)['errorMessage'];
      //   }
      // });
      notifyListeners();
    } on DioError catch (e) {
      print('erro');
      isError = true;
      errorMessage = e.message;
      // HandleError.errorHandler(e, context);
    } catch (error) {
      print('erro2');
      isError = true;
      errorMessage = error.toString();
      // HandleError.handleError(error.toString(), context);
    }
  }
}
