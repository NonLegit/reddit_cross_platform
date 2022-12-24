import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../home/controller/home_controller.dart';
import '../../home/widgets/drawer.dart';
import '../../home/widgets/end_drawer.dart';
import '../constant/topics_name.dart';
import '../constant/tabs.dart';
import '../widgets/grid_view_discover.dart';
class DiscoverScreen extends StatefulWidget {
  DiscoverScreen({Key? key,
  }) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen>
    with TickerProviderStateMixin {
      //========================================ButtonsTabBar============================================//
  TabController? _controller;
  ButtonsTabBar get _tabBar => ButtonsTabBar(
        controller: _controller,
        backgroundColor: Colors.grey,
        unselectedBackgroundColor: const Color.fromARGB(255, 240, 238, 238),
        contentPadding: const EdgeInsets.symmetric(horizontal: 7),
        buttonMargin: const EdgeInsets.only(left: 15, top: 6, bottom: 6),
        unselectedLabelStyle:
            const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
        labelStyle:
            const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        elevation: 0,
        radius: 200,
        tabs: tabs,
      );
      //===============================================================================================//
  // drawer functions
  void showDrawer(BuildContext context) {
    Scaffold.of(context).openDrawer();
  }

  void showEndDrawer(BuildContext context) {
    Scaffold.of(context).openEndDrawer();
  }
 final HomeController controller = Get.put(
    HomeController(),
  );
  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: topicsName.length,
      child: Scaffold(
        appBar: AppBar(
            title: Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(20, 0, 0, 0),
                  borderRadius: BorderRadius.circular(5),
                ),
                width: 100.w,
                height: 5.h,
                child: InkWell(
                  onTap: () {},
                  child: Row(
                    children: const [
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.search_outlined,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Search',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      ),
                    ],
                  ),
                )),
            actions: [
              Builder(builder: (context) {
                return IconButton(
                  onPressed: () => showEndDrawer(context),
                  icon: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: const [
                      CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/1016295_681893355195881_1578644646_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=19026a&_nc_eui2=AeFCVmaamBcbWQWbLgc5goA3TPveZl9CmeVM-95mX0KZ5Vix3F-p1IQuy-XTH_AaZw9YBNHT3DSG2M-3MKmnZCTP&_nc_ohc=sqT0q3soKqIAX_3KeFE&_nc_ht=scontent.fcai19-6.fna&oh=00_AfDtKbIed-hxraIzyhrh3idtNM-BDhP8dvZT6sKo7tAZsA&oe=6396FDE4'),
                        radius: 30.0,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 6,
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(end: 2, bottom: 2),
                        child: CircleAvatar(
                          backgroundColor: Colors.green,
                          radius: 4,
                        ),
                      )
                    ],
                  ),
                );
              }),
            ]),
        body: Column(children: <Widget>[
          PreferredSize(
            preferredSize: _tabBar.preferredSize,
            child: ColoredBox(
              color: const Color.fromARGB(255, 240, 238, 238),
              child: _tabBar,
            ),
          ),
          Expanded(
              child: TabBarView(
                  controller: _controller,
                  children: topicsName
                      .map((topic) => Tab(
                              child: GridViewDiscover(
                                topic:topic,
                          )))
                      .toList()))
        ]),
        endDrawer: endDrawer(controller: controller),
        drawer: drawer(),
      ),
    );
  }
}
