import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:post/create_community/screens/create_community.dart';
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
import 'package:flutter/foundation.dart' show kIsWeb;

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
  int index = 3;
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
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SingleChildScrollView(
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Center(
                            child: SizedBox(
                              width: (kIsWeb) ? 60.w : null,
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
                                        backgroundColor: index == 0
                                            ? Colors.blue
                                            : Colors.white,
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
                                        backgroundColor: index == 1
                                            ? Colors.blue
                                            : Colors.white,
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
                                        backgroundColor: index == 2
                                            ? Colors.blue
                                            : Colors.white,
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
                                        backgroundColor: index == 3
                                            ? Colors.blue
                                            : Colors.white,
                                        elevation: 0,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (index == 0)
                          Center(
                            child: SizedBox(
                              width: (kIsWeb)
                                  ? ((100.w < 900) ? 100.w : 900)
                                  : null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all((kIsWeb) ? 8.0 : 0),
                                child: PostsList(
                                    provider: provider!,
                                    limit: limit,
                                    quiry: widget.quiry),
                              ),
                            ),
                          ),
                        if (index == 1)
                          Center(
                            child: SizedBox(
                              width: (kIsWeb)
                                  ? ((100.w < 900) ? 100.w : 900)
                                  : null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all((kIsWeb) ? 8.0 : 0),
                                child: CommentsList(
                                    provider: provider!,
                                    limit: limit,
                                    quiry: widget.quiry),
                              ),
                            ),
                          ),
                        if (index == 2)
                          Center(
                            child: SizedBox(
                              width: (kIsWeb)
                                  ? ((100.w < 900) ? 100.w : 900)
                                  : null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all((kIsWeb) ? 8.0 : 0),
                                child: CommunitiesList(
                                    provider: provider!,
                                    limit: limit,
                                    quiry: widget.quiry),
                              ),
                            ),
                          ),
                        if (index == 3)
                          Center(
                            child: SizedBox(
                              width: (kIsWeb)
                                  ? ((100.w < 900) ? 100.w : 900)
                                  : null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all((kIsWeb) ? 8.0 : 0),
                                child: PeopleList(
                                    provider: provider!,
                                    limit: limit,
                                    quiry: widget.quiry),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                if (kIsWeb) SizedBox(width: 50),
                if (kIsWeb && index == 0)
                  Container(
                    width: 30.w,
                    height: 80.h,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Peoples'),
                                PeopleList(
                                    provider: provider!,
                                    limit: 5,
                                    quiry: widget.quiry),
                              ],
                            ),
                          ),
                          Container(
                              height: 50,
                              color: Color.fromARGB(255, 228, 231, 239)),
                          Container(
                            color: Colors.white,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Communities'),
                                CommunitiesList(
                                    provider: provider!,
                                    limit: 5,
                                    quiry: widget.quiry),
                                Container(
                                    height: 50,
                                    color: Color.fromARGB(255, 228, 231, 239)),
                                Container(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      Image.asset(
                                        'assets/images/reddit_community_search.png',
                                        width: 25.w,
                                        height: 25.h,
                                        fit: BoxFit.fill,
                                      ),
                                      Text('Have an idea for a new community?'),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          onPrimary: Colors.white,
                                          primary: (kIsWeb)
                                              ? Colors.blue
                                              : Colors.red,
                                          onSurface: Colors.grey[700],
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30)),
                                        ),
                                        onPressed: () {
                                          showDialog<bool>(
                                            context: context,
                                            builder: ((context) {
                                              return const CreateCommunity();
                                            }),
                                          );
                                        },
                                        child: Text('Create community'),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ],
            ),
          );
  }
}
