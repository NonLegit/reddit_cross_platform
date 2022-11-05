import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import './screens/home_screen.dart';
import './screens/myprofile_screen.dart';
import './screens/others_profile_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/user_followers_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, orientation, screenType) {
      return MaterialApp(
       theme: ThemeData(
//for one single color and shade not available
          // primaryColor:
          // one single color but
          // generates different shades of that color automatically
          // primarySwatch: Colors.purple,
          // //foreground color for widgets
          // accentColor: Colors.amber,
          // errorColor: Colors.red,
          // buttonColor: Colors.white,
          fontFamily: "Verdana",
          textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: const TextStyle(
                fontFamily: 'Verdana',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white
              )),
          appBarTheme: const AppBarTheme(
              titleTextStyle: TextStyle(
                  fontFamily: 'Verdana',
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
        ),
        title: 'Reddit',
        home: const HomeScreen(),
        // initialRoute: '/',
        routes: {
          // '/': (ctx) => CategoriesScreen(),
          MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
          OthersProfileScreen.routeName: (ctx) => OthersProfileScreen(),
          EditProfileScreen.routeName:(context) => EditProfileScreen(),
          UserFollowersScreen.routeName:(context) => UserFollowersScreen()
        },
      );
    });
  }
}
