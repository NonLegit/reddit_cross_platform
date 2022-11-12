

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post/home/providers/cubit/states.dart';

import '../../../icons/icon_broken.dart';


class layoutCubit extends Cubit <layoutStates>
{


  layoutCubit() : super(layoutInitialState());
  static layoutCubit get(context)=>BlocProvider.of(context);
  Response? response;
  var dio = Dio();

  // for handling textform in create post


  //For buttom navigation bar
  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
      icon: IconButton(
        icon:Icon(IconBroken.Home,color: Colors.black),
        onPressed: (){},
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon:Icon(IconBroken.Discovery,color: Colors.black,),
        onPressed: (){},
      ),
      label: 'Discover',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        focusColor: Colors.black,
        icon:Icon(Icons.add,size: 30.0,color: Colors.black,),
        onPressed: (){},
      ),
      label: 'post',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        focusColor: Colors.black,
        icon:Icon(IconBroken.Chat,color: Colors.black),
        onPressed: (){},
      ),
      label: 'chat',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon:Icon(IconBroken.Notification,color: Colors.black),
        onPressed: (){},
      ),
      label: 'notifications',
    ),
  ];
  void changeButtomNavigationBar(int index)
  {
    currentIndex=index;
    emit(bottomNavBar());
  }
  // response = await dio.post('/test', data: {'id': 12, 'name':'wendu'});
  Future<void> submitpost({
    String? title,
    String? kind,
    String? text,
    String? URL,
    String? owner,
    String? ownerType,
    bool? nsfw,
  }) async {
    // response =await dio.get("https://303292b3-af7a-40a5-87b5-7ca0524741e0.mock.pstmn.io/posts/201");
    /* response = await dio.post('https://303292b3-af7a-40a5-87b5-7ca0524741e0.mock.pstmn.io/posts/201', data: {
      'title':title,
      'kind':kind,
      'text': text,
      'URL':URL,
      'owner':owner,
      'ownerType':ownerType,
      'nsfw':nsfw
    });*/
    print(response!.data);
    /*print("HEFKAEJFKHNASIHFBCIABSDOHWSFICBAIEfDDDDDDDDDDDDdhbaREHTBKwahnhrfhnwgkbtne");
    DioHelper.postData(url: submit,
        data: {
          'title':title,
          'kind':kind,
          'text': text,
          'URL':URL,
          'owner':owner,
          'ownerType':ownerType,
          'nsfw':nsfw
             }
    ).then((value)
    {
      print("HEFKAEJFKHNASIHFBCIABSDOHWSFICBAIEfDDDDDDDDDDDDdhbaREHTBKwahnhrfhnwgkbtne");
      print(value.data);
      emit(SocialCreatePostSuccessState());
    }
    ).catchError((error)
    {
      emit(SocialCreatePostErrorState());
    }
    );*/
  }
}