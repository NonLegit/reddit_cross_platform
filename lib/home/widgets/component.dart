import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../icons/icon_broken.dart';

void navigateTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));
var currentIndex = 0;
List<BottomNavigationBarItem> buttNavBar() {

    List<BottomNavigationBarItem>v= [
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
  return v;
}
