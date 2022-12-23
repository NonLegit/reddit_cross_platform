import 'package:flutter/material.dart';
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
import '../../other_profile/screens/others_profile_screen.dart';
import '../models/search_people.dart';
import './empty_search.dart';

class PeopleList extends StatefulWidget {
  static const routeName = '/peoplelist';
  String quiry;
  SearchProvider provider;
  int limit;
  PeopleList(
      {Key? key, required this.limit, this.quiry = '', required this.provider})
      : super(key: key);

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  bool fetchingDone = true;
  bool _isInit = true;
  bool isBuild = false;
  @override
  void didChangeDependencies() {
    if (widget.provider.initPeople) {
      setState(() {
        fetchingDone = false;
      });
      widget.provider
          .getsearch(
              quiry: widget.quiry,
              limit: widget.limit,
              type: 'people',
              context: context)
          .then((value) {
        if (widget.provider.isError) {}
        fetchingDone = true;

        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void followUnfollow(index) async {
    //
    await widget.provider.followUnfollow(index, context);
    String action =
        (widget.provider.searchCommunity!.data![index].isJoined == false)
            ? 'unfollowed'
            : 'followed';
    if (widget.provider.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text:
                'you ${action} ${widget.provider.searchPeople!.data![index].displayName} sucessfully',
            disableStatus: true),
      );
    }
    setState(() {});
  }

  Future<void> addPeople() async {
    widget.provider
        .getsearch(
            quiry: widget.quiry,
            limit: widget.limit,
            type: 'people',
            context: context)
        .then((value) {
      setState(() {});
    });
  }

  ////
  int _page = 1;
  final int _limit = 25;
  bool isInit = true;
  bool _isLoading = false;
  bool _isLoadMoreRunning = false;
  bool toggleLoadingMore() => _isLoadMoreRunning = !_isLoadMoreRunning;
  ScrollController _scrollController = new ScrollController();

  void loadMore() async {
    if (_isLoading == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 300) {
      setState(() {
        toggleLoadingMore(); // Display a progress indicator at the bottom
      });
      setState(() {
        _page += 1; // Increase _page by 1
      });

      try {
        await widget.provider
            .getsearch(
                context: context,
                quiry: widget.quiry,
                page: _page,
                limit: widget.limit,
                withPage: true,
                type: 'people')
            .then((_) async {});
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        toggleLoadingMore();
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(
        '==============================inint profile Post======================');
    _scrollController = ScrollController()..addListener(loadMore);
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : (widget.provider.searchPeople!.data!.length == 0)
            ? EmptySearch(message: 'there is no people for \"${widget.quiry}\"')
            : ListView.builder(
                controller: _scrollController,
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  PeopleData peopleData =
                      widget.provider.searchPeople!.data![index];
                  int karma = peopleData.postKarma! + peopleData.commentKarma!;
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
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          OthersProfileScreen.routeName,
                          arguments: '${peopleData.userName}');
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                NetworkImage('${peopleData.profilePicture}'),
                            backgroundColor: Colors.black,
                          ),
                          title: Text('u/${peopleData.displayName}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(children: [Text('$karmacount karma')]),
                              Text(
                                '${'${peopleData.description}'}',
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: peopleData.isFollowed!
                                    ? Colors.white
                                    : Color.fromARGB(255, 56, 93, 164),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 56, 93, 164)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            onPressed: () {
                              setState(() {
                                followUnfollow(index);
                              });
                            },
                            child: Container(
                              child: Text(
                                  peopleData.isFollowed!
                                      ? 'unfollow'
                                      : 'follow',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: widget.provider.searchPeople!
                                              .data![index].isFollowed!
                                          ? Color.fromARGB(255, 56, 93, 164)
                                          : Colors.white)),
                            ),
                          ),
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
                itemCount: widget.provider.searchPeople!.data!.length,
              );
  }
}
