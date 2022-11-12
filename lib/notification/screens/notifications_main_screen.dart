import 'package:flutter/material.dart';
import '../../create_community/widgets/bar_widget.dart';
import './navigate_to_correct_screen.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/three_dots_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class NotificationsMainScreen extends StatelessWidget {
  NotificationsMainScreen(
      {super.key,
      required this.changeNumOfNotification,
      required this.usersAllNotificatiion});
  final List<Map> usersAllNotificatiion;
  Function? changeNumOfNotification;

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
                  Flexible(
                    child: SingleChildScrollView(
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ListTile(
                              onTap: () =>
                                  _navigateToCorrectScreen(index, context),
                              tileColor: (usersAllNotificatiion[index]['seen'])
                                  ? Colors.lightBlue[50]
                                  : Colors.white,
                              leading: Container(
                                padding: const EdgeInsets.only(top: 4),
                                width: 40,
                                child: Stack(children: const [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/images/img.jpg'),
                                      radius: 17,
                                    ),
                                  ),
                                  Positioned(
                                    left: 20,
                                    top: 20,
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(
                                          'assets/images/upvote.png'),
                                      radius: 9,
                                    ),
                                  ),
                                ]),
                              ),
                              title: Row(
                                children: [
                                  Text(usersAllNotificatiion[index]['type']),
                                  Text(
                                    ' .${usersAllNotificatiion[index]['createdAt']}',
                                    style: const TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  )
                                ],
                              ),
                              subtitle: Text(
                                usersAllNotificatiion[index]['postId'],
                                // maxLines: 1,
                              ),
                              trailing: (usersAllNotificatiion[index]['type'] !=
                                      'userMention')
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
                                        if (usersAllNotificatiion[index]
                                                ['type'] ==
                                            'community')
                                          ListTileWidget(
                                              icon: Icons.cancel_outlined,
                                              title:
                                                  'Disable updates from this community'),
                                        SizedBox(
                                          height: 5.h,
                                          child: ElevatedButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            style: ElevatedButton.styleFrom(
                                              shape: const StadiumBorder(),
                                              onPrimary: Colors.grey[200],
                                              // backgroundColor: Colors.grey[200],
                                            ),
                                            child: const Text(
                                              'Close',
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                          ),
                                        )
                                      ],
                                      height: (usersAllNotificatiion[index]
                                                  ['type'] ==
                                              'community')
                                          ? 31
                                          : 25)
                                  : null);
                        },
                        itemCount: usersAllNotificatiion.length,
                      ),
                    ),
                  )
                ]),
          );
  }
}
