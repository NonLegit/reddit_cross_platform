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
import '../provider/search_provider.dart';
import '../../subreddit/screens/subreddit_screen.dart';
import '../models/search_community.dart';
import 'package:flutter_html/flutter_html.dart';
import './empty_search.dart';

class CommunitiesList extends StatefulWidget {
  static const routeName = '/communitieslist';
  String quiry;
  SearchProvider provider;
  int limit;
  CommunitiesList(
      {Key? key, required this.limit, this.quiry = '', required this.provider})
      : super(key: key);

  @override
  State<CommunitiesList> createState() => _CommunitiesListState();
}

class _CommunitiesListState extends State<CommunitiesList> {
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;
  int index = 0;
  bool showNSFW = true;
  bool autoPlay = true;
  String SorthomePosts = 'Best';
  @override
  void didChangeDependencies() {
    if (widget.provider.initCommunity) {
      setState(() {
        fetchingDone = false;
      });
      widget.provider
          .getsearch(
              quiry: widget.quiry,
              limit: widget.limit,
              type: 'communities',
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

  Future<void> joinDisjoin(int index) async {
    await widget.provider.joinDisjoinSubreddit(index, context);
    String action =
        (widget.provider.searchCommunity!.data![index].isJoined == false)
            ? 'disjoined'
            : 'joined';
    if (widget.provider.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text:
                'you ${action} ${widget.provider.searchCommunity!.data![index].name} sucessfully',
            disableStatus: true),
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : (widget.provider.searchCommunity!.data!.length == 0)
            ? EmptySearch(
                message: 'there is no communities for \"${widget.quiry}\"')
            : ListView.builder(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  CommunityData commData =
                      widget.provider.searchCommunity!.data![index];
                  String members = '';
                  if (commData.membersCount! > 1000000000) {
                    members = '${commData.membersCount! / 1000000000}b';
                  } else if (widget.provider.searchCommunity!.data![index]
                          .membersCount! >
                      1000000) {
                    members = '${commData.membersCount! / 1000000}m';
                  } else if (widget.provider.searchCommunity!.data![index]
                          .membersCount! >
                      1000) {
                    members = '${commData.membersCount! / 1000}k';
                  } else {
                    members = '${commData.membersCount!}';
                  }
                  ;
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, backgroundColor: Colors.white),
                    onPressed: () {
                      Navigator.of(context).pushNamed(SubredditScreen.routeName,
                          arguments: '${commData.fixedName}');
                    },
                    child: Column(
                      children: [
                        ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage('${commData.icon}'),
                            backgroundColor: Colors.black,
                          ),
                          title: Text('r/${commData.name}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(children: [
                                if (widget.provider.searchCommunity!
                                    .data![index].nsfw!)
                                  Text(
                                    'NSFW   ',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                Text('$members members')
                              ]),
                              Text(
                                '${'${commData.description}'}',
                              ),
                            ],
                          ),
                          trailing: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 0,
                                primary: commData.isJoined!
                                    ? Colors.white
                                    : Color.fromARGB(255, 56, 93, 164),
                                side: BorderSide(
                                    color: Color.fromARGB(255, 56, 93, 164)),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0))),
                            onPressed: () {
                              setState(() {
                                // widget.handler();
                                joinDisjoin(index);
                              });
                            },
                            child: Container(
                              // width: 10.w,
                              child: Text(
                                  commData.isJoined! ? 'disjoin' : 'join',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: widget.provider.searchCommunity!
                                              .data![index].isJoined!
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
                itemCount: widget.provider.searchCommunity!.data!.length,
              );
  }
}
