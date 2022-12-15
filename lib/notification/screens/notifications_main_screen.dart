import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/types_of_notification.dart';
import '../../create_community/widgets/bar_widget.dart';
import '../models/notification_class_model.dart';
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
      required this.usersAllNotificatiion});
  final List<NotificationModel> usersAllNotificatiion;
  Function? changeNumOfNotification;

  @override
  State<NotificationsMainScreen> createState() => _NotificationsMainScreenState();
}

class _NotificationsMainScreenState extends State<NotificationsMainScreen> {
  String dropDownValue = '';

  List<String> list = [
    'Hide this notification',
    //'Disable updates from this community'
  ];

  _navigateToCorrectScreen(index, context) {
    Navigator.of(context).pushNamed(NavigateToCorrectScreen.routeName);
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
    //print(DateTime.parse(date));
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

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final width = queryData.size.width;
    return (widget.usersAllNotificatiion.isEmpty)
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
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
                if (!kIsWeb)
                  Flexible(
                    child: SingleChildScrollView(
                      child: notificationBody(height, width),
                    ),
                  ),
                if (kIsWeb) notificationBody(height, width),
              ]);
  }

  // Widget return the main body of each notification
  ListView notificationBody(height, width) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => _navigateToCorrectScreen(index, context),
              child: Container(
                color: (!widget.usersAllNotificatiion[index].seen!)
                    ? Colors.lightBlue[50]
                    : Colors.white,
                // width: double.infinity,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            notificationMain(
                                returnCorrectText(
                                  widget.usersAllNotificatiion[index].type,
                                  widget.usersAllNotificatiion[index].requiredName,
                                  widget.usersAllNotificatiion[index].followeruserName,
                                ),
                                returnCorrectDescription(
                                    widget.usersAllNotificatiion[index].type,
                                    widget.usersAllNotificatiion[index].description,
                                    widget.usersAllNotificatiion[index].requiredName),
                                widget.usersAllNotificatiion[index].type,
                                getTimeOfNotification(
                                    widget.usersAllNotificatiion[index].createdAt),
                                NotificationImage(
                                    usersAllNotificatiion: typeOfNotification[
                                        widget.usersAllNotificatiion[index].type]!,
                                    userPhoto: widget.usersAllNotificatiion[index]
                                        .followerIcon!,
                                    height: height,
                                    width: width),
                                width)!,
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
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
                                  title: 'Hide this notification'),
                              // //only in community notifications this option is shown
                              // if (usersAllNotificatiion[index]['type'] ==
                              //     'community')
                              //   ListTileWidget(
                              //       icon: Icons.cancel_outlined,
                              //       title:
                              //           'Disable updates from this community'),
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
                            // height: (usersAllNotificatiion[index]['type'] ==
                            //         'community')
                            //     ? 31
                            //     :
                            height: height * 0.025)
                        : PopupMenuButton(
                            // elevation: -1,
                            position: PopupMenuPosition.under,
                            icon: const Icon(Icons.more_horiz),
                            itemBuilder: (context) {
                              //return list.map((e) {
                              return [
                                PopupMenuItem(
                                    child: Text(
                                  list[0],
                                  style: const TextStyle(fontSize: 12),
                                )),
                                if (widget.usersAllNotificatiion[index].type ==
                                    'community')
                                  PopupMenuItem(
                                      child: Text(
                                    list[1],
                                    style: const TextStyle(fontSize: 12),
                                  )),
                              ];
                            },
                          ),
                    if (kIsWeb) const Divider(),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      itemCount: widget.usersAllNotificatiion.length,
    );
  }
}
//used to return widget of each type of notification
//Input : description of notification , type of notification, time of notification,Image of notification

//Notification Text : To build the header and the description body of notification
//Reply back : Button reply back that appears to reply on a comment
Widget? notificationMain(text, description, type, time, Widget image, width) {
  print(description);
  if (type == 'commentReply') {
    return Column(
      children: [
        NotificationText(
          description: description,
          text: text,
          time: time,
          image: image,
          button: const ReplyBack(),
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
