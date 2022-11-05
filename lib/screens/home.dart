import 'package:flutter/material.dart';
import 'package:sw_code/screens/create_community.dart';
import 'package:sw_code/screens/moderator_tools_screen.dart';
//import 'package:sw_code/screens/create_community.dart';
//import 'package:sw_code/screens/moderator_tools_screen.dart';
//import 'package:sw_code/screens/topics_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Center(
          child: OutlinedButton(
            child: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(CreateCommunity.routeName),
          ),
        ),
      ),
    );
  }
}
