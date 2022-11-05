import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class EditProfileScreen extends StatelessWidget {
    static const routeName = '/editprofile';
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: const Text('EditScreen'),
        
      ),
      body:Center(child:  Text('EditScreen'),
    )
    ); 
  }
}