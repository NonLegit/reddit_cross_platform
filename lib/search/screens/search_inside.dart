import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/icons/arrow_head_down_word_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../provider/search_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/loading_reddit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logins/screens/login.dart';
import '../../logins/providers/authentication.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
import '../../widgets/custom_snack_bar.dart';
import '../widgets/comments_list.dart';
import '../widgets/posts_list.dart';

import '../widgets/people_list.dart';
import '../widgets/communities_list.dart';

class SearchInside extends StatefulWidget {
  static const routeName = '/insidesearch';
  String quiry;
  SearchInside({Key? key, this.quiry = ''}) : super(key: key);

  @override
  State<SearchInside> createState() => _SearchInsideState();
}

class _SearchInsideState extends State<SearchInside> {
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 0;
  bool showNSFW = true;
  bool autoPlay = true;
  String SorthomePosts = 'Best';
  SearchProvider? provider = null;
  // @override
  void didChangeDependencies() {
    //   final Map<String, dynamic> data = <String, dynamic>{};
    //   if (_isInit) {
    //     setState(() {
    //       fetchingDone = false;
    //     });
    //     provider = Provider.of<UserSettingsProvider>(context, listen: false);
    //     provider!.getAllPrefs(context).then((value) {
    //       provider!.userPrefrence;
    //       print(provider!.userPrefrence);
    //       fetchingDone = true;
    //       SorthomePosts = provider!.userPrefrence!.sortHomePosts!;
    //       autoPlay = provider!.userPrefrence!.autoplayMedia!;
    //       showNSFW = provider!.userPrefrence!.adultContent!;
    //       if (isBuild) setState(() {});
    //     });
    //   }
    //   _isInit = false;
    //   super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            appBar: AppBar(
              // backgroundColor: Colors.transparent,
              elevation: 0,
              title: Text('Search'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.transparent,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              index = 0;
                              setState(() {});
                            },
                            child: Text('Posts'),
                            style: ElevatedButton.styleFrom(
                              //                   shape: Border(
                              //   top: BorderSide(color: Colors.black),
                              // ),
                              backgroundColor:
                                  index == 0 ? Colors.blue : Colors.white,
                              elevation: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {
                              index = 1;
                              setState(() {});
                            },
                            child: Text('Comments'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  index == 1 ? Colors.blue : Colors.white,
                              elevation: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: ElevatedButton(
                            onPressed: () {
                              index = 2;
                              setState(() {});
                            },
                            child: Text('Communities'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  index == 2 ? Colors.blue : Colors.white,
                              elevation: 0,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton(
                            onPressed: () {
                              index = 3;
                              setState(() {});
                            },
                            child: Text('People'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  index == 3 ? Colors.blue : Colors.white,
                              elevation: 0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (index == 0) PostsList(),
                  if (index == 1) CommentsList(),
                  if (index == 2) CommunitiesList(),
                  if (index == 3) PeopleList(),

                  // IconListView(
                  //   leadingIcon: Icon(SettingsIcons.account_circle),
                  //   title: 'Account settings',
                  //   trailingIcon: Icon(Icons.arrow_forward_outlined),
                  //   handler: () {
                  //     // Navigator.of(context).pop(context);
                  //     // Navigator.of(context)
                  //     //     .pushNamed(AccountSettings.routeName);
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) =>
                  //               AccountSettings(provider: provider)),
                  //     );
                  //   },
                  // ),
                  // DorpDownListView(
                  //   changeChoosen: (String newValue) {
                  //     changeSortHome(newValue);
                  //   },
                  //   sheetList: [
                  //     {
                  //       'icon': Icon(Icons.rocket),
                  //       'title': 'Best',
                  //       'selected': false
                  //     },
                  //     {
                  //       'icon': Icon(SettingsIcons.fire_station),
                  //       'title': 'Hot',
                  //       'selected': false
                  //     },
                  //     {
                  //       'icon': Icon(SettingsIcons.north_star),
                  //       'title': 'New',
                  //       'selected': false
                  //     },
                  //     {
                  //       'icon': Icon(SettingsIcons.up_outline),
                  //       'title': 'Top',
                  //       'selected': false
                  //     },
                  //   ],

                  //   /// this string will come from the internal storage of the device
                  //   choosenElement: SorthomePosts,
                  //   leadingIcon: Icon(Icons.home_outlined),
                  //   title: 'Sort home posts by',
                  //   trailingIcon: Container(
                  //     width: 3.5.w,
                  //     child: FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Icon(ArrowHeadDownWord.down_open)),
                  //   ),
                  //   choosenIndex: IntWrapper(),
                  //   listType: TypeStaus.icons,
                  // ),
                  // TitleText(lable: 'View Options '),
                  // DorpDownListView(
                  //   changeChoosen: (newValue) {
                  //     changeAutoPlay(newValue);
                  //   },
                  //   sheetList: [
                  //     {
                  //       'icon': Icon(Icons.rocket),
                  //       'title': 'Alwayes',
                  //       'selected': true
                  //     },
                  //     {
                  //       'icon': Icon(Icons.fireplace_outlined),
                  //       'title': 'Never',
                  //       'selected': false
                  //     },
                  //   ],

                  //   /// this string will come from the internal storage of the device
                  //   choosenElement: (autoPlay) ? 'ALwayes' : 'Never',
                  //   leadingIcon: Icon(SettingsIcons.triangle_right),
                  //   title: 'Autoplay',
                  //   trailingIcon: Container(
                  //     width: 3.5.w,
                  //     child: FittedBox(
                  //         fit: BoxFit.scaleDown,
                  //         child: Icon(ArrowHeadDownWord.down_open)),
                  //   ),
                  //   choosenIndex: IntWrapper(),
                  //   listType: TypeStaus.selected,
                  // ),
                  // SwichListView(
                  //   changeSwiching: () {
                  //     changeNSFW();
                  //   },
                  //   choosen: showNSFW,
                  //   leadingIcon: Icon(SettingsIcons.account_circle),
                  //   title: 'Show NSFW content (i\'m over 18)',
                  // ),
                ],
              ),
            ),
          );
  }
}
