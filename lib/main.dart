import 'dart:convert';

// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/create_community/widgets/community_type.dart';
import 'package:post/moderation_settings/models/moderators.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:post/providers/profile_post.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import './home/screens/home_layout.dart';
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
import 'package:post/home/screens/home_layout.dart';
import 'logins/providers/notification.dart';
import 'myprofile/screens/myprofile_screen.dart';
import 'notification/models/notification_class_model.dart';
import 'other_profile/screens/others_profile_screen.dart';
import 'myprofile/screens/edit_profile_screen.dart';
import 'myprofile/screens/user_followers_screen.dart';
import 'show_post/screens/show_post.dart';
import 'show_post/widgets/edit_post.dart';
import 'post/provider/post_provider.dart';
import 'providers/subreddit_post.dart';
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
import 'create_community/screens/create_community.dart';
import 'logins/screens/login.dart';
import 'logins/screens/signup.dart';
import 'logins/screens/forgot_password.dart';
import 'logins/screens/forgot_username.dart';
import './settings/screens/choose_country.dart';
import './settings/screens/change_email.dart';
import './settings/screens/change_password.dart';
import './settings/screens/change_email.dart';
import './settings/screens/change_password.dart';
import 'moderation_settings/screens/description_screen.dart';
import 'moderation_settings/screens/post_types_screen.dart';
import 'moderation_settings/screens/community_type_screen.dart';
import 'moderation_settings/screens/location_screen.dart';
import './messages/screens/new_message_screen.dart';
import 'moderation_settings/screens/moderators_screen.dart';
import 'moderation_settings/screens/banned_user_sceen.dart';
import 'moderation_settings/screens/muted_user_screen.dart';
import 'moderation_settings/screens/approved_users_screen.dart';
import 'moderation_settings/screens/add_edit_banned_screen.dart';
import 'moderation_settings/screens/add_edit_moderator_screen.dart';
import 'moderation_settings/screens/add_edit_muted_screen.dart';
import 'moderation_settings/screens/add_edit_aproved_screen.dart';
//=====================================Providers====================================================//
import './myprofile/providers/myprofile_provider.dart';
import './other_profile/providers/other_profile_provider.dart';
import './subreddit/providers/subreddit_provider.dart';
import './moderated_subreddit/providers/moderated_subreddit_provider.dart';
import './create_community/provider/create_community_provider.dart';
import './moderation_settings/provider/moderation_settings_provider.dart';
import './notification/provider/notification_provider.dart';
import 'logins/providers/authentication.dart';
import './notification/provider/push_notification.dart';

String returnCorrectText(type, name, user) {
  String text = '';
  if (type == 'userMention') {
    text = '$user mentioned you in $name';
  } else if (type == 'follow') {
    text = 'New follower!';
  } else if (type == 'postReply') {
    text = '$user replied to your post in $name';
  } else if (type == 'commentReply') {
    text = '$user replied to your comment in $name';
  } else if (type == 'firstCommentUpVote' || type == 'firstPostUpVote') {
    text = '⬆️ 1\'st upvote';
  }
  return text;
}

String returnCorrectDescription(type, description, name) {
  String description1 = '';
  if (type == 'firstCommentUpVote') {
    description1 = 'Go see your post on $name : $description';
  } else if (type == 'firstPostUpVote') {
    description1 = 'Go see your comments on $name : $description';
  } else if (type == 'follow') {
    description1 = '$name followed you.Follow them back';
  } else {
    description1 = description;
  }
  return description1;
}

//@pragma('vm:entry-point')
NotificationModel notificationModel = NotificationModel();
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // print('hidojsljfkbgdvdbhnjkjhgvfcvgbdsfghgfdfffghjhdfrghhnjmk');
//   await Firebase.initializeApp();
//   await FirebaseMessaging.instance.getToken();
//   //print('hidojsljfkbgdvdbhnjkjhgvfcvgbhnjmk');
//   await setupFlutterNotifications();
//   print('Handling a background message ${message.messageId}');
//   RemoteNotification? notification = message.notification;
//   notificationModel =
//       NotificationModel.fromJson(json.decode(message.data['val']));
//   flutterLocalNotificationsPlugin.show(
//       notification.hashCode,
//       returnCorrectText(notificationModel.type, notificationModel.requiredName,
//           notificationModel.followeruserName),
//       //notificationModel.type,
//       //notificationModel.description,

//       returnCorrectDescription(notificationModel.type,
//           notificationModel.description, notificationModel.requiredName),
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         channelDescription: channel.description,
//         color: Colors.blue,
//         playSound: true,
//         // icon: ('assets/images/reddit.png'),
//       )));
// }

// bool isFlutterLocalNotificationsInitialized = false;
// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// AndroidNotificationChannel channel = const AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   description:
//       'This channel is used for important notifications.', // description
//   importance: Importance.high,
// );

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     print('settings doneeeeeeeeeee');
//     return;
//   }
//   print('Print the channel $channel');
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(channel);
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   isFlutterLocalNotificationsInitialized = true;
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  final prefs = await SharedPreferences.getInstance();
  await prefs.setInt('counter', 10);
  final int? cont = prefs.getInt('counter');
  // await Firebase.initializeApp();
  // await NotificationToken.getTokenOfNotification();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  @override
  // void initState() {
  //   //AndroidNotificationChannel channel;
  //   // TODO: implement initState
  //   super.initState();
  //   var initializationSettingsAndroid =
  //       AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var initializationSettings =
  //       InitializationSettings(android: initializationSettingsAndroid);
  //   flutterLocalNotificationsPlugin.initialize(initializationSettings);
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     print(message.data);
  //     RemoteNotification? notification = message.notification;
  //     AndroidNotification? android = message.notification?.android;
  //     print(notification.hashCode);
  //     if (message.data != null) {
  //       print(message.data['val']);
  //       notificationModel =
  //           NotificationModel.fromJson(json.decode(message.data['val']));
  //       print('hiiiiiiiiiiiiiiiiiiiiiiiiiiiii');
  //       print(channel.id);
  //       print(channel.name);
  //       print(channel.description);
  //       print(message.data['val']);

  //       flutterLocalNotificationsPlugin.show(
  //           notification.hashCode,
  //           returnCorrectText(
  //               notificationModel.type,
  //               notificationModel.requiredName,
  //               notificationModel.followeruserName),
  //           //notificationModel.type,
  //           //notificationModel.description,
  //           returnCorrectDescription(notificationModel.type,
  //               notificationModel.description, notificationModel.requiredName),
  //           NotificationDetails(
  //               android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channelDescription: channel.description,
  //             color: Colors.blue,
  //             playSound: true,
  //             //     icon: ('assets/images/reddit.png'),
  //           )));
  //     }
  //   });
  //   onOpeningMessage(context) {
  //     FirebaseMessaging.onMessageOpenedApp.listen(
  //       (RemoteMessage message) async {
  //         print('BYEEEEEEEEEEEEEEEEEEEEEEE');
  //         print(message.data);
  //         RemoteNotification? notification = message.notification;
  //         AndroidNotification? android = message.notification?.android;
  //         if (message.data != null) {
  //           Navigator.of(context)
  //               .popAndPushNamed(NavigateToCorrectScreen.routeName);
  //         }
  //       },
  //     );
  //   }
  //   //push.onMessageListener();
  //   // push.onOpeningMessage(context);
  // }

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
            ChangeNotifierProvider.value(value: ProfilePostProvider()),
            ChangeNotifierProvider.value(value: PostProvider()),
            ChangeNotifierProvider.value(value: SubredditPostProvider()),
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
            // home: homeLayoutScreen(),
            // home: Description(),
            // home: HomeScreen(),
            // home: NotificationScreen(),
            // home:ShowPostDetails(),
            // home: CreateCommunity(),
            //   home: homeLayoutScreen(),
            // home: HomeScreen(),
            // home: Login(),
            // home: CreateCommunity(),
            // home: Login(),
            // home: ForgotUserName(),
            // home: SignUp(),
            // home: Gender(),
            // home: ModeratorTools(),
            // home: Settings(),
            // home: ChangeEmail(),
            // home: ComuunityTypesScreen(),
            // home: LocationScreen(),
            // home: ModeratorsScreen(),
            // home: BannedScreen(),
            // home: MutedScreen(),
            // home: ApprovedScreen(),
            routes: {
              EditApprovedScreen.routeName: (context) => EditApprovedScreen(),
              EditBannedScreen.routeName: (context) => EditBannedScreen(),
              EditMutedScreen.routeName: (context) => EditMutedScreen(),
              EditModeratorScreen.routeName: (context) => EditModeratorScreen(),
              ModeratorsScreen.routeName: (context) => ModeratorsScreen(),
              ModeratorsScreen.routeName: (context) => ModeratorsScreen(),
              ComuunityTypesScreen.routeName: (context) =>
                  ComuunityTypesScreen(),
              LocationScreen.routeName: (context) => LocationScreen(),
              PostTypesScreen.routeName: (context) => PostTypesScreen(),
              Description.routeName: (context) => Description(),
              NewMessageScreen.routeName: (context) => NewMessageScreen(),
              EditPost.routeName: (context) => EditPost(),
              ShowPostDetails.routeName: (context) => ShowPostDetails(),
              ChangeEmail.routeName: (context) => ChangeEmail(),
              ChangePassword.routeName: (context) => ChangePassword(),
              ChooseCountry.routeName: (context) => ChooseCountry(),
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

// class _MyHomeApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: const Center(
//         child: Text('Let\'s build a shop!'),
//       ),
//     );
//   }
// }
