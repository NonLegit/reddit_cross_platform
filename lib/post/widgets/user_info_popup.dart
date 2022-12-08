import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:post/other_profile/screens/others_profile_screen.dart';
import 'package:provider/provider.dart';

import '../../other_profile/models/others_profile_data.dart';
import '../../other_profile/providers/other_profile_provider.dart';
import '../../widgets/loading_reddit.dart';

class UserInfoPopUp extends StatefulWidget {
  final String authorName;
  const UserInfoPopUp({super.key, required this.authorName});

  @override
  State<UserInfoPopUp> createState() => _UserInfoPopUpState();
}

class _UserInfoPopUpState extends State<UserInfoPopUp> {
  bool _isInit = true;
  bool _isLoading = false;
  OtherProfileData? loadData;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OtherProfileprovider>(context, listen: false)
          .fetchAndSetOtherProfile(widget.authorName)
          .then((value) {
        loadData = Provider.of<OtherProfileprovider>(context, listen: false)
            .gettingOtherProfileData;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    //==================================================//
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: _isLoading
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingReddit(),
              ],
            )
          : Material(
              color:
                  Theme.of(context).colorScheme.brightness == Brightness.light
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsetsDirectional.all(5),
                    child: CircleAvatar(
                      backgroundImage:
                          NetworkImage(loadData?.profilePicture as String),
                    ),
                  ),
                  Text(
                    'u/${widget.authorName}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.brightness ==
                              Brightness.light
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              loadData?.postKarma.toString() as String,
                              style: TextStyle(
                                color: Theme.of(context)
                                            .colorScheme
                                            .brightness ==
                                        Brightness.light
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'Post Karma',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              loadData?.commentkarma.toString() as String,
                              style: TextStyle(
                                color: Theme.of(context)
                                            .colorScheme
                                            .brightness ==
                                        Brightness.light
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : Theme.of(context).colorScheme.onSurface,
                              ),
                            ),
                            Text(
                              'Comment Karma',
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pushNamed(
                        OthersProfileScreen.routeName,
                        arguments: widget.authorName),
                    child: Container(
                      margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(end: 5),
                            child: Icon(
                              Icons.person,
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'View profile',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Container(
                      margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(end: 5),
                            child: Icon(
                              Typicons.block,
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Block account',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: null,
                    child: Container(
                      margin: EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsetsDirectional.only(end: 5),
                            child: Icon(
                              FontAwesome.mail,
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            'Invite to Community',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.brightness ==
                                      Brightness.light
                                  ? Theme.of(context).colorScheme.onPrimary
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
