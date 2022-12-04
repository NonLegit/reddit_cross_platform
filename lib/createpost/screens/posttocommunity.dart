import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:post/networks/const_endpoint_data.dart';

import '../../networks/const_endpoint_data.dart';
import '../controllers/posts_controllers.dart';
import '../widgets/container.dart';
import '../widgets/subreddit_container.dart';
class buildSubreddit extends StatelessWidget {
  final postController controller = Get.put(
    postController(),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text(
            "Post to",
            style: TextStyle(fontSize: 15),
          ),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 5, top: 12),
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    height: 38,
                    width: 390,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[300],
                    ),
                    child: Padding(
                      padding: const EdgeInsetsDirectional.only(start: 15),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.search,
                            size: 22.0,
                          ),
                          SizedBox(width: 7),
                          Text(
                            "Search",
                            style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 15.0
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context , index) => SubredditModeratorContainer(nameOfSubreddit:controller.moderatedSubreddits[index].subredditName!,memberCount: controller.moderatedSubreddits[index].membersCount!,iconOfSubreddit:controller.moderatedSubreddits[index].icon!,) ,
                    itemCount: controller.moderatedSubreddits.length,
                  ),
                  ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context , index) => SubredditSubscriberContainer(nameOfSubreddit:controller.subscribedSubreddits[index].subredditName!,memberCount: controller.subscribedSubreddits[index].membersCount!,iconOfSubreddit:controller.subscribedSubreddits[index].icon!,) ,
                    itemCount: controller.subscribedSubreddits.length,
                  ),
                ],
              ),
            ],
          ),
        )
    );
  }
}
