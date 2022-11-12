import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import '../myprofile/screens/myprofile_screen.dart';
import '../other_profile/screens/others_profile_screen.dart';
import '../subreddit/screens/subreddit_screen.dart';
import '../moderated_subreddit/screens/moderated_subreddit_screen.dart';

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
                  Navigator.of(context).pushNamed(
                   // MyProfileScreen.routeName
                     SubredditScreen.routeName
                     //ModeratedSubredditScreen.routeName
                    // OthersProfileScreen.routeName
                      ,
                      arguments: 'ZeinabMoawad');
                },
                icon: Icon(Icons.add))
          ],
        ),
        body: Center(
          child: Text('Myprofile'),
        ));
  }
}
