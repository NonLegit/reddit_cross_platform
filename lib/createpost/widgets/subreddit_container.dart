import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/finalpost.dart';

class subredditContainer extends StatelessWidget {
  const subredditContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return ListTile(
     leading: CircleAvatar(radius: 22,backgroundColor: Colors.blue,),
     title: Text("r/"+"Name of subreddits"),
     subtitle: Text("12 "+"members . "+"subscribed"),
     onTap: ()
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>finalPostScreen()));

     },
   );
  }
}
