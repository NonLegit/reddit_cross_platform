import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class ModNotificationScreen extends StatelessWidget {
   static const routeName = '/ModNotification';
  const ModNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communitymod'),
        
      ),
      body:Center(child: Text('Communitymod'),
    )
    ); 
  }
}