import 'package:flutter/material.dart';
import 'package:post/home/screens/home_layout.dart';
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

import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import 'create_community/screens/create_community.dart';
import './moderation_settings/screens/topics_screen.dart';
import './screens/home.dart';
import './moderation_settings/screens/moderator_tools_screen.dart';
import './notification/screens/notifications_screen.dart';
import './notification/screens/navigate_to_correct_screen.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import './logins/screens/gender.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/gestures.dart';

import 'package:url_launcher/url_launcher.dart';

import 'icons/redditIcons.dart';
import 'icons/GoogleFacebookIcons.dart';

import 'logins/screens/login.dart';
import 'logins/screens/signup.dart';
import 'logins/screens/forgot_password.dart';
import 'logins/screens/forgot_username.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './screens/emptyscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Text('hello world'),
    //  );
    final ThemeData theme = ThemeData();

    // final forgot_sucess = '/users/forgot_password/204';
    // final forgot_failed = '/users/forgot_password/400';
    // final tempUrl = Uri.parse(
    //     'https://a6da66ef-18c0-4c77-bb40-45ec54bd706d.mock.pstmn.io' +
    //         forgot_failed);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ResponsiveSizer(
      builder: (cntx, orientation, Screentype) {
        Device.deviceType == DeviceType.web;
        return MaterialApp(
          title: 'Logins',
          theme: theme.copyWith(
            primaryColor: Colors.red,
            brightness: Brightness.light,
            colorScheme: theme.colorScheme.copyWith(
                primary: Colors.white,
                onPrimary: Colors.black,
                secondary: Colors.grey,
                surface: Colors.black87,
                onSurface: Colors.white),
          ),
          //home: homeLayoutScreen(),
          home: HomeScreen(),
          // home: Login(),
          routes: {
            EmptyScreen.routeName: (context) => EmptyScreen(),
            ForgotPassword.routeName: (context) => ForgotPassword(),
            ForgotUserName.routeName: (context) => ForgotUserName(),
            SignUp.routeName: (context) => SignUp(),
            Gender.routeName: (context) => Gender(),
            Login.routeName: (context) => Login(),
            CreateCommunity.routeName: (ctx) => CreateCommunity(),
            ModeratorTools.routeName: (context) => ModeratorTools(),
            TopicsScreen.routeName: (context) => TopicsScreen(),
            NotificationScreen.routeName: (context) => NotificationScreen(),
            NavigateToCorrectScreen.routeName: (context) =>
                NavigateToCorrectScreen(),
            MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
            OthersProfileScreen.routeName: (ctx) => OthersProfileScreen(),
            EditProfileScreen.routeName: (context) => EditProfileScreen(),
            UserFollowersScreen.routeName: (context) => UserFollowersScreen(),
            SubredditScreen.routeName: (context) => SubredditScreen(),
            SubredditSearchScreen.routeName: (context) =>
                SubredditSearchScreen(),
            ContactModMessageScreen.routeName: (context) =>
                ContactModMessageScreen(),
            CommunityInfoScreen.routeName: (context) => CommunityInfoScreen(),
            ModNotificationScreen.routeName: (context) =>
                ModNotificationScreen(),
            ModeratedSubredditScreen.routeName: (context) =>
                ModeratedSubredditScreen(),
            // LoginPage.routeName: (context) => LoginPage(),
          },
        );
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return ResponsiveSizer(
//       builder: (context, orientation, deviceType) {
//         return ResponsiveSizer(
//           builder: (p0, p1, p2) {
//             return MaterialApp(
//               theme: ThemeData(
//                   textTheme: const TextTheme(
//                     bodyText1: TextStyle(
//                       fontWeight: FontWeight.w100,
//                     ),
//                     bodyText2: TextStyle(
//                       fontWeight: FontWeight.w200,
//                     ),
//                     headline3: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black,
//                       fontSize: 18,
//                     ),
//                   ),
//                   appBarTheme: const AppBarTheme(
//                       iconTheme: IconThemeData(color: Colors.black)),
//                   fontFamily: 'Verdana'),
//               home: const Home(),
//               routes: {
//                 CreateCommunity.routeName: (ctx) => CreateCommunity(),
//                 ModeratorTools.routeName: (context) => ModeratorTools(),
//                 TopicsScreen.routeName: (context) => TopicsScreen(),
//                 Post.routeName: (context) => Post(),
//                 NotificationScreen.routeName: (context) => NotificationScreen(),
//                 NavigateToCorrectScreen.routeName: (context) =>
//                     NavigateToCorrectScreen(),
//                 LoginPage.routeName: (context) => LoginPage(),
//               },
//             );
//           },
//         );
//       },
//     );
//   }
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     //all widget will rebuild
//     return MultiProvider(
//         providers: [
//           ChangeNotifierProvider(create: (context) => MyProfileProvider()),
//         ],
//         child: Consumer<MyProfileProvider>(
//           builder: (context, auth, child) =>
//               ResponsiveSizer(builder: (context, orientation, screenType) {
//             return MaterialApp(
//               title: 'Reddit',
//               theme: ThemeData(
// //for one single color and shade not available
//                 // primaryColor:
//                 // one single color but
//                 // generates different shades of that color automatically
//                 // primarySwatch: Colors.purple,
//                 // //foreground color for widgets
//                 // accentColor: Colors.amber,
//                 // errorColor: Colors.red,
//                 // buttonColor: Colors.white,
//                 fontFamily: "Verdana",
//                 textTheme: ThemeData.light().textTheme.copyWith(
//                     headline6: const TextStyle(
//                         fontFamily: 'Verdana',
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white)),
//                 appBarTheme: const AppBarTheme(
//                     titleTextStyle: TextStyle(
//                         fontFamily: 'Verdana',
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold)),
//               ),
//               home: const HomeScreen(),
//               routes: {
//                 // '/': (ctx) => CategoriesScreen(),
//                 MyProfileScreen.routeName: (ctx) => MyProfileScreen(),
//                 OthersProfileScreen.routeName: (ctx) => OthersProfileScreen(),
//                 EditProfileScreen.routeName: (context) => EditProfileScreen(),
//                 UserFollowersScreen.routeName: (context) =>
//                     UserFollowersScreen(),
//                 SubredditScreen.routeName: (context) => SubredditScreen(),
//                 SubredditSearchScreen.routeName: (context) =>
//                     SubredditSearchScreen(),
//                 ContactModMessageScreen.routeName: (context) =>
//                     ContactModMessageScreen(),
//                 CommunityInfoScreen.routeName: (context) =>
//                     CommunityInfoScreen(),
//                 ModNotificationScreen.routeName: (context) =>
//                     ModNotificationScreen(),
//                 ModeratedSubredditScreen.routeName: (context) =>
//                     ModeratedSubredditScreen(),
//               },
//             );
//           }),
//         ));
//   }
// }

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

// class MyAppHome extends StatelessWidget {
//   // const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: homeLayoutScreen(),
//     );
//   }
// }

// class MyAppPost extends StatelessWidget {
//   // const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     final ThemeData theme = ThemeData();
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: theme.copyWith(
//         brightness: Brightness.dark,
//         colorScheme: theme.colorScheme.copyWith(
//             primary: Colors.white,
//             onPrimary: Colors.black,
//             secondary: Colors.grey,
//             surface: Colors.black87,
//             onSurface: Colors.white),
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Post'),
//           // elevation: 0,
//         ),
//         body: Post.home(data: {}),
//       ),
//     );
//   }
// }
