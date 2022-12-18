import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:post/other_profile/screens/others_profile_screen.dart';
import 'package:post/other_profile/widgets/other_profile_app.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../widgets/loading_reddit.dart';
import '../models/myprofile_followers_data.dart';
import '../providers/myprofile_provider.dart';

class UserFollowersScreen extends StatefulWidget {
  static const routeName = '/userfollowers';
  const UserFollowersScreen({super.key});

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  List<MyProfileFollowersData>? followersData
      // = [
      //   MyProfileFollowersData(
      //       profilePicture:
      //           'https://media.istockphoto.com/id/1243055987/photo/woman-silhouette-with-sun-in-head-with-copy-space-multiple-exposure-image.jpg?s=612x612&w=is&k=20&c=Nxu72uSlbHMuAiaGv33LITFTPYqagd5rlE1j0J61yyw=',
      //       userName: 'userName',
      //       displayName: 'displayName',
      //       karama: 4,
      //       isFollowed: true),
      //   MyProfileFollowersData(
      //       profilePicture:
      //           'https://media.istockphoto.com/id/1243055987/photo/woman-silhouette-with-sun-in-head-with-copy-space-multiple-exposure-image.jpg?s=612x612&w=is&k=20&c=Nxu72uSlbHMuAiaGv33LITFTPYqagd5rlE1j0J61yyw=',
      //       userName: 'userName',
      //       displayName: 'displayName',
      //       karama: 4,
      //       isFollowed: false),
      //   MyProfileFollowersData(
      //       profilePicture:
      //           'https://media.istockphoto.com/id/1243055987/photo/woman-silhouette-with-sun-in-head-with-copy-space-multiple-exposure-image.jpg?s=612x612&w=is&k=20&c=Nxu72uSlbHMuAiaGv33LITFTPYqagd5rlE1j0J61yyw=',
      //       userName: 'userName',
      //       displayName: 'displayName',
      //       karama: 4,
      //       isFollowed: true),
      //   MyProfileFollowersData(
      //       profilePicture:
      //           'https://media.istockphoto.com/id/1243055987/photo/woman-silhouette-with-sun-in-head-with-copy-space-multiple-exposure-image.jpg?s=612x612&w=is&k=20&c=Nxu72uSlbHMuAiaGv33LITFTPYqagd5rlE1j0J61yyw=',
      //       userName: 'userName',
      //       displayName: 'displayName',
      //       karama: 4,
      //       isFollowed: false)
      // ]
      ;
  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<MyProfileProvider>(context, listen: false)
          .fetchAndSetFollowersData()
          .then((value) {
        followersData = Provider.of<MyProfileProvider>(context, listen: false)
            .gettingMyProfileFollowersData;
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
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(context);
            },
            icon: const Icon(Icons.arrow_back),
            color: Colors.grey,
          ),
          title: Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(20, 0, 0, 0),
              borderRadius: BorderRadius.circular(5),
            ),
            width: 100.w,
            height: 5.h,
            child: const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  size: 30,
                ),
                //border: OutlineInputBorder(),
                hintText: 'Search for aspecific userName',
              ),
            ),
          ),
        ),
        body: (!_isLoading)
            ? (followersData != null)
                ? ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      SizedBox(
                        height: 2.h,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 10),
                        child: const Text(
                            'This list of followers is only visiable to you. The most recent follows are shown first'),
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                          physics: const ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: ((context, index) => InkWell(
                                child: Container(
                                  width: double.infinity,
                                  // height: 15.h,
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  child: Column(
                                    children: [
                                      ListTile(
                                        leading: CircleAvatar(
                                          radius: 20,
                                          backgroundImage: NetworkImage(
                                              followersData![index]
                                                  .profilePicture
                                                  .toString()),
                                        ),
                                        title: Text(followersData![index]
                                            .displayName
                                            .toString()),
                                        subtitle: Text(
                                            '${followersData![index].userName.toString()} . ${followersData![index].karama} karma'),
                                        trailing:
                                            (followersData![index].isFollowed ==
                                                    true)
                                                ? const Text('Following')
                                                : const Text('Follow'),
                                      ),
                                      const Divider()
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      OthersProfileScreen.routeName,
                                      arguments: followersData![index]
                                          .userName
                                          .toString());
                                },
                              )),
                          itemCount: followersData?.length,
                        ),
                      )
                    ],
                  )
                : Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Icon(
                          Icons.reddit,
                          size: 200,
                        ),
                        Text(
                          'Wow,such empty',
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  )
            : const LoadingReddit());
  }
}
