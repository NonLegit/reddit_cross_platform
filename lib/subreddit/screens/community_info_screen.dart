import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class CommunityInfoScreen extends StatelessWidget {
   static const routeName = '/communityinfo';
  const CommunityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CommunityInfoScreen'),
        
      ),
      body:Center(child: Text('CommunityInfoScreen'),
    )
    ); 
  }
}