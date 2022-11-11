import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';

class OthersProfileAbout extends StatelessWidget {
  final int numOfPosts;

  final int numOfComments;

  // final int numOfAwarder;

  // final int numOfAwardee;
  final String description;
  OthersProfileAbout(this.numOfPosts, this.numOfComments,
  //  this.numOfAwarder,
  //     this.numOfAwardee, 
      this.description);
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 120),
          // height: 32.h,
          height: (description == null||description == '')
              ? 36.h
              : (36 + (description.length / 42) + 4).h,
          width: 100.w,
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
                // Expanded(
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: ListTile(
                //           title: Text('$numOfAwarder'),
                //           subtitle: const Text('Awarder Karma'),
                //         ),
                //       ),
                //       Expanded(
                //         child: ListTile(
                //           title: Text('$numOfAwardee'),
                //           subtitle: const Text('Awardee Karma'),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                Container(
                  //color: Colors.lightBlue,
                  //  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.only(right: 15,left: 15,top: 15),
                  width: 100.w,
                  height: (description == null||description == '')
                      ? 0.h
                      : (0 + (description.length / 42) + 7).h,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(description,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.normal,
                                fontSize: 13))
                      ]),
                ),
             ListTile(
                            leading: Icon(
                              size: 25,
                              Icons.local_post_office_outlined,
                              color: Colors.grey,
                            ),
                            onTap: () {
                              return Navigator.pop(context);
                            },
                            title: const Text(
                              'Send a message',
                              style: TextStyle(
                                  color: Colors.black,
                                  ),
                            ),
                          ),
              ]),
        ),
        // Container(
        //     padding: const EdgeInsets.all(10),
        //     // height: MediaQuery.of(context).size.height * 0.05,
        //     // width: MediaQuery.of(context).size.height * 1,
        //     height: 5.h,
        //     width: 100.h,
        //     child: const Text(
        //       'TROPHIES',
        //       textAlign: TextAlign.start,
        //       style: TextStyle(color: Color.fromARGB(255, 134, 133, 133)),
        //     )),
        // Container(
        //   padding: const EdgeInsets.only(bottom: 10, top: 100),
        //   height: 100.h,
        //   width: 100.h,
        //   color: Colors.white,
        //   child: Column(children: [
        //     Expanded(
        //       child: Row(
        //         children: const [
        //           Expanded(
        //             child: ListTile(
        //               title: Text(''),
        //               subtitle: Text(
        //                 '',
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     )
        //   ]),
        // ),
      ],
    );
  }
}
