import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fluttericon/typicons_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:post/other_profile/screens/others_profile_screen.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../myprofile/screens/myprofile_screen.dart';
import '../../other_profile/models/others_profile_data.dart';
import '../../other_profile/providers/other_profile_provider.dart';
import '../../widgets/loading_reddit.dart';

/// A pop up (AlertDialog) to show the user info
class UserInfoPopUp extends StatefulWidget {
  /// the name of the user to get his data
  final String authorName;

  /// A boolean to determine the look of the pop up
  final bool isMine;
  const UserInfoPopUp({
    super.key,
    required this.authorName,
    required this.isMine,
  });

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
          .fetchAndSetOtherProfile(widget.authorName, context)
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
              children: const [
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
                    margin:
                        const EdgeInsetsDirectional.only(bottom: 10, top: 10),
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
                    onTap: () {
                      if (widget.isMine) {
                        Navigator.of(context).pushNamed(
                            MyProfileScreen.routeName,
                            arguments: widget.authorName);
                      } else {
                        Navigator.of(context).pushNamed(
                            OthersProfileScreen.routeName,
                            arguments: widget.authorName);
                      }
                    },
                    child: Container(
                      margin:
                          const EdgeInsetsDirectional.only(bottom: 10, top: 10),
                      child: Row(
                        children: [
                          Container(
                            margin: const EdgeInsetsDirectional.only(end: 5),
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
                  !widget.isMine
                      ? InkWell(
                          onTap: () {
                            _showLeaveDialog();
                          },
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(
                                bottom: 10, top: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 5),
                                  child: Icon(
                                    Typicons.block,
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                  ),
                                ),
                                Text(
                                  'Block account',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                  !widget.isMine
                      ? InkWell(
                          onTap: null,
                          child: Container(
                            margin: const EdgeInsetsDirectional.only(
                                bottom: 10, top: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin:
                                      const EdgeInsetsDirectional.only(end: 5),
                                  child: Icon(
                                    FontAwesome.mail,
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                  ),
                                ),
                                Text(
                                  'Invite to Community',
                                  style: TextStyle(
                                    color: Theme.of(context)
                                                .colorScheme
                                                .brightness ==
                                            Brightness.light
                                        ? Theme.of(context)
                                            .colorScheme
                                            .onPrimary
                                        : Theme.of(context)
                                            .colorScheme
                                            .onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
    );
  }

  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        //title:Text('Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        content: SizedBox(
          //color: Colors.amber,
          height: 12.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block u/${widget.authorName}?',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'They won\'t be able to contact you or view your profile, posts, or comments.',
                style: TextStyle(
                    fontWeight: FontWeight.normal, color: Colors.black),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          SizedBox(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 236, 235, 235)),
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          ),
          SizedBox(
            width: 35.w,
            height: 6.h,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    const Color.fromARGB(255, 242, 16, 0)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: const Text('Block account'),
              onPressed: () async {
                Navigator.popUntil(context,
                    ModalRoute.withName(OthersProfileScreen.routeName));
                bool block = await Provider.of<OtherProfileprovider>(context,
                        listen: false)
                    .blockUser(widget.authorName, context);
                if (!block) {
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(
                      isError: false,
                      text: 'Invitation Successfully',
                      disableStatus: true));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    CustomSnackBar(
                        isError: false,
                        text: 'Invitation Successfully',
                        disableStatus: true),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
