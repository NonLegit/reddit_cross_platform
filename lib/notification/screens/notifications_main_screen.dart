import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../constants/types_of_notification.dart';
import '../../create_community/widgets/bar_widget.dart';
import '../models/notification_class_model.dart';
import '../provider/notification_provider.dart';
import '../widgets/notification_text.dart';
import '../widgets/reply_back.dart';
import './navigate_to_correct_screen.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/three_dots_widget.dart';
import '../widgets/notification_image.dart';

class NotificationsMainScreen extends StatefulWidget {
  NotificationsMainScreen(
      {super.key,
      required this.changeNumOfNotification,
      required this.usersNotificationToday,
      required this.usersNotificationEarlier});
  final List<NotificationModel> usersNotificationToday;
  final List<NotificationModel> usersNotificationEarlier;
  Function? changeNumOfNotification;

  @override
  State<NotificationsMainScreen> createState() =>
      _NotificationsMainScreenState();
}

class _NotificationsMainScreenState extends State<NotificationsMainScreen> {
  String dropDownValue = '';

  List<String> list = [
    'Hide this notification',
  ];

  _markAsRead(NotificationModel index, context) async {
    if (!index.seen!) {
      setState(() {
        index.seen = true;
      });
      await Provider.of<NotificationProvider>(context, listen: false)
          .markAndHideThisNotification(context, index.sId, 'mark_as_read', 1)
          .then((value) {
        setState(() {});
      });
    }
  }

  _navigateToCorrectScreen(NotificationModel index, context, i) {
    _markAsRead(index, context);
    if (i == 0) {
      if (index.type == 'follow') {
        //Navigate to user profile

        Navigator.popAndPushNamed(context, OthersProfileScreen.routeName,
            arguments:
                index.requiredName!.substring(2, index.requiredName!.length));
      } else {
        Navigator.of(context).pushNamed(NavigateToCorrectScreen.routeName);
      }
    }
  }

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

//return time in terms of month or week or day or seconds
  String getTimeOfNotification(date) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(date));
    if (difference.inDays >= 30) {
      howOld = DateFormat.MMMMd().format(DateTime.parse(date));
    } else if (difference.inDays >= 1) {
      howOld = '${difference.inDays}d';
    } else if (difference.inMinutes >= 60) {
      howOld = '${DateFormat.j().format(DateTime.parse(date))}h';
    } else if (difference.inSeconds >= 60) {
      howOld = '${DateFormat.m().format(DateTime.parse(date))}min';
    } else {
      howOld = '${DateFormat.s()..format(DateTime.parse(date))}sec';
    }

    return howOld;
  }

  _hideThisNotification(notificationId, i) async {
    print('Hide notification');
    await Provider.of<NotificationProvider>(context, listen: false)
        .markAndHideThisNotification(context, notificationId, 'hide', i)
        .then((value) {
      setState(() {});
    });
  }

  hideThisNotification(notificationId, i) {
    _hideThisNotification(notificationId, i);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final width = queryData.size.width;
    return (widget.usersNotificationEarlier.isEmpty &&
            widget.usersNotificationToday.isEmpty)
        ? Container(
            color: Colors.grey[100],
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/emptyNotification.png'),
                Text(
                  'Wow,such empty',
                  style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 13,
                      fontWeight: FontWeight.w300),
                ),
              ],
            )),
          )
        : Container(
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.01,
                  ),
                  if (!kIsWeb)
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (!widget.usersNotificationToday.isEmpty)
                                const Text('    Today',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              if (!widget.usersNotificationToday.isEmpty)
                                notificationBody(height, width,
                                    widget.usersNotificationToday, 0),
                              if (!widget.usersNotificationEarlier.isEmpty)
                                SizedBox(
                                  height: height * 0.02,
                                  child: const Text(
                                    '    Earlier',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              if (!widget.usersNotificationEarlier.isEmpty)
                                notificationBody(height, width,
                                    widget.usersNotificationEarlier, 1),
                            ]),
                      ),
                    ),
                  if (kIsWeb)
                    if (!widget.usersNotificationToday.isEmpty)
                      const Text('    Today',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                  if (kIsWeb)
                    if (!widget.usersNotificationToday.isEmpty)
                      notificationBody(
                          height, width, widget.usersNotificationToday, 0),
                  if (kIsWeb)
                    if (!widget.usersNotificationEarlier.isEmpty)
                      SizedBox(
                        height: height * 0.02,
                        child: const Text(
                          '    Earlier',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                  if (kIsWeb)
                    if (!widget.usersNotificationEarlier.isEmpty)
                      notificationBody(
                          height, width, widget.usersNotificationEarlier, 1),
                ]),
          );
  }

  // Widget return the main body of each notification
  ListView notificationBody(height, width, usersAllNotificatiion, i) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => _navigateToCorrectScreen(
                  usersAllNotificatiion[index], context, 0),
              child: Container(
                color: (!usersAllNotificatiion[index].seen!)
                    ? Colors.lightBlue[50]
                    : Colors.white,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: notificationMain(
                                    returnCorrectText(
                                      usersAllNotificatiion[index].type,
                                      usersAllNotificatiion[index].requiredName,
                                      usersAllNotificatiion[index]
                                          .followeruserName,
                                    ),
                                    returnCorrectDescription(
                                        usersAllNotificatiion[index].type,
                                        usersAllNotificatiion[index]
                                            .description,
                                        usersAllNotificatiion[index]
                                            .followeruserName),
                                    usersAllNotificatiion[index].type,
                                    getTimeOfNotification(
                                        usersAllNotificatiion[index].createdAt),
                                    NotificationImage(
                                        usersAllNotificatiion:
                                            typeOfNotification[
                                                usersAllNotificatiion[index]
                                                    .type]!,
                                        userPhoto: usersAllNotificatiion[index]
                                            .followerIcon!,
                                        height: height,
                                        width: width),
                                    width,
                                    usersAllNotificatiion[index].commentId,
                                    usersAllNotificatiion[index].postId)!,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    if (!kIsWeb) Spacer(),
                    //:
                    (!kIsWeb)
                        ? ThreeDotsWidget(
                            optional: const BarWidget(),
                            listOfWidgets: [
                              const Divider(
                                color: Colors.transparent,
                              ),
                              const Text(
                                'Manage Notification',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              const Divider(),
                              ListTileWidget(
                                icon: Icons.visibility_off_outlined,
                                title: 'Hide this notification',
                                onpressed: () => hideThisNotification(
                                    usersAllNotificatiion[index].sId, i),
                              ),
                              SizedBox(
                                height: height * 0.05,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  style: ElevatedButton.styleFrom(
                                    shape: const StadiumBorder(),
                                    onPrimary: Colors.grey[200],
                                  ),
                                  child: const Text(
                                    'Close',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                            ],
                            height: height * 0.025)
                        : PopupMenuButton(
                            position: PopupMenuPosition.under,
                            icon: const Icon(Icons.more_horiz),
                            onSelected: (value) => hideThisNotification(
                                usersAllNotificatiion[index].sId, i),
                            itemBuilder: (context) {
                              //return list.map((e) {
                              return [
                                PopupMenuItem(
                                    child: Text(
                                  list[0],
                                  style: const TextStyle(fontSize: 12),
                                )),
                              ];
                            },
                          ),
                  ],
                ),
              ),
            ),
            if (kIsWeb) Divider(color: Colors.grey.shade100),
          ],
        );
      },
      itemCount: usersAllNotificatiion.length,
    );
  }
}
//used to return widget of each type of notification
//Input : description of notification , type of notification, time of notification,Image of notification

//Notification Text : To build the header and the description body of notification
//Reply back : Button reply back that appears to reply on a comment
Widget? notificationMain(
    text, description, type, time, Widget image, width, commentId, postId) {
  if (type == 'commentReply') {
    return Column(
      children: [
        NotificationText(
          description: description,
          text: text,
          time: time,
          image: image,
          button: ReplyBack(commentId: commentId, postId: postId),
          index: 1,
          width: width,
        ),
      ],
    );
  } else {
    return NotificationText(
      description: description,
      text: text,
      time: time,
      image: image,
      width: width,
    );
  }
}
