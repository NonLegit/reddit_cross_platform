import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../screens/others_profile_screen.dart';
import '../../screens/emptyscreen.dart';

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
                            leading: Icon(
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
                            leading: Icon(
                              size: 25,
                              Icons.favorite_border_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Get them help and support',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.block_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              _showLeaveDialog();
                              SnackBar(
                                content: Text('yes'),
                              );
                              // return Navigator.pop(context);
                            },
                            title: const Text(
                              'Block account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.flag_outlined,
                              color: Colors.black,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Report acount',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            icon: Icon(
              Icons.more_vert_rounded,
              color: Colors.white,
            ),
          ),
        ]);
  }

  void _showLeaveDialog() {
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
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              Text(
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
                    Color.fromARGB(255, 236, 235, 235)),
                foregroundColor: MaterialStateProperty.all(Colors.grey),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: Text('Cancel'),
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
                backgroundColor:
                    MaterialStateProperty.all(Color.fromARGB(255, 242, 16, 0)),
                foregroundColor: MaterialStateProperty.all(Colors.white),
                shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(22)))),
              ),
              child: Text('Block account'),
              onPressed: () async {
                Navigator.popUntil(context,
                    ModalRoute.withName(OthersProfileScreen.routeName));
                bool block = await Provider.of<OtherProfileprovider>(context,
                        listen: false)
                    .blockUser(widget.userName);
                if (!block)
                  print('block failed');
                else {
                  final snackBar = SnackBar(
                    backgroundColor: Colors.white,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    behavior: SnackBarBehavior.floating,
                    content: Container(
                      width: 40.w,
                      child: Row(children: <Widget>[
                        Icon(
                          Icons.reddit_rounded,
                          color: Colors.blue,
                          size: 30,
                        ),
                        const Text(
                          'The author of this post has been blocked',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ]),
                    ),
                  );
                  ScaffoldMessenger.of(widget.buildContext)
                      .showSnackBar(snackBar);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
