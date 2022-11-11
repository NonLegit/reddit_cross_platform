import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sw_code/create_community/screens/login_screen.dart';

import 'create_community/screens/create_community.dart';
import 'create_community/screens/post.dart';
import './moderation_settings/screens/topics_screen.dart';
import './screens/home.dart';
import './moderation_settings/screens/moderator_tools_screen.dart';
import './notification/screens/notifications_screen.dart';
import './notification/screens/navigate_to_correct_screen.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        return ResponsiveSizer(
          builder: (p0, p1, p2) {
            return MaterialApp(
              theme: ThemeData(
                  textTheme: const TextTheme(
                    bodyText1: TextStyle(
                      fontWeight: FontWeight.w100,
                    ),
                    bodyText2: TextStyle(
                      fontWeight: FontWeight.w200,
                    ),
                    headline3: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                  appBarTheme: const AppBarTheme(
                      iconTheme: IconThemeData(color: Colors.black)),
                  fontFamily: 'Verdana'),
              home: const Home(),
              routes: {
                CreateCommunity.routeName: (ctx) => CreateCommunity(),
                ModeratorTools.routeName: (context) => ModeratorTools(),
                TopicsScreen.routeName: (context) => TopicsScreen(),
                Post.routeName: (context) => Post(),
                NotificationScreen.routeName: (context) => NotificationScreen(),
                NavigateToCorrectScreen.routeName: (context) =>
                    NavigateToCorrectScreen(),
                LoginPage.routeName: (context) => LoginPage(),
              },
            );
          },
        );
      },
    );
  }
}
