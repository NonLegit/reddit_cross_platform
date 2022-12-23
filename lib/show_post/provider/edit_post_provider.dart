import 'package:flutter/material.dart';
import 'package:post/networks/dio_client.dart';

class EditPostProvider with ChangeNotifier{

 void editPostAction(postId,action){
 // http://localhost:8000/api/v1/posts/{postId}/actions/{action}
  DioClient.patch(path: '/posts/$postId/actions/$action');
  notifyListeners();
 }

 void editPost(Map <String,dynamic> data,postId){
  //http://localhost:8000/api/v1/posts/{postId}
  DioClient.patch(path: '/posts/$postId',data: data);
  notifyListeners();
 }

  
}