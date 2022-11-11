import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';
import './post_sort_bottom.dart';

class ProfilePosts extends StatefulWidget {
  final String routeNamePop;
  const ProfilePosts({
    Key? key,
    required this.routeNamePop,
  }) : super(key: key);

  // Posts(this.routeNamePop);
  @override
  State<ProfilePosts> createState() => _ProfilePosts();
}

class _ProfilePosts extends State<ProfilePosts> {
//     final  String routeNamePop;
//  _PostsState(this.routeNamePop);
final _dropDownValue = 'HOT POST';
final _icon = Icons.local_fire_department_rounded;
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        PostSortBottom(widget.routeNamePop,_dropDownValue,_icon),
        Container(
          padding: const EdgeInsets.only(bottom: 10, top: 100),
          // height: MediaQuery.of(context).size.height * 0.4,
          // width: MediaQuery.of(context).size.height * 1,
          height: 40.h,
          width: 100.h,
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
        ),
          Container(
          padding: const EdgeInsets.only(bottom: 10, top: 100),
          // height: MediaQuery.of(context).size.height * 0.4,
          // width: MediaQuery.of(context).size.height * 1,
          height: 40.h,
          width: 100.h,
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
        ),
      
          Container(
          padding: const EdgeInsets.only(bottom: 10, top: 100),
          // height: MediaQuery.of(context).size.height * 0.4,
          // width: MediaQuery.of(context).size.height * 1,
          height: 40.h,
          width: 100.h,
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
        ),
            Container(
          padding: const EdgeInsets.only(bottom: 10, top: 100),
          // height: MediaQuery.of(context).size.height * 0.4,
          // width: MediaQuery.of(context).size.height * 1,
          height: 40.h,
          width: 100.h,
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
        ),
      ],
    );
  }
}
