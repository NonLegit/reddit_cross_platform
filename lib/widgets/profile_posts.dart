import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';

var _dropDownValue = 'HOT POST';
var _icon = Icons.local_fire_department_rounded;
class ProfilePosts extends StatefulWidget {
  final  String routeNamePop;
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
  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.vertical,
      children: [
       PostSortBottom(widget.routeNamePop),
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

class PostSortBottom extends StatefulWidget {
    final String routeNamePop;
  PostSortBottom(this.routeNamePop);
//String get _r=>routeNamePop;
  @override
  State<PostSortBottom> createState() => _PostSortBottomState();
}

int? tappedIndex;
int? tappedIndexTop;
List<String> litems = ["Hot", "New", 'Top'];
List<IconData> liItemIcons = [
  Icons.local_fire_department_rounded,
  Icons.brightness_low,
  Icons.file_upload_sharp
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

class _PostSortBottomState extends State<PostSortBottom> {
//    final String routeNamePop;
//  _PostSortBottomState(this.routeNamePop);
  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
    int? tappedIndexTop;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: MediaQuery.of(context).size.height * 0.23,
        // width: MediaQuery.of(context).size.width * 1,
        height: 23.h,
        width: 100.w,
        color: const Color.fromARGB(255, 240, 240, 240),
        //padding: const EdgeInsets.all(20),
        //color: Colors.black54,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) {
                      return GestureDetector(
                        onTap: () {},
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          // height: MediaQuery.of(context).size.height * 0.35,
                          // width: MediaQuery.of(context).size.width * 0.30,
                          height: 35.h,
                          width: 30.w,
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.white),
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
                                        color: tappedIndex == index
                                            ? Colors.black
                                            : Colors.grey,
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
                                        if (index != 2) {
                                          setState(() {
                                            tappedIndexTop =null;
                                            tappedIndex = index;
                                            _icon = liItemIcons[index];
                                            _dropDownValue =
                                                '${litems[index].toUpperCase()} POSTS ';
                                          });
                                          return Navigator.pop(context);
                                        } else {
                                          showModalBottomSheet<void>(
                                            backgroundColor: Colors.transparent,
                                            context: context,
                                            builder: (BuildContext context) {
                                              return GestureDetector(
                                                onTap: () {},
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  height: 100.h,
                                                  width: 30.w,
                                                  margin:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      color: Colors.white),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: <Widget>[
                                                        const Text(
                                                            'TOP POSTS FROM',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                            )),
                                                        const Divider(),
                                                        ListView.builder(
                                                            shrinkWrap: true,
                                                            itemCount: litemsTop
                                                                .length,
                                                            itemBuilder:
                                                                (context,
                                                                    index1) {
                                                              return Container(
                                                                  child:
                                                                      ListTile(
                                                                leading: Icon(
                                                                  size: 25,
                                                                  tappedIndexTop !=
                                                                          index1
                                                                      ? Icons
                                                                          .circle_outlined
                                                                      : Icons
                                                                          .check_circle_rounded,
                                                                  color: tappedIndexTop !=
                                                                          index1
                                                                      ? Colors
                                                                          .grey
                                                                      : Colors
                                                                          .black,
                                                                ),
                                                                onTap: () {
                                                                  setState(() {
                                                                    // topValue =
                                                                    //     litemsTop[
                                                                    //         index1];
                                                                    tappedIndex =
                                                                        index;
                                                                    tappedIndexTop =
                                                                        index1;
                                                                    _icon =
                                                                        liItemIcons[
                                                                            index];
                                                                    _dropDownValue =
                                                                        '${litems[index].toUpperCase()} POSTS ${litemsTop[index1].toUpperCase()}';
                                                                  });
                                                                  return Navigator.popUntil(
                                                                      context,
                                                                      ModalRoute
                                                                          .withName(widget.routeNamePop ));
                                                                },
                                                                title: Text(
                                                                  litemsTop[
                                                                      index1],
                                                                  style: TextStyle(
                                                                      color: tappedIndexTop ==
                                                                              index1
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .grey,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ));
                                                            })
                                                      ]),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                      },
                                    ));
                                  }),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        _icon,
                        color: Color.fromARGB(255, 121, 121, 121),
                        size: 25,
                      ),
                      Text(
                        '$_dropDownValue',
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
}
