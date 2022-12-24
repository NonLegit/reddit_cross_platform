import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:post/home/screens/saved_comments.dart';
import 'package:post/home/screens/saved_posts.dart';


class Saved extends StatelessWidget {
  const Saved({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   late TabController controller;
    return
      DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: NestedScrollView(
              headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled)  =>[
                SliverAppBar(
                    backgroundColor: Colors.white,
                    titleSpacing: 0,
                    elevation: 2,
                    titleTextStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                    shadowColor: Colors.white,
                    title: const Text('Saved'),
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: TabBar(
                        indicatorWeight: 3,
                        indicatorColor: Colors.blue,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelPadding: const EdgeInsets.symmetric(horizontal: 60),
                        isScrollable: true,
                        labelStyle: const TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 14),
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.grey,
                        tabs: [
                          Text(
                            'Posts',
                            style: TextStyle(fontSize: 15),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(bottom: 6),
                            child: Text(
                              'Comments',
                            ),
                          ),
                        ],
                      ),
                    ),
                ),
              ],
              body: SizedBox(),
            ),
          ),

     body: TabBarView(
         children: [
           SavedPosts(),
           SavedCommentView(),
         ]),
        ),
      );
  }
}
