// import '../post/models/post_model.dart';

// import 'package:flutter/material.dart';
// import '../../networks/const_endpoint_data.dart';
// import '../../networks/dio_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// //using in heighest widget to use
// class SubredditPostProvider with ChangeNotifier {
//   List<PostModel>? data;

//   List<PostModel>? get gettingProfilePostData {
//     return data;
//   }

//   Future<void> fetchTopProfilePosts(String subredditName) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       DioClient.init(prefs);

//       await DioClient.get(path: '/subreddits/${subredditName}/top')
//           .then((response) {
//         print(response.data);
//         List<PostModel> tempData = [];
//         response.data['data'].forEach((post) {
//           tempData.add(PostModel.fromJson(post));
//         });
//         data = tempData;
//         notifyListeners();
//       });
//     } catch (error) {
//       print(error);
//       print('heelo');
//       throw (error);
//     }
//   }

//   Future<void> fetchNewProfilePosts(String subredditName) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       DioClient.init(prefs);

//       await DioClient.get(path: '/subreddits/${subredditName}/new')
//           .then((response) {
//         print(response.data);
//         List<PostModel> tempData = [];
//         response.data['data'].forEach((post) {
//           tempData.add(PostModel.fromJson(post));
//         });
//         data = tempData;
//         notifyListeners();
//       });
//     } catch (error) {
//       print(error);
//       print('heelo');
//       throw (error);
//     }
//   }

//   Future<void> fetchHotProfilePosts(String subredditName) async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       DioClient.init(prefs);

//       await DioClient.get(path: '/subreddits/${subredditName}/hot')
//           .then((response) {
//         print(response.data);
//         List<PostModel> tempData = [];
//         response.data['data'].forEach((post) {
//           tempData.add(PostModel.fromJson(post));
//         });
//         data = tempData;
//         notifyListeners();
//       });
//     } catch (error) {
//       print(error);
//       print('heelo');
//       throw (error);
//     }
//   }
// }
