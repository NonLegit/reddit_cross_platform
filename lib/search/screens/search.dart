import 'package:dartdoc/dartdoc.dart';
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

import 'dart:async';
import './search_inside.dart';
import "dart:math";
import '../models/search_people.dart';
import '../models/search_community.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../../subreddit/screens/subreddit_screen.dart';

class Search extends StatefulWidget {
  static const routeName = '/search';
  String quiry;
  Search({Key? key, this.quiry = ''}) : super(key: key);

  @override
  State<Search> createState() => SearchState();
}

class SearchState extends State<Search> {
  TextEditingController quiryController = TextEditingController();
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 0;
  bool showNSFW = true;
  bool autoPlay = true;
  SearchProvider? provider = null;
  Timer? validateOnStopTyping;

  // provider = Provider.of<SearchProvider>(context, listen: false);
  // @override
  void didChangeDependencies() {
    //   final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      provider = Provider.of<SearchProvider>(context, listen: false);
      fetchingDone = true;
      if (isBuild) setState(() {});
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  List<PeopleData> peopleList = [];
  List<CommunityData> commList = [];

  Future<void> getSearch() async {
    ///
    print('get');
    await provider!.getsearch(
        quiry: quiryController.text,
        context: context,
        limit: 5,
        page: 1,
        type: 'people',
        withPage: true);
    await provider!.getsearch(
        quiry: quiryController.text,
        context: context,
        limit: 5,
        page: 1,
        type: 'communities',
        withPage: true);
    //
    // print(Random().nextInt(0));
    var _rand = Random();

    while (!(peopleList.length + commList.length >= 5 ||
        provider!.searchPeople!.data!.length == 0 &&
            provider!.searchCommunity!.data!.length == 0)) {
      //
      int i = Random().nextInt(2);
      if (i == 1 && provider!.searchPeople!.data!.isNotEmpty) {
        int j = Random().nextInt(provider!.searchPeople!.data!.length);
        peopleList.add(provider!.searchPeople!.data!.elementAt(j));
        provider!.searchPeople!.data!.removeAt(j);
      } else if (provider!.searchCommunity!.data!.isNotEmpty) {
        int j = Random().nextInt(provider!.searchCommunity!.data!.length);
        commList.add(provider!.searchCommunity!.data!.elementAt(j));
        provider!.searchCommunity!.data!.removeAt(j);
      }
    }
    setState(() {});
    // print(Random().nextInt(provider!.searchCommunity!.data!.length));
    // print(Random().nextInt(provider!.searchPeople!.data!.length));
  }

  _onChangeHandler(value) {
    //Used to detect if the user finished typing or not so it is called on changing the text field input
    // return type : void
    const duration = Duration(
        milliseconds:
            500); // set the duration that you want call search() after that.
    if (validateOnStopTyping != null) {
      validateOnStopTyping!.cancel(); // clear timer
    }
    validateOnStopTyping = Timer(duration, () => getSearch());
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
                elevation: 0,
                title: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                actions: [
                  SizedBox(
                    // color: Colors.grey,
                    width: 80.w,
                    child: Focus(
                      onFocusChange: (value) {
                        // print('object');
                      },
                      child: TextField(
                        cursorColor: Colors.black,
                        onChanged: _onChangeHandler,
                        controller: quiryController,
                        onSubmitted: (_) {
                          Navigator.push(
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
                ]),
            body: ListView.builder(
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                String title = '';
                String subTitle = '';
                String profilePic = '';
                var action = () {};
                if (index < peopleList.length) {
                  title = 'u/ ' + peopleList[index].displayName!;
                  profilePic = peopleList[index].profilePicture!;
                  num karma = peopleList[index].postKarma! +
                      peopleList[index].commentKarma!;
                  String karmacount = '';
                  if (karma > 1000000000) {
                    karmacount = '${karma / 1000000000}b';
                  } else if (karma > 1000000) {
                    karmacount = '${karma / 1000000}m';
                  } else if (karma > 1000) {
                    karmacount = '${karma / 1000}k';
                  } else {
                    karmacount = '${karma}';
                  }
                  subTitle = karmacount + ' karma';
                  action = () {
                    Navigator.of(context).pushNamed(
                        OthersProfileScreen.routeName,
                        arguments: '${peopleList[index].userName}');
                  };
                } else {
                  title = 'r/ ' + commList[index - peopleList.length].name!;
                  profilePic = commList[index - peopleList.length].icon!;
                  num members =
                      commList[index - peopleList.length].membersCount!;
                  String mem = '';
                  if (members > 1000000000) {
                    mem = '${members / 1000000000}b';
                  } else if (members > 1000000) {
                    mem = '${members / 1000000}m';
                  } else if (members > 1000) {
                    mem = '${members / 1000}k';
                  } else {
                    mem = '${members}';
                  }
                  subTitle = mem + ' members';
                  action = () {
                    Navigator.of(context).pushNamed(SubredditScreen.routeName,
                        arguments:
                            '${commList[index - peopleList.length].fixedName}');
                  };
                }
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      elevation: 0, backgroundColor: Colors.white),
                  // onPressed: () {
                  //   // Navigator.of(context).pushNamed(OthersProfileScreen.routeName,
                  //   //     arguments: '${peopleData.userName}');
                  // },
                  onPressed: action,
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.all(0),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(profilePic),
                          backgroundColor: Colors.black,
                        ),
                        title: Text('$title'),
                        subtitle: Text('$subTitle'),
                      ),
                      const Divider(
                        height: 3,
                        thickness: 0,
                        endIndent: 0,
                        color: Colors.black,
                      ),
                    ],
                  ),
                );
              },
              itemCount: peopleList.length + commList.length,
            ));
  }
}
