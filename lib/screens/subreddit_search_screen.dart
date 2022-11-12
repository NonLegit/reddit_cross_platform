import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
class SubredditSearchScreen extends StatelessWidget {
   static const routeName = '/subriddetsearch';
  const SubredditSearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubriddetSearchScreenn'),
        
      ),
      body:Center(child: Text('SubriddetSearchScreen'),
    )
    ); 
  }
}