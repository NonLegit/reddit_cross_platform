import 'package:flutter/material.dart';
import 'package:post/notification/provider/notification_provider.dart';

import 'package:post/notification/screens/messages_main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';

import './home/screens/home_layout.dart';
import './screens/home_screen.dart';
import './moderation_settings/provider/moderation_settings_provider.dart';
import './myprofile/screens/myprofile_screen.dart';
import './other_profile/screens/others_profile_screen.dart';
import './myprofile/screens/edit_profile_screen.dart';
import './myprofile/screens/user_followers_screen.dart';
import './subreddit/screens/subreddit_screen.dart';
import './screens/subreddit_search_screen.dart';
import './subreddit/screens/community_info_screen.dart';
import './screens/contact_mod_message_screen.dart';
import './other_profile/providers/other_profile_provider.dart';
import './myprofile/providers/myprofile_provider.dart';
import './moderated_subreddit/screens/mod_notification_screen.dart';
import './moderated_subreddit/screens/moderated_subreddit_screen.dart';
import './create_community/provider/create_community_provider.dart';
import './create_community/screens/create_community.dart';
import './moderation_settings/screens/topics_screen.dart';
import './moderation_settings/screens/moderator_tools_screen.dart';
import './notification/screens/notifications_screen.dart';
import './notification/screens/navigate_to_correct_screen.dart';
import './logins/screens/gender.dart';
import './logins/screens/login.dart';
import './logins/screens/signup.dart';
import './logins/screens/forgot_password.dart';
import './logins/screens/forgot_username.dart';
import './screens/emptyscreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return ResponsiveSizer(
      builder: (cntx, orientation, Screentype) {
        Device.deviceType == DeviceType.web;
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: CreateCommunityProvider()),
            ChangeNotifierProvider.value(value: ModerationSettingProvider()),
            ChangeNotifierProvider.value(value: NotificationProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
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
             home: homeLayoutScreen(),
           
            routes: {
              homeLayoutScreen.routeName: (context) => homeLayoutScreen(),
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
              MessagesMainScreen.routeName: (context) => MessagesMainScreen(),
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
          ),
        );
      },
    );
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
