import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../models/moderated_subreddit_user_data.dart';

class InviteButton extends StatefulWidget {
  final String userName;
  InviteButton({
    Key? key,
    required this.userName,
  }) : super(key: key);

  @override
  State<InviteButton> createState() => InviteButtonState();
}

class InviteButtonState extends State<InviteButton> {
  List<ModeratedSubbredditUserData>? subdata
      // = [
      //   ModeratedSubbredditUserData(
      //       icon:
      //           'https://www.redditstatic.com/notifications/default_subreddit_avatar.png',
      //       subredditName: 'reddit'),
      //   ModeratedSubbredditUserData(
      //       icon:
      //           'https://www.redditstatic.com/notifications/default_subreddit_avatar.png',
      //       subredditName: 'reddit'),
      //   ModeratedSubbredditUserData(
      //       icon:
      //           'https://www.redditstatic.com/notifications/default_subreddit_avatar.png',
      //       subredditName: 'reddit')
      // ];
      ;
  String textMessage = '';
  late String subredditName;
  late TextEditingController message;
  var _isLoading = false;
  var _isInit = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    message = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================doing fetch=======================================//
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      // print('12 ');
      Provider.of<OtherProfileprovider>(context, listen: false)
          .fetchAndSetModeratedSubredditUser()
          .then((value) {
        subdata = Provider.of<OtherProfileprovider>(context, listen: false)
            .gettingModeratedSubreddit;
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
    return OutlinedButton(
      // On Click invite to Community which is modertated in
      onPressed: () {
        _bottomSheet(context);
      },
      style: ButtonStyle(
          side:
              MaterialStateProperty.all(const BorderSide(color: Colors.white)),
          shape: MaterialStateProperty.all(const CircleBorder()),
          backgroundColor:
              MaterialStateProperty.all(const Color.fromARGB(137, 33, 33, 33)),
          foregroundColor: MaterialStateProperty.all(Colors.white)),
      child: const Icon(Icons.person_add_alt_sharp),
    );
  }

  void insert(String content) {
    var text = message.text;
    var pos = message.selection.start;
    message.value = TextEditingValue(
      text: content,
      selection: TextSelection.collapsed(offset: content.length),
    );
  }

  Future<void> _bottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            height: MediaQuery.of(context).size.height * 0.38,
            width: MediaQuery.of(context).size.width * 0.30,
            // margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: ListTile(
                        leading: IconButton(
                          icon: Icon(Icons.close_outlined),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        title: Text(
                          'Invite ${widget.userName}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ))),
                Divider(),
                Container(
                    margin: EdgeInsets.all(5),
                    child: Text('CHOOSE A COMMUNITY',
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.bold))),
                Container(
                    height: 15.h,
                    child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: subdata!.map((sub) {
                            return Container(
                              height: 40.h,
                              width: 20.w,
                              child: InkResponse(
                                containedInkWell: true,
                                highlightShape: BoxShape.circle,
                                onTap: () {
                                  setState(() {
                                    subredditName =
                                        sub.subredditName.toString();
                                  });

                                  insert(
                                      "I\'ve invited you to join my community,r/${sub.subredditName.toString()}");
                                },
                                // Add image & text
                                child: Container(
                                  width: double.infinity,
                                  height: 20.h,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 10.h,
                                        width: 15.w,
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundImage:
                                              NetworkImage(sub.icon.toString()),
                                        ),
                                      ),
                                      Text(
                                        sub.subredditName.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ))),
                Divider(),
                Container(
                  height: 5.h,
                  width: 100.w,
                  child: TextField(
                      controller: message,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.reddit_rounded,
                            color: Colors.blue,
                            size: 50,
                          ), //icon at head of input
                          //prefixIcon: Icon(Icons.people), //you can use prefixIcon property too.
                          labelText: textMessage,
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.send,
                              color: Colors.grey,
                            ),
                            onPressed: () async {
                              await invite(context);
                            },
                          ) //icon at tail of input
                          )),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<bool> invite(BuildContext context) async {
    bool invite =
        await Provider.of<OtherProfileprovider>(context, listen: false)
            .invitation(subredditName, widget.userName);
    if (invite)
      print('invite sucess');
    else
      print('invite failed');
    return false;
  }
}
