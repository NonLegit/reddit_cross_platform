import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/createpost/model/subreddits_of_user.dart';

import '../screens/finalpost.dart';

class SubredditContainer extends StatelessWidget {
 // const SubredditContainer({Key? key}) : super(key: key);
 String nameOfSubreddit="";
 String iconOfSubreddit='';
 int memberCount=0;
 SubredditContainer(
  {
    required this.nameOfSubreddit,
    required this.iconOfSubreddit,
    required this.memberCount,
     }
     );
  @override
  Widget build(BuildContext context) {
   return ListTile(
     leading: CircleAvatar(radius: 22,backgroundColor: Colors.blue,
     backgroundImage: NetworkImage(
       "$iconOfSubreddit"
     ),
     ),
     title: Text("${nameOfSubreddit}"),
     subtitle: Text("$memberCount "+"members . "+"subscribed"),
     onTap: ()
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>finalPostScreen()));

     },
   );
  }
}
