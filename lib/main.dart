import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:dartdoc/dartdoc.dart';
import './screens/home_screen.dart';
import 'myprofile/screens/myprofile_screen.dart';
import 'other_profile/screens/others_profile_screen.dart';
import 'myprofile/screens/edit_profile_screen.dart';
import 'myprofile/screens/user_followers_screen.dart';
import 'subreddit/screens/subreddit_screen.dart';
import 'screens/subreddit_search_screen.dart';
import 'subreddit/screens/community_info_screen.dart';
import 'screens/contact_mod_message_screen.dart';
import 'other_profile/providers/other_profile_provider.dart';
import 'myprofile/providers/myprofile_provider.dart';
import 'moderated_subreddit/screens/mod_notification_screen.dart';
import 'moderated_subreddit/screens/moderated_subreddit_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //all widget will rebuild
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MyProfileProvider()),
        ],
        child: Consumer<MyProfileProvider>(
          builder: (context, auth, child) =>
              ResponsiveSizer(builder: (context, orientation, screenType) {
        return MaterialApp(
              title: 'Reddit',
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
                        color: Colors.white)),
                appBarTheme: const AppBarTheme(
                    titleTextStyle: TextStyle(
                        fontFamily: 'Verdana',
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
              ),
              home: const HomeScreen(),
              routes: {
                // '/': (ctx) => CategoriesScreen(),
                MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
                OthersProfileScreen.routeName: (ctx) => OthersProfileScreen(),
                EditProfileScreen.routeName: (context) => EditProfileScreen(),
                UserFollowersScreen.routeName: (context) =>UserFollowersScreen(),
                SubredditScreen.routeName:(context) => SubredditScreen(),
                SubredditSearchScreen.routeName:(context) => SubredditSearchScreen(),
                ContactModMessageScreen.routeName:(context) => ContactModMessageScreen(),
                CommunityInfoScreen .routeName:(context) => CommunityInfoScreen (),
                ModNotificationScreen.routeName:(context) => ModNotificationScreen(),
                ModeratedSubredditScreen.routeName:(context) => ModeratedSubredditScreen(),
              },
            );
          }),
        ));
  }
}

class _MyHomeApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
      ),
      body: const Center(
        child: Text('Let\'s build a shop!'),
      ),
    );
  }
}


// class MyApp extends StatefulWidget {
//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(builder: (context, orientation, screenType) {
//       return MaterialApp(
//        theme: ThemeData(
// //for one single color and shade not available
//           // primaryColor:
//           // one single color but
//           // generates different shades of that color automatically
//           // primarySwatch: Colors.purple,
//           // //foreground color for widgets
//           // accentColor: Colors.amber,
//           // errorColor: Colors.red,
//           // buttonColor: Colors.white,
//           fontFamily: "Verdana",
//           textTheme: ThemeData.light().textTheme.copyWith(
//                   headline6: const TextStyle(
//                 fontFamily: 'Verdana',
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white
//               )),
//           appBarTheme: const AppBarTheme(
//               titleTextStyle: TextStyle(
//                   fontFamily: 'Verdana',
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold)),
//         ),
//         title: 'Reddit',
//         home: const HomeScreen(),
//         // initialRoute: '/',
//         routes: {
//           // '/': (ctx) => CategoriesScreen(),
//           MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
//           OthersProfileScreen.routeName: (ctx) => OthersProfileScreen(),
//           EditProfileScreen.routeName:(context) => EditProfileScreen(),
//           UserFollowersScreen.routeName:(context) => UserFollowersScreen()
//         },
//       );
//     });
//   }
// }
