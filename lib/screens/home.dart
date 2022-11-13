import 'package:flutter/material.dart';
import '../create_community/screens/create_community.dart';
import '../moderation_settings/screens/moderator_tools_screen.dart';
import '../notification/screens/notifications_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.zero,
        child: Center(
          child: OutlinedButton(
            child: Icon(Icons.add),
            onPressed: () =>
                // Navigator.of(context).pushNamed(CreateCommunity.routeName),
                //  Navigator.of(context).pushNamed(ModeratorTools.routeName),
                Navigator.of(context).pushNamed(NotificationScreen.routeName),
          ),
        ),
      ),
    );
  }
}
