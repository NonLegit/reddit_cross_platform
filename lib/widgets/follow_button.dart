import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../other_profile/providers/other_profile_provider.dart';
import '../widgets/custom_snack_bar.dart';

class FollowButton extends StatefulWidget {
  String profileUsed;
  bool isFollowed;
  final String userName;
  FollowButton(
      {super.key,
      required this.isFollowed,
      required this.userName,
      required this.profileUsed});

  @override
  State<FollowButton> createState() => FollowButtonState();
}

class FollowButtonState extends State<FollowButton> {
  bool isFollowedstate = false;
  void _follow() async {
    bool follow =
        await Provider.of<OtherProfileprovider>(context, listen: false)
            .followUser(widget.userName, context);
    if (follow) {
      setState(() {
        followSucceeded();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: 'Follow Successfully', disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: true, text: 'Follow Failed', disableStatus: true),
      );
    }
  }

  bool followSucceeded() {
    isFollowedstate = true;
    return isFollowedstate;
  }

  void _unFollow() async {
    bool unfollow =
        await Provider.of<OtherProfileprovider>(context, listen: false)
            .unFollowUser(widget.userName, context);
    if (unfollow) {
      setState(() {
        unFollowsucceeded();
      });
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: 'UnFollow Successfully', disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: true, text: 'Unfollow Failed', disableStatus: true),
      );
    }
  }

  bool unFollowsucceeded() {
    isFollowedstate = false;
    return isFollowedstate;
  }

  @override
  void initState() {
    // TODO: implement initState
    isFollowedstate = widget.isFollowed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (widget.profileUsed == 'OtherProfile')
        ? Container(
            width: isFollowedstate ? 30.w : 23.w,
            height: 6.h,
            child: OutlinedButton(
              onPressed: () {
                (isFollowedstate) ? _unFollow() : _follow();
              },
              style: ButtonStyle(
                  //shape: Outlin,

                  side: MaterialStateProperty.all(
                      const BorderSide(color: Colors.white)),
                  shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)))),
                  backgroundColor: MaterialStateProperty.all(
                      const Color.fromARGB(137, 33, 33, 33)),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              child: Text(
                isFollowedstate ? 'Following' : 'Follow',
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ))
        : TextButton(
            onPressed: (() {
              print('object');
              (isFollowedstate) ? _unFollow() : _follow();
            }),
            child: (isFollowedstate == true)
                ? const Text(
                    'Following',
                    style: TextStyle(color: Colors.grey),
                  )
                : const Text(
                    'Follow',
                    style: TextStyle(color: Colors.grey),
                  ),
          );
  }
}
