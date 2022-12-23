import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../models/moderated_subreddit_user_data.dart';
import '../../widgets/custom_snack_bar.dart';

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
  List<ModeratedSubbredditUserData>? subdata;
  var _isLoading = false;
  var _isInit = true;
  var subredditName;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
 // ===================================this function used to===========================================//
//==================fetch date for Moderated Subreddit For User===========================//
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    //===============================doing fetch=======================================//
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<OtherProfileprovider>(context, listen: false)
          .fetchAndSetModeratedSubredditUser(context)
          .then((value) {
        subdata = Provider.of<OtherProfileprovider>(context, listen: false)
            .gettingModeratedSubreddit;
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
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

  bool isModerator = false;
  bool isChooseSubreddit = false;
  Future<void> _bottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) => GestureDetector(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.only(left: 5),
              height: MediaQuery.of(context).size.height * 0.40,
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
                            icon: const Icon(Icons.close_outlined),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          title: Text(
                            'Invite ${widget.userName}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ))),
                  const Divider(),
                  Container(
                      margin: const EdgeInsets.all(5),
                      child: const Text('CHOOSE A COMMUNITY',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold))),
                  const Divider(),
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
                                      isChooseSubreddit = !isChooseSubreddit;
                                      subredditName =
                                          sub.subredditName.toString();
                                    });
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
                                            backgroundImage: NetworkImage(
                                                sub.icon.toString()),
                                          ),
                                        ),
                                        Text(
                                          sub.subredditName.toString(),
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontSize: 10,
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
                  const Divider(),
                  Row(
                    children: [
                      SizedBox(
                        width: 50.w,
                      ),
                      const Icon(
                        Icons.reddit_outlined,
                        color: Colors.deepOrange,
                        size: 50,
                      ),
                      Container(
                        height: 6.h,
                        width: 30.w,
                        child: ElevatedButton(
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.white)),
                                shape: MaterialStateProperty.all(
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)))),
                                backgroundColor: MaterialStateProperty.all(
                                    isChooseSubreddit
                                        ? Color.fromARGB(255, 26, 131, 106)
                                        : Colors.white),
                                foregroundColor: MaterialStateProperty.all(
                                    isChooseSubreddit
                                        ? Colors.white
                                        : Colors.grey)),
                            onPressed: () async {
                              await invite(context);
                            },
                            child: Container(
                              //color: Colors.red,
                              child: Row(
                                children: const [
                                  Text(
                                    'Invite',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  Icon(Icons.send, size: 18)
                                ],
                              ),
                            )),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
 // ===================================this function used to===========================================//
//==================To Invit Other Users===========================//
  Future<bool> invite(BuildContext context) async {
    bool invite =
        await Provider.of<OtherProfileprovider>(context, listen: false)
            .invitation(subredditName, widget.userName, context);
    if (invite) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'Invitation Successfully',
            disableStatus: true),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: true, text:'Invitation Failed' , disableStatus: true),
      );
    }
    return false;
  }
}
