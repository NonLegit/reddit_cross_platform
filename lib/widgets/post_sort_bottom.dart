import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';
import '../providers/subreddit_posts_provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostSortBottom extends StatefulWidget {
  final String type;
  final String routeNamePop;
  final String userName;
  final int _limit = 25;
  final int page;
  PostSortBottom({
    required this.page,
    required this.type,
    required this.routeNamePop,
    required this.userName,
  });
  @override
  State<PostSortBottom> createState() => PostSortBottomState();
}

class PostSortBottomState extends State<PostSortBottom>
    with AutomaticKeepAliveClientMixin {
  var _dropDownValue = 'HOT POST';
  var _icon = Icons.local_fire_department_rounded;
  int? tappedIndex = 0;
  int? tappedIndexTop;
  List<String> litems = ["Hot", "New", 'Top'];
  List<IconData?> liItemIcons = [
    Icons.local_fire_department_rounded,
    Icons.brightness_low,
    Icons.hourglass_empty
  ];
  List<String> litemsTop = [
    "Past hour",
    "Past 24 hours",
    'Past week',
    ' Past month',
    'Past year',
    'All time'
  ];
  String? topValue = 'Past hour';
  @override
  void initState() {
    super.initState();
  }

  bool _isInit = true;
  bool _isLoading = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23.h,
        width: 100.w,
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  typesBottomSheet(context);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _icon,
                        color: const Color.fromARGB(255, 121, 121, 121),
                        size: 25,
                      ),
                      Text(
                        _dropDownValue,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 121, 121, 121),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                      const Icon(
                        color: Color.fromARGB(255, 121, 121, 121),
                        Icons.keyboard_arrow_down_rounded,
                        size: 25,
                      )
                    ]),
              ),
              const Divider(),
            ]));
  }

  Future<void> typesBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(30),
            height: 40.h,
            width: 30.w,
            margin: const EdgeInsets.all(15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('SORT POSTS BY',
                    style: TextStyle(
                      color: Colors.grey,
                    )),
                const Divider(),
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: litems.length,
                    itemBuilder: (context, index) {
                      return Container(
                          child: ListTile(
                        leading: Icon(
                          size: 25,
                          liItemIcons[index],
                          color:
                              tappedIndex == index ? Colors.black : Colors.grey,
                        ),
                        trailing: Visibility(
                          visible: tappedIndex == index,
                          child: const Icon(
                            Icons.done,
                            color: Colors.blue,
                          ),
                        ),
                        title: Text(
                          litems[index],
                          style: TextStyle(
                              color: tappedIndex == index
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            choosePostType(index);
                          });
                          return Navigator.pop(context);
                        },
                      ));
                    }),
              ],
            ),
          ),
        );
      },
    );
  }

  int choosePostType(int index) {
    tappedIndexTop = null;
    tappedIndex = index;
    _icon = liItemIcons[index] as IconData;
    _dropDownValue = '${litems[index].toUpperCase()} POSTS ';
    if (widget.type == 'User') {
      Provider.of<ProfileProvider>(context, listen: false)
          .fetchProfilePosts(widget.userName, litems[tappedIndex as int],widget.page,widget._limit,context)
          .then((value) {});
    } else {
      Provider.of<SubredditPostsProvider>(context, listen: false)
          .fetchSubredditePosts(
              widget.userName, litems[tappedIndex as int].toLowerCase(),widget.page,widget._limit,context)
          .then((value) {});
    }
    return tappedIndex as int;
  }

}
