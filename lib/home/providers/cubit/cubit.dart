import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './states.dart';
import '../../screens/home_layout.dart';
// import 'package:reddit/modules/home/home.dart';

import '../../../chat/chat.dart';
import '../../../createpost/screens/createpost.dart';
import '../../../discover/discover.dart';
import '../../../icons/icon_broken.dart';
import '../../../notification/screens/notifications_screen.dart';

class layoutCubit extends Cubit<layoutStates> {
  layoutCubit() : super(layoutInitialState());
  static layoutCubit get(context) => BlocProvider.of(context);
  //For buttom navigation bar
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
      icon: IconButton(
        icon: Icon(IconBroken.Home, color: Colors.black),
        onPressed: () {},
      ),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: Icon(
          IconBroken.Discovery,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      label: 'Discover',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        focusColor: Colors.black,
        icon: Icon(
          Icons.add,
          size: 30.0,
          color: Colors.black,
        ),
        onPressed: () {},
      ),
      label: 'post',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        focusColor: Colors.black,
        icon: Icon(IconBroken.Chat, color: Colors.black),
        onPressed: () {},
      ),
      label: 'chat',
    ),
    BottomNavigationBarItem(
      icon: IconButton(
        icon: Icon(IconBroken.Notification, color: Colors.black),
        onPressed: () {
          // Navigator.of(context).pushNamed(NotificationScreen.routeName);
        },
      ),
      label: 'notifications',
    ),
  ];
  void changeButtomNavigationBar(int index) {
    currentIndex = index;
    emit(bottomNavBar());
  }

  // For handling screesn
  List<Widget> screens = [
    homeLayoutScreen(),
    discoverScreen(),
   // createPostScreen(),
    chatScreen(),
    NotificationScreen(),
    // notificationsScreen(),
  ];
}
