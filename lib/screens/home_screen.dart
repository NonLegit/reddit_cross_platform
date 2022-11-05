import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import './myprofile_screen.dart';
import './others_profile_screen.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
         actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MyProfileScreen.routeName);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body:Center(child: Text('Myprofile'),)
    );
  }
}
