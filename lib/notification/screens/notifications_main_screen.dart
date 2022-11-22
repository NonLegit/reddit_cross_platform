// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:post/notification/constants/types_of_notification.dart';
import '../../create_community/widgets/bar_widget.dart';
import './navigate_to_correct_screen.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/three_dots_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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
        : Container(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!kIsWeb)
                    Flexible(
                      child: SingleChildScrollView(
                        child: NotificationBody(),
                      ),
                    ),
                  if (kIsWeb) NotificationBody(),
                ]),
          );
  }

  ListView NotificationBody() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
                onTap: () => _navigateToCorrectScreen(index, context),
                tileColor: (!usersAllNotificatiion[index]['seen'])
                    ? Colors.lightBlue[50]
                    : Colors.white,
                leading: Container(
                  padding: const EdgeInsets.only(top: 4),
                  width: 40,
                  child: Stack(children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/img.jpg'),
                        radius: 17,
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 20,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          //minRadius: 2,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage(TypeOfNotification[
                              usersAllNotificatiion[index]['type']]!),
                          radius: 7,
                        ),
                        radius: 10,
                      ),
                    ),
                  ]),
                ),
                title: Row(
                  children: [
                    Text(usersAllNotificatiion[index]['type']),
                    Text(
                      ' .${usersAllNotificatiion[index]['createdAt']}',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  ],
                ),
                subtitle: Text(
                  usersAllNotificatiion[index]['postId'],
                  // maxLines: 1,
                ),
                //according to the type of notifications the options is shown or not shown
                trailing: (usersAllNotificatiion[index]['type'] !=
                        'userMention')
                    ? (!kIsWeb)
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
                          )
                    : null),
            if (kIsWeb) const Divider(),
          ],
        );
      },
      itemCount: usersAllNotificatiion.length,
    );
  }
}
