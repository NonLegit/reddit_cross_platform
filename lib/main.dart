import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sw_code/screens/create_community.dart';
import 'package:sw_code/screens/topics_screen.dart';
import './screens/home.dart';
import './screens/moderator_tools_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
          },
        );
      },
    );
  }
}
