import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart';

import '../widgets/list_tile_widget.dart';
import '../../networks/dio_client.dart';
import '../widgets/three_dots_widget.dart';
import './messages_main_screen.dart';
import './notifications_main_screen.dart';
import '../../networks/const_endpoint_data.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = '/notifications-screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  int unreadNotification = 0;
  bool returned = false;
  List<Map> usersAllNotificatiion = [];

  @override
  void initState() {
    // TODO: implement initState
    DioClient.init();

    super.initState();
  }

  @override
  void didChangeDependencies() async {
    await DioClient.get(path: notificationResults).then((value) {
      json.decode(value.data).forEach((value) {
        usersAllNotificatiion.add(HashMap.from(value));
      });
    });
    setState(() {
      returned = true;
    });

    super.didChangeDependencies();
  }

  _changeNumOfNotification(value) {
    setState(() {
      unreadNotification = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            ThreeDotsWidget(listOfWidgets: [
              ListTileWidget(icon: Icons.create_outlined, title: 'New message'),
              ListTileWidget(
                  icon: Icons.drafts_outlined,
                  title: 'Mark all inbox tabs as read')
            ], height: 14),
          ],
          backgroundColor: Colors.grey[50],
          titleSpacing: 0,
          elevation: 2,
          titleTextStyle: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          shadowColor: Colors.white,
          title: const Text('Inbox'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: TabBar(
              indicatorWeight: 3,
              indicatorColor: Colors.blue,
              indicatorSize: TabBarIndicatorSize.tab,
              labelPadding: const EdgeInsets.symmetric(horizontal: 60),
              isScrollable: true,
              labelStyle:
                  const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Badge(
                  toAnimate: false,
                  position: BadgePosition.topEnd(end: -10, top: -23),
                  shape: BadgeShape.circle,
                  borderRadius: BorderRadius.circular(4),
                  showBadge: unreadNotification != 0 ? true : false,
                  badgeContent: const Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      'Notifications',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(bottom: 6),
                  child: Text(
                    'Messages',
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          !returned
              ? Container(
                  color: Colors.grey[100],
                  child: Center(
                      child: Image.asset('assets/img/redditLoading.png')),
                )
              : NotificationsMainScreen(
                  usersAllNotificatiion: usersAllNotificatiion,
                  changeNumOfNotification: _changeNumOfNotification),
          const MessagesMainScreen(),
        ]),
      ),
    );
  }
}
