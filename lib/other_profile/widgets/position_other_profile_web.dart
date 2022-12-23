import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../models/others_profile_data.dart';
import 'package:provider/provider.dart';
import '../providers/other_profile_provider.dart';
import '../../widgets/custom_snack_bar.dart';
class PositionOtherProfileWeb extends StatefulWidget {
  PositionOtherProfileWeb({
    Key? key,
    required this.loadProfile,
  }) : super(key: key);

  final OtherProfileData loadProfile;

  @override
  State<PositionOtherProfileWeb> createState() =>
      _PositionOtherProfileWebState();
}

class _PositionOtherProfileWebState extends State<PositionOtherProfileWeb> {
  bool moreOptions = false;
    bool isFollowedstate = false;

   void _follow() async {
    bool follow =
        await Provider.of<OtherProfileprovider>(context, listen: false)
            .followUser(widget.loadProfile.userName.toString(), context);
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
            .unFollowUser(widget.loadProfile.userName.toString(), context);
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
    isFollowedstate = widget.loadProfile.isFollowed;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Positioned(
   top: 100,
      height: 100.h,
      child: Container(
        // width: 100.w,
        height: 100.h,

        padding: EdgeInsets.only(left: 20, top: 15),
        margin: EdgeInsets.only(top: 10),
       color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 12,
            ),

            //username
            Text(
              widget.loadProfile.displayName.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
            const SizedBox(
              height: 12,
            ),
            //name and discibtions
            Text(
                // ${loadProfile.numOfDaysInReddit} .${int.parse(loadProfile.postKarma.toString()) + int.parse(loadProfile.commentkarma.toString())}.${loadProfile.createdAt.toString()}
                'u/${widget.loadProfile.displayName}',
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 13)),
            const SizedBox(
              height: 7,
            ),
            Container(
              width: 100.w,
              height: (widget.loadProfile.description == null ||
                      widget.loadProfile.description == '')
                  ? 0.h
                  : (0 +
                          (widget.loadProfile.description.toString().length /
                              42) +
                          4)
                      .h,
              child: Text(widget.loadProfile.description.toString(),
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                      fontSize: 13)),
            ),
            const SizedBox(
              height: 7,
            ),
            Row(
              //mainAxisAlignment: MainAxisAlignment,
              children: [
                Column(
                  children: [
                    Text('Karma',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        Icon(
                          Icons.settings,
                          color: Colors.blue,
                        ),
                        Text(
                            '${int.parse(widget.loadProfile.postKarma.toString()) + int.parse(widget.loadProfile.commentkarma.toString())}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 7.w,
                ),
                Column(
                  children: [
                    Text('CakeDay',
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 13)),
                    Row(
                      children: [
                        Icon(
                          Icons.cake,
                          color: Colors.blue,
                        ),
                        Text('${widget.loadProfile.createdAt.toString()}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            //followers
            Container(
                width: widget.loadProfile.isFollowed ? 15.w : 10.w,
                height: 6.h,
                child: ElevatedButton(
                  onPressed:()=> (isFollowedstate) ? _unFollow() : _follow(),
                  style: ButtonStyle(
                      //  side: MaterialStateProperty.all(
                      // const BorderSide(
                      //     color: Colors.white)),
                      shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)))),
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: Text(
                    isFollowedstate ? 'Following' : 'Follow',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                )),
            // Visibility(
            //   visible: moreOptions,
            //   child: Container(
            //       child: Column(
            //     children: [
            //       TextButton(onPressed: null, child: Text('Send Message')),
            //       TextButton(onPressed: null, child: Text('Block User')),
            //       TextButton(
            //           onPressed: null,
            //           child: Text('Get Them Help and Support')),
            //       TextButton(onPressed: null, child: Text('Report User'))
            //     ],
            //   )),
            // ),
            // Container(
            //     width: 15.w,
            //     height: 6.h,
            //     child: TextButton(
            //       onPressed: () {
            //         setState(() {
            //           moreOptions = true;
            //         });
            //       },
            //       style: ButtonStyle(
            //           //  side: MaterialStateProperty.all(
            //           // const BorderSide(
            //           //     color: Colors.white)),
            //           shape: MaterialStateProperty.all(
            //               const RoundedRectangleBorder(
            //                   borderRadius:
            //                       BorderRadius.all(Radius.circular(30)))),
            //           backgroundColor: MaterialStateProperty.all(Colors.blue),
            //           foregroundColor: MaterialStateProperty.all(Colors.white)),
            //       child: Text(
            //         moreOptions ? 'More Options' : 'Less Options',
            //         style: TextStyle(
            //             color: Colors.white,
            //             fontWeight: FontWeight.bold,
            //             fontSize: 15),
            //       ),
            //     )),

            const SizedBox(
              height: 7,
            )
          ],
        ),
      ),
    );
  }
}
