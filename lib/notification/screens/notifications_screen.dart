import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:get/get.dart';
import '../../messages/provider/message_provider.dart';
import '../../messages/screens/web_message_screen.dart';
import '../models/notification_class_model.dart';

import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../../home/widgets/drawer.dart';
import '../../home/widgets/end_drawer.dart';
import '../../home/widgets/buttom_nav_bar.dart';
import '../provider/notification_provider.dart';
import '../widgets/list_tile_widget.dart';
import '../widgets/three_dots_widget.dart';
import './notifications_main_screen.dart';
import '../../widgets/loading_reddit.dart';
import '../../messages/screens/message_main_screen.dart';
import '../../home/controller/home_controller.dart';
import '../../messages/screens/new_message_screen.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  static const routeName = '/notifications-screen';

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final HomeController controller = Get.put(
    HomeController(),
  );
  bool isRecentlyVisitedPannelExpanded = true;
  bool isModeratingPannelExpanded = false;
  bool isOnline = true;
  bool hover = false;
  bool markAsRead = false;
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }

  int unreadNotification = 0;
  bool returned = false;
  List<NotificationModel> usersNotificationEarlier = [];
  List<NotificationModel> usersNotificationToday = [];
  var currentIndex = 4;
  bool _isInit = true;

  @override
  void initState() {
    //  _updateCount();
    super.initState();
  }

  // _updateCount() {
  //   //final prefs = await SharedPreferences.getInstance();
  //   unreadNotification = Provider.of<NotificationProvider>(context).count!;
  //   print('In notifications          $unreadNotification');
  // }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        returned = false;
      });
      await Provider.of<NotificationProvider>(context, listen: false)
          .getNotification(context)
          .then((value) {
        usersNotificationToday =
            Provider.of<NotificationProvider>(context, listen: false).listToday;
        usersNotificationEarlier =
            Provider.of<NotificationProvider>(context, listen: false)
                .listEariler;
        setState(() {
          returned = true;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  _changeNumOfNotification(value) {
    setState(() {
      unreadNotification = value;
    });
  }


  //Call end point to mark notification as read 
  //return void
  _markAsRead() async {
    await Provider.of<NotificationProvider>(context, listen: false)
        .markAllAsRead(context);
  }
  //Call end point to mark all notification as read 
  //return void
  markAllAsRead() {
    _markAsRead();
    usersNotificationEarlier.forEach((element) {
      if (!element.seen!) {
        setState(() {
          element.seen = true;
        });
      }
    });
    usersNotificationToday.forEach((element) {
      if (!element.seen!) {
        setState(() {
          element.seen = true;
        });
      }
    });
    if (!kIsWeb) Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    final height = queryData.size.height;
    final width = queryData.size.width;
    return (!kIsWeb)
        ? DefaultTabController(
            length: 2,
            child: Scaffold(
              appBar: AppBar(
                actions: [
                  ThreeDotsWidget(listOfWidgets: [
                    ListTileWidget(
                      icon: Icons.create_outlined,
                      title: 'New message',
                      onpressed: () => Navigator.of(context)
                          .popAndPushNamed(NewMessageScreen.routeName)
                          .then((value) {
                        setState(() {});
                      }),
                    ),
                    ListTileWidget(
                      icon: Icons.drafts_outlined,
                      title: 'Mark all inbox tabs as read',
                      onpressed: () => markAllAsRead(),
                    )
                  ], height: height * 0.016),
                  Builder(builder: (context) {
                    return IconButton(
                      onPressed: () => showEndDrawer(context),
                      icon: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: const [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 6,
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.only(end: 2, bottom: 2),
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                              radius: 4,
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ],
                backgroundColor: Colors.grey[50],
                titleSpacing: 0,
                elevation: 2,
                titleTextStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18),
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
                    labelStyle: const TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 14),
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Badge(
                        toAnimate: false,
                        position: BadgePosition.topEnd(end: -10, top: -23),
                        shape: BadgeShape.circle,
                        borderRadius: BorderRadius.circular(4),
                        showBadge: unreadNotification != 0 ? true : false,
                        badgeContent: Text(
                          unreadNotification.toString(),
                          style: TextStyle(color: Colors.red),
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
              bottomNavigationBar: const buttomNavBar(
                fromProfile: 0,
                icon: '',
                nameOfSubreddit: '',
                x: 2,
              ),
              endDrawer: endDrawer(controller: controller),
              drawer: const drawer(),
              body: TabBarView(children: [
                !returned
                    ? const LoadingReddit()
                    : NotificationsMainScreen(
                        usersNotificationEarlier: usersNotificationEarlier,
                        usersNotificationToday: usersNotificationToday,
                        changeNumOfNotification: _changeNumOfNotification),
                MessageMainScreen(),
              ]),
            ),
          )
        : Scaffold(
            appBar: AppBar(title: Text('Hello')),
            body: Container(
              color: Colors.indigo[50],
              height: MediaQuery.of(context).size.height,
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 20.w, right: 20.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Divider(
                        color: Colors.transparent,
                        height: 6.h,
                      ),
                      const Text(
                        'Notifications',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 4.h,
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(NotificationScreen.routeName);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.blue, width: 0.2.h))),
                              child: const Text(
                                'Activity',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 6.h,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(WebMessageScreen.routeName);
                            },
                            onHover: (value) {
                              setState(() {
                                hover = value;
                              });
                            },
                            child: Text(
                              'Messages',
                              style: TextStyle(
                                  color: hover ? Colors.black : Colors.grey,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Spacer(
                            flex: 1,
                          ),
                          InkWell(
                              onTap: () {
                                //TO DO MARK ALL AS READ
                                markAllAsRead();
                              },
                              onHover: (value) {
                                setState(() {
                                  markAsRead = value;
                                });
                              },
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/envelope.png',
                                    color: Colors.grey,
                                    height: 3.h,
                                  ),
                                  Text(
                                    'Mark as read',
                                    style: TextStyle(
                                        color: markAsRead
                                            ? Colors.black
                                            : Colors.grey,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ))
                        ],
                      ),
                      Divider(
                        color: Colors.transparent,
                        height: 4.h,
                      ),
                      Container(
                        color: Colors.white,
                        child: NotificationsMainScreen(
                            usersNotificationEarlier: usersNotificationEarlier,
                            usersNotificationToday: usersNotificationToday,
                            changeNumOfNotification: _changeNumOfNotification),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
