import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class ContactModMessageScreen extends StatelessWidget {
   static const routeName = '/communitymodmessage';
  const ContactModMessageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Communitymodmessage'),
        
      ),
      body:Center(child: Text('Communitymodmessage'),
    )
    ); 
  }
}