import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';

class MyProfileAbout extends StatelessWidget {
  final int numOfPosts;

  final int numOfComments;

  final String description;
  MyProfileAbout(this.numOfPosts, this.numOfComments,

       this.description);
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 110),
          height: (description == null||description == '')
              ? 30.h
              : (30 + (description.length / 42) + 4).h,
          width: 100.h,
          color: Colors.white,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: Text('$numOfPosts'),
                        subtitle: const Text(
                          'Post Karma',
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: Text('$numOfComments'),
                        subtitle: const Text('Comment Karma'),
                      ),
                    ),
                  ],
                )),

                Container(
                  margin: const EdgeInsets.only(right: 10,left: 10,top: 0),
                  width: 100.w,
                  height: (description == null||description == '')
                      ? 0.h
                      : (0 + (description.length / 42) + 7).h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(description,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13))
                      ]),
                ),
           
              ]),
        ),
       
      ],
    );
  }
}
