import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/createpost/screens/createpost.dart';
import 'package:post/moderation_settings/models/moderator_tools.dart';
import 'package:post/notification/screens/messages_main_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:dartdoc/dartdoc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './home/screens/home_layout.dart';
import './screens/home_screen.dart';
import './myprofile/screens/myprofile_screen.dart';
import './other_profile/screens/others_profile_screen.dart';
import './myprofile/screens/edit_profile_screen.dart';
import './myprofile/screens/user_followers_screen.dart';
import './subreddit/screens/subreddit_screen.dart';
import './screens/subreddit_search_screen.dart';
import './subreddit/screens/community_info_screen.dart';
import './screens/contact_mod_message_screen.dart';
import './moderated_subreddit/screens/mod_notification_screen.dart';
import './moderated_subreddit/screens/moderated_subreddit_screen.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:post/home/screens/home_layout.dart';
import 'package:post/networks/const_endpoint_data.dart';
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
import './settings/screens/settings.dart';
import './settings/screens/account_settings.dart';
import './settings/screens/blocked_accounts.dart';
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
import './icons/reddit_icons.dart';
import 'icons/google_facebook_icons.dart';
import 'logins/screens/login.dart';
import 'logins/screens/signup.dart';
import 'logins/screens/forgot_password.dart';
import 'logins/screens/forgot_username.dart';
import './screens/emptyscreen.dart';
//=====================================Providers====================================================//
import './myprofile/providers/myprofile_provider.dart';
import './other_profile/providers/other_profile_provider.dart';
import './subreddit/providers/subreddit_provider.dart';
import './moderated_subreddit/providers/moderated_subreddit_provider.dart';
import './create_community/provider/create_community_provider.dart';
import './moderation_settings/provider/moderation_settings_provider.dart';
import './notification/provider/notification_provider.dart';
import 'logins/providers/authentication.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', 10);
  final int? cont = prefs.getInt('counter');
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
            ChangeNotifierProvider.value(value: MyProfileProvider()),
            ChangeNotifierProvider.value(value: OtherProfileprovider()),
            ChangeNotifierProvider.value(value: SubredditProvider()),
            ChangeNotifierProvider.value(value: ModeratedSubredditProvider()),
            ChangeNotifierProvider.value(value: CreateCommunityProvider()),
            ChangeNotifierProvider.value(value: ModerationSettingProvider()),
            ChangeNotifierProvider.value(value: NotificationProvider()),
            ChangeNotifierProvider.value(value: Auth()),
          ],
          child: GetMaterialApp(
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

          //  home: homeLayoutScreen(),
            // home: CreateCommunity(),
            // home: HomeScreen(),
          //    home: Login(),
            // home: ForgotUserName(),
             home: SignUp(),
            // home: Gender(),
            // home: ModeratorTools(),
            // home: Settings(),
            routes: {
              BlockedAccounts.routeName: (context) => BlockedAccounts(),
              AccountSettings.routeName: (context) => AccountSettings(),
              Settings.routeName: (context) => Settings(),
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
