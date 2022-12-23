import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../screens/others_profile_screen.dart';
import '../../screens/emptyscreen.dart';
import '../../widgets/custom_snack_bar.dart';

class PopDownMenu extends StatefulWidget {
  final String userName;
  final BuildContext buildContext;
  const PopDownMenu(
      {Key? key, required this.userName, required this.buildContext})
      : super(key: key);

  @override
  State<PopDownMenu> createState() => _PopDownMenuState();
}

class _PopDownMenuState extends State<PopDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () {
              // Some Features that User interact Like(send message , Block account,report account)
              showModalBottomSheet<void>(
                backgroundColor: Colors.transparent,
                context: context,
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.33,
                      width: MediaQuery.of(context).size.width * 0.30,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.local_post_office_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  EmptyScreen.routeName,
                                  arguments: 'send message');
                            },
                            title: const Text(
                              'Send a message',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: const Icon(
                              size: 25,
                              Icons.block_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _showBlockDialog();
                            },
                            title: const Text(
                              'Block account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ]);
  }
  // ===================================the next three function used to===========================================//
//==================Block user===========================//
// have two option one:blocksubreddit two: cancel
  void _showBlockDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        //title:Text('Are you sure you want to leave the r/${widget.communityName.toString()} community?'),
        content: Container(
          //color: Colors.amber,
          height: 12.h,
          width: 100.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Block u/${widget.userName}?',
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
          Container(
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
          Container(
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
                    .blockUser(widget.userName, context);
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
