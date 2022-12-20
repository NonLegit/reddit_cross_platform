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
import './search.dart';
import '../widgets/people_list.dart';
import '../widgets/communities_list.dart';
import '../widgets/empty_search.dart';

class SearchInside extends StatefulWidget {
  static const routeName = '/insidesearch';
  String quiry;
  SearchInside({Key? key, this.quiry = ''}) : super(key: key);

  @override
  State<SearchInside> createState() => _SearchInsideState();
}

class _SearchInsideState extends State<SearchInside> {
  int limit = 5;
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 1;
  bool showNSFW = true;
  bool autoPlay = true;
  SearchProvider? provider = null;
  // provider = Provider.of<SearchProvider>(context, listen: false);
  // @override

  void didChangeDependencies() {
    //   final Map<String, dynamic> data = <String, dynamic>{};
    // provider = Provider.of<SearchProvider>(context, listen: false);
    provider = SearchProvider();
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      print('first time');
      fetchingDone = true;
      if (isBuild) setState(() {});
    }
    _isInit = false;
    super.didChangeDependencies();
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
              actions: [
                SizedBox(
                  width: 80.w,
                  // color: Colors.grey,

                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: TextField(
                      enabled: false,
                      controller: TextEditingController(text: widget.quiry),
                      onSubmitted: (_) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchInside(quiry: _)),
                        );

                        print(_);
                      },
                      decoration: const InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.grey,
                        ),
                        hintText: 'Search',
                      ),
                    ),
                  ),
                ),
              ],
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
                  if (index == 0)
                    PostsList(
                        provider: provider!, limit: limit, quiry: widget.quiry),
                  if (index == 1)
                    CommentsList(
                        provider: provider!, limit: limit, quiry: widget.quiry),
                  if (index == 2)
                    CommunitiesList(
                        provider: provider!, limit: limit, quiry: widget.quiry),
                  if (index == 3)
                    PeopleList(
                        provider: provider!, limit: limit, quiry: widget.quiry),
                ],
              ),
            ),
          );
  }
}
