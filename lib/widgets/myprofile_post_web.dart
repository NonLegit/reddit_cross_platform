import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../post/models/post_model.dart';
import '../post/widgets/post.dart';
import 'loading_reddit.dart';
import 'sort_bottom_web.dart';
import '../myprofile/models/myprofile_data.dart';

class MyProfilePostWeb extends StatefulWidget {
  final String userName;
 MyProfilePostWeb({
    Key? key,
    required this.userName
  }) : super(key: key);
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
      // Provider.of<ProfilePostProvider>(context, listen: false)
      //     .fetchProfilePosts('Amr')
      //     .then((value) {
      //   posts = Provider.of<ProfilePostProvider>(context, listen: false)
      //       .gettingProfilePostData;
      //   setState(() {
      //     _isLoading = false;
      //   });
      // });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            children: [
              Container(
                height: 6.h,
                width: 50.w,
                margin: EdgeInsets.only(left: 100, bottom: 10, top: 30),
                child: SortBottomWeb(page: 1,userName: widget.userName),
                color: Colors.white,
              ),
              Container(
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
                        const Expanded(
                          child: ListTile(
                            title: Text('Post'),
                          ),
                        ),
                        if (!_isLoading)
                          ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              SingleChildScrollView(
                                child: ListView.builder(
                                  physics: const ClampingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: ((context, index) => Container(
                                        margin: const EdgeInsets.only(
                                            left: 100, bottom: 90, top: 30),
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
                                              children: const [
                                                Expanded(
                                                  child: ListTile(
                                                    title: Text('Post'),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                      )),
                                  itemCount: posts?.length,
                                ),
                              ),
                            ],
                          )
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
