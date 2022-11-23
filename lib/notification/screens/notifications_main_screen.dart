import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:responsive_sizer/responsive_sizer.dart';

import '../constants/types_of_notification.dart';
import '../../create_community/widgets/bar_widget.dart';
import '../widgets/notification_text.dart';
import '../widgets/reply_back.dart';
import './navigate_to_correct_screen.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/three_dots_widget.dart';
import '../widgets/notification_image.dart';

class NotificationsMainScreen extends StatelessWidget {
  NotificationsMainScreen(
      {super.key,
      required this.changeNumOfNotification,
      required this.usersAllNotificatiion});
  final List<Map> usersAllNotificatiion;
  Function? changeNumOfNotification;
  String dropDownValue = '';
  List<String> list = [
    'Hide this notification',
    'Disable updates from this community'
  ];

  _navigateToCorrectScreen(index, context) {
    Navigator.of(context).pushNamed(NavigateToCorrectScreen.routeName);
  }

  String getTimeOfNotification(date) {
    String howOld;
    final difference = DateTime.now().difference(DateTime.parse(date));
    print(DateTime.parse(date));
    if (difference.inDays >= 30) {
      howOld = '${DateTime.parse(date).month}';
    } else if (difference.inDays >= 1) {
      howOld = '${difference.inDays}d';
    } else if (difference.inMinutes >= 60) {
      howOld = '${difference.inHours}h';
    } else if (difference.inSeconds >= 60) {
      howOld = '${difference.inMinutes}m';
    } else {
      howOld = 'Now';
    }
    return howOld;
  }

  @override
  Widget build(BuildContext context) {
    return (usersAllNotificatiion.isEmpty)
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
                      child: notificationBody(),
                    ),
                  ),
                if (kIsWeb) notificationBody(),
              ]);
  }

  ListView notificationBody() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            GestureDetector(
              onTap: () => _navigateToCorrectScreen(index, context),
              child: Container(
                color: (!usersAllNotificatiion[index]['seen'])
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
                              'r/Hunter',
                              'u/Basma',
                              usersAllNotificatiion[index]['postId'],
                              usersAllNotificatiion[index]['type'],
                              getTimeOfNotification(usersAllNotificatiion[index]
                                      ['createdAt']
                                  .toString()),
                              NotificationImage(
                                  usersAllNotificatiion: typeOfNotification[
                                      usersAllNotificatiion[index]['type']]!),
                            )!,
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
                              //only in community notifications this option is shown
                              if (usersAllNotificatiion[index]['type'] ==
                                  'community')
                                ListTileWidget(
                                    icon: Icons.cancel_outlined,
                                    title:
                                        'Disable updates from this community'),
                              SizedBox(
                                height: 5.h,
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
                            height: (usersAllNotificatiion[index]['type'] ==
                                    'community')
                                ? 31
                                : 25)
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
                                if (usersAllNotificatiion[index]['type'] ==
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
      itemCount: usersAllNotificatiion.length,
    );
  }
}

Widget? notificationMain(me, user, description, type, time, Widget image) {
  if (type == 'firstCommentUpVote' || type == 'firstPostUpVote') {
    return Row(
      children: [
        image,
        SizedBox(
          width: 2.w,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/up-arrow.png',
                  width: (kIsWeb) ? 1.w : 3.w,
                ),
                const Text(
                  '1st upvote!',
                  style: TextStyle(fontSize: 13, color: Colors.black),
                  maxLines: 2,
                ),
                SizedBox(
                  width: 2.w,
                ),
                const Icon(
                  Icons.circle,
                  color: Colors.grey,
                  size: 4,
                ),
                SizedBox(
                  width: 1.w,
                ),
                Text(
                  time,
                  style: const TextStyle(color: Colors.grey, fontSize: 10),
                )
              ],
            ),
            SizedBox(
              width: (kIsWeb) ? 20.w : 76.w,
              child: Text(description,
                  maxLines: 2,
                  softWrap: false,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 10)),
            ),
          ],
        ),
      ],
    );
  } else if (type == 'userMention') {
    return NotificationText(
      description: description,
      text: '$user mentioned you in $me',
      time: time,
      image: image,
    );
  } else if (type == 'follow') {
    return NotificationText(
        description: description,
        text: 'New follower!',
        time: time,
        image: image);
  } else if (type == 'postReply') {
    return NotificationText(
        description: description,
        text: '$user replied to your post in  $me',
        time: time,
        image: image);
  } else if (type == 'commentReply') {
    return Column(
      children: [
        NotificationText(
          description: description,
          text: '$user replied to your comment in  $me',
          time: time,
          image: image,
          button: const ReplyBack(),
          index: 1,
        ),
        // const ReplyBack(),
      ],
    );
  }
  return null;
}
