import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import '../post/widgets/post.dart';
import '../providers/profile_post.dart';
import 'loading_reddit.dart';
import 'sort_bottom_web.dart';
import '../myprofile/models/myprofile_data.dart';

class MyProfilePostWeb extends StatefulWidget {
  //final MyProfileData loadProfile;
  const MyProfilePostWeb({
    Key? key,
    // required this.loadProfile,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<MyProfilePostWeb> createState() => _MyProfilePostWebState();
}

class _MyProfilePostWebState extends State<MyProfilePostWeb> {
  bool _isInit = true;
  bool _isLoading = false;
  List<PostModel>? posts = [];
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProfilePostProvider>(context, listen: false)
          .fetchProfilePosts('Amr')
          .then((value) {
        posts = Provider.of<ProfilePostProvider>(context, listen: false)
            .gettingProfilePostData;
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
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        // Row(
        //   mainAxisSize: MainAxisSize.min,

        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   //crossAxisAlignment: CrossAxisAlignment.,
        //   children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              // SizedBox(height: 4.h,),
              Container(
                height: 6.h,
                width: 50.w,
                margin: EdgeInsets.only(left: 100, bottom: 10, top: 30),
                child: SortBottomWeb(),
                color: Colors.white,
                // width: 100.w,
              ),
              Container(
                // padding: const EdgeInsets.only(bottom: 100,),
                margin: EdgeInsets.only(left: 100, bottom: 90, top: 30),
                height: 30.h,
                width: 50.w,
                // color: Colors.white,
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.blue,
                      width: 3,
                    )),
                child: Column(children: [
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text('Post'),
                          ),
                        ),
                        (!_isLoading)
                            ? ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                  SingleChildScrollView(
                                    child: ListView.builder(
                                      physics: const ClampingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemBuilder: ((context, index) =>
                                          Post.profile(
                                            data: posts![index],
                                          )),
                                      itemCount: posts?.length,
                                    ),
                                  ),

                                  // widget.posts.forEach((post) {
                                  //   Post.community(
                                  //     data: post,
                                  //   );
                                  // }),
                                ],
                              )
                            : LoadingReddit()
                      ],
                    ),
                  )
                ]),
              ),
            ],
          ),
        ),

        //   ],
        // ),
      ],
    );
  }
}
