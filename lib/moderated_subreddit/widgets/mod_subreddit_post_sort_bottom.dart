import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModSubredditPostSortBottom extends StatefulWidget {
  final String routeNamePop;

  ModSubredditPostSortBottom(
    this.routeNamePop,
// this._dropDownValue, this._icon
  );
  @override
  State<ModSubredditPostSortBottom> createState() =>
      ModSubredditPostSortBottomState();
}

class ModSubredditPostSortBottomState
    extends State<ModSubredditPostSortBottom> {
  String _dropDownValue = 'HOT POST';
  IconData _icon = Icons.local_fire_department_rounded;
  int? tappedIndex;
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

  @override
  void initState() {
    super.initState();
    tappedIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 23.h,
        width: 10.w,
        color: const Color.fromARGB(255, 240, 240, 240),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            '${_dropDownValue}',
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
                  IconButton(
                      icon: const Icon(
                        Icons.shield_outlined,
                        color: Colors.grey,
                      ),
                      onPressed: () {})
                ],
              ),
              const Divider(),
            ]));
  }

 // ===================================this function used to===========================================//
//==================sorting action of Posts===========================//
  Future<void> typesBottomSheet(BuildContext context) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 35.h,
            width: 30.w,
            margin: const EdgeInsets.all(5),
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
                          if (index != 2) {
                            setState(() {
                              choosePostType(index);
                            });
                            return Navigator.pop(context);
                          } else {
                            topTimeBottomSheet(context, index);
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
  }
  int choosePostType(int index) {
    tappedIndexTop = null;
    tappedIndex = index;
    _icon = liItemIcons[index] as IconData;
    _dropDownValue = '${litems[index].toUpperCase()} POSTS ';
    return tappedIndex as int;
  }

//Select the time of top  Posts
  Future<void> topTimeBottomSheet(BuildContext context, int index) {
    return showModalBottomSheet<void>(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 100.h,
            width: 30.w,
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5), color: Colors.white),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('TOP POSTS FROM',
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  const Divider(),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: litemsTop.length,
                      itemBuilder: (context, index1) {
                        return Container(
                            child: ListTile(
                          leading: Icon(
                            size: 25,
                            tappedIndexTop != index1
                                ? Icons.circle_outlined
                                : Icons.check_circle_rounded,
                            color: tappedIndexTop != index1
                                ? Colors.grey
                                : Colors.black,
                          ),
                          onTap: () {
                            setState(() {;
                              chooseTimeTopPost(index, index1);
                            });
                            return Navigator.popUntil(context,
                                ModalRoute.withName(widget.routeNamePop));
                          },
                          title: Text(
                            litemsTop[index1],
                            style: TextStyle(
                                color: tappedIndexTop == index1
                                    ? Colors.black
                                    : Colors.grey,
                                fontWeight: FontWeight.bold),
                          ),
                        ));
                      })
                ]),
          ),
        );
      },
    );
  }

  int chooseTimeTopPost(int index, int index1) {
    tappedIndex = index;
    tappedIndexTop = index1;
    _icon = liItemIcons[index] as IconData;
    _dropDownValue =
        '${litems[index].toUpperCase()} POSTS ${litemsTop[index1].toUpperCase()}';
    return tappedIndexTop as int;
  }
}
