import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class UserFollowersScreen extends StatelessWidget {
   static const routeName = '/userfollowers';
  const UserFollowersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FollowersScreen'),
        
      ),
      body:Center(child: Text('FollowersScreen'),
    )
    ); 
  }
}