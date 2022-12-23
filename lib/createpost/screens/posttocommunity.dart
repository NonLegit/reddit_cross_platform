import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/posts_controllers.dart';
import '../widgets/container.dart';
import '../widgets/subreddit_container.dart';

class BuildSubreddit extends StatelessWidget {
  final PostController controller = Get.put(
    PostController(),
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
          physics: BouncingScrollPhysics(),
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
                                fontStyle: FontStyle.italic, fontSize: 15.0),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                () => Column(
                  children: [
                    (controller.showMore.value)
                        ? Column(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    SubredditModeratorContainer(
                                  nameOfSubreddit: controller
                                      .moderatedSubreddits[index]
                                      .subredditName!,
                                  memberCount: controller
                                      .moderatedSubreddits[index].membersCount!,
                                  iconOfSubreddit: controller
                                      .moderatedSubreddits[index].icon!,
                                  idOfSubreddit: controller
                                      .moderatedSubreddits[index].iId!,
                                ),
                                itemCount:
                                    controller.moderatedSubreddits.length,
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    SubredditSubscriberContainer(
                                  nameOfSubreddit: controller
                                      .subscribedSubreddits[index]
                                      .subredditName!,
                                  memberCount: controller
                                      .subscribedSubreddits[index]
                                      .membersCount!,
                                  iconOfSubreddit: controller
                                      .subscribedSubreddits[index].icon!,
                                  idOfSubreddit: controller
                                      .subscribedSubreddits[index].iId!,
                                ),
                                itemCount:
                                    controller.subscribedSubreddits.length,
                              ),
                            ],
                          )
                        : Column(
                            children: [
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => (index < 3)
                                    ? SubredditModeratorContainer(
                                        nameOfSubreddit: controller
                                            .moderatedSubreddits[index]
                                            .subredditName!,
                                        memberCount: controller
                                            .moderatedSubreddits[index]
                                            .membersCount!,
                                        iconOfSubreddit: controller
                                            .moderatedSubreddits[index].icon!,
                                        idOfSubreddit: controller
                                            .moderatedSubreddits[index].iId!,
                                      )
                                    : SizedBox(),
                                itemCount:
                                    controller.moderatedSubreddits.length,
                              ),
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) => (index < 2)
                                    ? SubredditSubscriberContainer(
                                        nameOfSubreddit: controller
                                            .subscribedSubreddits[index]
                                            .subredditName!,
                                        memberCount: controller
                                            .subscribedSubreddits[index]
                                            .membersCount!,
                                        iconOfSubreddit: controller
                                            .subscribedSubreddits[index].icon!,
                                        idOfSubreddit: controller
                                            .subscribedSubreddits[index].iId!,
                                      )
                                    : SizedBox(),
                                itemCount:
                                    controller.subscribedSubreddits.length,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Visibility(
                                visible:
                                    (controller.moderatedSubreddits.length +
                                                controller.subscribedSubreddits
                                                    .length >
                                            4)
                                        ? true
                                        : false,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        controller.showMore.value = true;
                                      },
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                                  RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  side: BorderSide(
                                                      color: Colors.blue)))),
                                      // style: ElevatedButton.styleFrom(
                                      //   backgroundColor: Colors.white,
                                      //   shape: RoundedRectangleBorder(
                                      //     borderRadius: BorderRadius.circular(30),
                                      //   ),
                                      // ),
                                      child: Text(
                                        'See more',
                                        style: TextStyle(
                                          color: Colors.blue[900],
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
