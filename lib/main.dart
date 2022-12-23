import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/comments/providers/comments_provider.dart';
import 'package:post/create_community/widgets/community_type.dart';
import 'package:post/messages/screens/reply_message_screen.dart';
import 'package:post/messages/screens/show_message_body.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import './messages/screens/web_message_all_screen.dart';
import './messages/screens/web_message_screen.dart';
import 'package:post/providers/global_settings.dart';
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
import 'logins/providers/notification.dart';
import 'messages/provider/message_provider.dart';
import 'messages/models/user_message.dart';
import 'messages/screens/new_message_screen.dart';
import 'messages/screens/unread_message_screen.dart';
import 'messages/screens/web_new_message_screen.dart';
import 'messages/screens/web_sent_message.dart';
import 'notification/models/notification_class_model.dart';
import 'show_post/screens/show_post.dart';
import 'show_post/widgets/edit_post.dart';
import 'post/provider/post_provider.dart';
import './settings/screens/settings.dart';
import './settings/screens/account_settings.dart';
import './settings/screens/blocked_accounts.dart';
import './settings/screens/choose_country.dart';
import './settings/screens/change_email.dart';
import './settings/screens/change_password.dart';
import 'moderation_settings/screens/description_screen.dart';
import 'moderation_settings/screens/post_types_screen.dart';
import 'moderation_settings/screens/community_type_screen.dart';
import 'moderation_settings/screens/location_screen.dart';
import 'messages/screens/message_main_screen.dart';
import 'moderation_settings/screens/moderators_screen.dart';
import 'moderation_settings/screens/banned_user_sceen.dart';
import 'moderation_settings/screens/muted_user_screen.dart';
import 'moderation_settings/screens/approved_users_screen.dart';
import 'moderation_settings/screens/add_edit_banned_screen.dart';
import 'moderation_settings/screens/add_edit_moderator_screen.dart';
import 'moderation_settings/screens/add_edit_muted_screen.dart';
import 'moderation_settings/screens/add_edit_aproved_screen.dart';
import 'moderation_settings/screens/add_edit_post_flair.dart';
import 'moderation_settings/screens/post_flair.dart';
import 'moderation_settings/screens/post_flair_settings.dart';
import './search/screens/search.dart';
import './search/screens/search_inside.dart';
import './moderation_settings/screens/traffic_state.dart';
import './moderation_settings/screens/traffic_table.dart';
//=====================================Providers====================================================//
import './myprofile/providers/myprofile_provider.dart';
import './other_profile/providers/other_profile_provider.dart';
import 'providers/profile_provider.dart';
import 'providers/subreddit_posts_provider.dart';
import './subreddit/providers/subreddit_provider.dart';
import './moderated_subreddit/providers/moderated_subreddit_provider.dart';
import './create_community/provider/create_community_provider.dart';
import './moderation_settings/provider/moderation_settings_provider.dart';
import './notification/provider/notification_provider.dart';
import 'logins/providers/authentication.dart';
import 'moderation_settings/provider/post_flair_provider.dart';
import './moderation_settings/provider/change_user_management.dart';
import './settings/provider/user_settings_provider.dart';
import './search/provider/search_provider.dart';
import './discover/providers/discover_provider.dart';
import './moderation_settings/provider/moderation_general_data.dart';
import './show_post/screens/show_post_web.dart';
import 'widgets/custom_snack_bar.dart';
//import './models/push_notification_model.dart';
import './shared/constants.dart';

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

String returnText(type) {
  String text = '';
  if (type == 'subredditBan') {
    text = 'You have been banned from participating ';
  } else if (type == 'subredditMute') {
    text = 'You have been muted ';
  } else if (type == 'subredditModeratorInvite') {
    text = 'Invitation to moderate ';
  } else if (type == 'subredditModeratorRemove') {
    text = 'You have been removed as moderator';
  } else if (type == 'subredditApprove') {
    text = 'You are an approved user';
  }
  return text;
}

String returnBody(type) {
  String body = '';
  if (type == 'subredditBan') {
    body =
        'You have been banned from participating .You can still view and subscribe,but you won\'t be able to post or comment.If you have a question regarding your ban,you can contact moderator theam .';
  } else if (type == 'subredditMute') {
    body =
        'You have been muted . You will not be able to message the moderators  for 3 days';
  } else if (type == 'subredditModeratorInvite') {
    body =
        'You are invited to become a moderator \n to accept,visit the moderators page  .Otherwise if you did not expect to recieve this,you can simply ignore this invitation or report it. ';
  } else if (type == 'subredditModeratorRemove') {
    body =
        'You: You have been removed as a moderator .If you have a question regarding your removal,tou can contact moderator ';
  } else if (type == 'subredditApprove') {
    body = 'You have been added as an approved user';
  }
  return body;
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
// NotificationModel notificationModel = NotificationModel();
// NotificationProvider provider = NotificationProvider();
// ShowMessagesModel messageModel = ShowMessagesModel();
// final GlobalKey<NavigatorState> navState = GlobalKey<NavigatorState>();
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   await FirebaseMessaging.instance.getToken();
//   await setupFlutterNotifications();
//   RemoteNotification? notification = message.notification;
//   if (json.decode(message.data['val'])['type'] == 'userMention' ||
//       json.decode(message.data['val'])['type'] == 'follow' ||
//       json.decode(message.data['val'])['type'] == 'postReply' ||
//       json.decode(message.data['val'])['type'] == 'commentReply') {
//     notificationModel =
//         NotificationModel.fromJson(json.decode(message.data['val']));
//     //provider.incrementCounter();
//     flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         returnCorrectText(notificationModel.type,
//             notificationModel.requiredName, notificationModel.followeruserName),
//         returnCorrectDescription(notificationModel.type,
//             notificationModel.description, notificationModel.requiredName),
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           color: Colors.blue,
//           playSound: true,
//           // icon: ('assets/images/reddit.png'),
//         )));
//   } else {
//     final json1 = json.decode(message.data['val']);
//     String text = (json1['subject'] == null)
//         ? returnText(json1['type'])
//         : json1['subject']['text'];
//     String body =
//         (json1['text'] == null) ? returnBody(json1['type']) : json1['text'];
//     flutterLocalNotificationsPlugin.show(
//         notification.hashCode,
//         text,
//         body,
//         NotificationDetails(
//             android: AndroidNotificationDetails(
//           channel.id,
//           channel.name,
//           channelDescription: channel.description,
//           color: Colors.blue,
//           playSound: true,
//           // icon: ('assets/images/reddit.png'),
//         )));
//   }
// }

bool isFlutterLocalNotificationsInitialized = false;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
);

// Future<void> setupFlutterNotifications() async {
//   if (isFlutterLocalNotificationsInitialized) {
//     print('settings doneeeeeeeeeee');
//     return;
//   }
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
  await prefs.setInt('not', 0);
  provider.initState();
  //if(!kIsWeb){
  //await Firebase.initializeApp();
  //await NotificationToken.getTokenOfNotification();
  // final RemoteMessage? remoteMessage =
  //   await FirebaseMessaging.instance.getInitialMessage();
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  //FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }
  //}
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: Constants.apiKey,
          appId: Constants.appId,
          messagingSenderId: Constants.messagingSenderId,
          projectId: Constants.projectId));
  await NotificationToken.getTokenOfNotification();
  runApp(
    ChangeNotifierProvider<GlobalSettings>(
      create: (context) => GlobalSettings(true, true),
      child: MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int counter = 0;
  @override
  void initState() {
    //AndroidNotificationChannel channel;
    super.initState();
    var initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (message.data != null) {
        print(message.data['val']);
        if (json.decode(message.data['val'])['type'] == 'userMention' ||
            json.decode(message.data['val'])['type'] == 'follow' ||
            json.decode(message.data['val'])['type'] == 'postReply' ||
            json.decode(message.data['val'])['type'] == 'commentReply') {
          notificationModel =
              NotificationModel.fromJson(json.decode(message.data['val']));
          if (!kIsWeb) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                returnCorrectText(
                    notificationModel.type,
                    notificationModel.requiredName,
                    notificationModel.followeruserName),
                returnCorrectDescription(
                    notificationModel.type,
                    notificationModel.description,
                    notificationModel.requiredName),
                NotificationDetails(
                    android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                )));
          } else {
            print('nameeeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
            showDialog<bool>(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text(
                    'New notification arrived',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: 40.h,
                    child: Text(
                      returnCorrectText(
                          notificationModel.type,
                          notificationModel.requiredName,
                          notificationModel.followeruserName),
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                );
              }),
            );
            print(notificationModel.requiredName);
          }
        } else {
          final json1 = json.decode(message.data['val']);
          String text = (json1['subject'] == null)
              ? returnText(json1['type'])
              : json1['subject']['text'];
          print(text);
          String body = (json1['text'] == null)
              ? returnBody(json1['type'])
              : json1['text'];
          print(body);
          if (!kIsWeb) {
            flutterLocalNotificationsPlugin.show(
                notification.hashCode,
                text,
                body,
                NotificationDetails(
                    android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  color: Colors.blue,
                  playSound: true,
                  // icon: ('assets/images/reddit.png'),
                )));
          } else {
            showDialog<bool>(
              context: context,
              builder: ((context) {
                return AlertDialog(
                  title: const Text(
                    'New notification arrived',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  insetPadding: EdgeInsets.zero,
                  content: SizedBox(
                    width: 40.h,
                    child: Text(
                      text,
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  actionsAlignment: MainAxisAlignment.spaceBetween,
                );
              }),
            );
          }
        }
        // FirebaseMessaging.onMessageOpenedApp.listen(
        //   (RemoteMessage message) async {
        //     print('BYEEEEEEEEEEEEEEEEEEEEEEE');
        //     print(message.data);
        //     RemoteNotification? notification = message.notification;
        //     AndroidNotification? android = message.notification?.android;
        //     if (message.data['val'] != null) {
        //       print('heereeeeeeeeeeeeee');
        //       Navigator.of(navState.currentState!.context)
        //           .pushNamed(NavigateToCorrectScreen.routeName);
        //     }
        //   },
        // );
      }
    });
    // initializationSettingsAndroid =
    //     AndroidInitializationSettings('@mipmap/ic_launcher');
    // initializationSettings =
    //     InitializationSettings(android: initializationSettingsAndroid);
    // flutterLocalNotificationsPlugin.initialize(initializationSettings);
    // FirebaseMessaging.instance.getInitialMessage();
    // FirebaseMessaging.onMessageOpenedApp.listen(
    //   (RemoteMessage message) async {
    //     print('BYEEEEEEEEEEEEEEEEEEEEEEE');
    //     print(message.data);
    //     RemoteNotification? notification = message.notification;
    //     AndroidNotification? android = message.notification?.android;
    //     if (message.data['val'] != null) {
    //       print('heereeeeeeeeeeeeee');
    //       Navigator.of(navState.currentState!.context)
    //           .pushNamed(NavigateToCorrectScreen.routeName);
    //     }
    //   },
    // );
  }
  //push.onMessageListener();
  // push.onOpeningMessage(context);

  @override
  Widget build(BuildContext context) {
    // Auth().logOut(context);
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
            /////////// the only line we need to show post and commets frauture with multi level ///////////
            ChangeNotifierProvider.value(value: PostCommentsProvider()),
            /////////////////////////////////////////////////////////////////
            /////////////////////////////////////////////////////////////////
            ChangeNotifierProvider.value(
                value: ModerationGeneralDataProvider()),
            ChangeNotifierProvider.value(value: SearchProvider()),
            ChangeNotifierProvider.value(value: UserSettingsProvider()),
            ChangeNotifierProvider.value(value: ChangeUserManagementProvider()),
            ChangeNotifierProvider.value(value: MyProfileProvider()),
            ChangeNotifierProvider.value(value: OtherProfileprovider()),
            ChangeNotifierProvider.value(value: SubredditProvider()),
            ChangeNotifierProvider.value(value: ModeratedSubredditProvider()),
            ChangeNotifierProvider.value(value: CreateCommunityProvider()),
            ChangeNotifierProvider.value(value: ModerationSettingProvider()),
            ChangeNotifierProvider.value(value: NotificationProvider()),
            ChangeNotifierProvider.value(value: Auth()),
            // ChangeNotifierProvider.value(value: ProfileCommentsProvider()),
            ChangeNotifierProvider.value(value: PostProvider()),
            // ChangeNotifierProvider.value(value: SubredditPostProvider()),
            ChangeNotifierProvider.value(value: PostFlairProvider()),
            ChangeNotifierProvider.value(value: MessageProvider()),
            //  ChangeNotifierProvider.value(value: ProfilePostProvider()),
            ChangeNotifierProvider.value(value: PostProvider()),
            ChangeNotifierProvider.value(value: SubredditPostsProvider()),
            // ChangeNotifierProvider.value(value: ProfileCommentsProvider()),
            ChangeNotifierProvider.value(value: ProfileProvider()),
            ChangeNotifierProvider.value(value: DiscoverProvider()),
          ],
          child: GetMaterialApp(
            debugShowCheckedModeBanner: false,
            // navigatorKey: navState,
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
            // home: NotificationScreen(),
            //   home: HomeLayoutScreen(),
            // home: Description(),
            // home: HomeScreen(),
            // home: NotificationScreen(),
            // home:ShowPostDetails(),
            //home: CreateCommunity(),
            //home: NewMessageScreen(),
            // home: EditPost(),
            //  home: SearchInside(quiry: 'mohab'),
            //home: const DiscoverScreen(),
            // home: homeLayoutScreen(),
            // home: Description(),
            // home: HomeScreen(),
            // home: MyProfileScreen(),
            // home: NotificationScreen(),
            // home:ShowPostDetails(),
            // home: CreateCommunity(),
            //home: homeLayoutScreen(),
            // home: HomeScreen(),
            home: Login(),
            // home: CreateCommunity(),
            // home: ForgotUserName(),
            // home: ForgotPassword(),
            // home: TraficState(),
            // home: TrafficTable(),
            // home: SignUp(),
            // home: Gender(),
            // home: ModeratorTools(),
            // home: Settings(),
            // home: ChangeEmail(),
            // home: ComuunityTypesScreen(),
            // home: LocationScreen(),
            // home: ModeratorsScreen(),
            // home: BannedScreen(),cd hi
            // home: ApprovedScreen(),
            // home: EditApprovedScreen(subredditName: 'Cooking'),
            // home:EditBannedScreen(),
            // home:EditMutedScreen(),
            // home: EditModeratorScreen(subredditName: 'Cooking'),
            // home: Search(),
            routes: {
              TraficState.routeName: (context) => TraficState(),
              AllMessageScreen.routeName: (context) => AllMessageScreen(),
              WebNewMessageScreen.routeName: (context) => WebNewMessageScreen(),
              SentMessage.routeName: (context) => SentMessage(),
              UnreadMessageScreen.routeName: (context) => UnreadMessageScreen(),
              ReplyMessageScreen.routeName: (context) => ReplyMessageScreen(),
              ShowMessageBody.routeName: (context) => ShowMessageBody(),
              MessageMainScreen.routeName: (context) => MessageMainScreen(),
              PostFlairSettings.routeName: (context) => PostFlairSettings(),
              AddAndEditPostFllair.routeName: (context) =>
                  AddAndEditPostFllair(),
              PostFlairModerator.routeName: (context) => PostFlairModerator(),

              Search.routeName: (context) => Search(),
              SearchInside.routeName: (context) => SearchInside(),
              MutedScreen.routeName: (context) => MutedScreen(),
              WebMessageScreen.routeName: (context) => WebMessageScreen(),
              EditApprovedScreen.routeName: (context) =>
                  EditApprovedScreen(subredditName: ''),
              EditBannedScreen.routeName: (context) =>
                  EditBannedScreen(subredditName: ''),
              EditMutedScreen.routeName: (context) =>
                  EditMutedScreen(subredditName: ''),
              EditModeratorScreen.routeName: (context) =>
                  EditModeratorScreen(subredditName: ''),

              EditApprovedScreen.routeName: (context) =>
                  EditApprovedScreen(subredditName: ''),
              EditBannedScreen.routeName: (context) =>
                  EditBannedScreen(subredditName: ''),
              EditMutedScreen.routeName: (context) =>
                  EditMutedScreen(subredditName: ''),
              EditModeratorScreen.routeName: (context) =>
                  EditModeratorScreen(subredditName: ''),
              ModeratorsScreen.routeName: (context) => ModeratorsScreen(),
              MutedScreen.routeName: (context) => MutedScreen(),
              BannedScreen.routeName: (context) => BannedScreen(),
              ApprovedScreen.routeName: (context) => ApprovedScreen(),

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
              ChooseCountry.routeName: (context) =>
                  ChooseCountry(handler: () {}),
              BlockedAccounts.routeName: (context) => BlockedAccounts(),
              AccountSettings.routeName: (context) => AccountSettings(),
              Settings.routeName: (context) => Settings(),
              HomeLayoutScreen.routeName: (context) => HomeLayoutScreen(),
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
              ShowPostDetailsWeb.routeName: (context) => ShowPostDetailsWeb(),
              // LoginPage.routeName: (context) => LoginPage(),
            },
          ),
        );
      },
    );
  }
}
