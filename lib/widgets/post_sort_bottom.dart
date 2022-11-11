import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';

class PostSortBottom extends StatefulWidget {
  final String routeNamePop;
  String _dropDownValue;
  IconData? _icon;
  PostSortBottom(this.routeNamePop, this._dropDownValue, this._icon);
  @override
  State<PostSortBottom> createState() => _PostSortBottomState();
}

int? tappedIndex;
int? tappedIndexTop;
const List<String> litems = ["Hot", "New", 'Top'];
const List<IconData?> liItemIcons = [
  Icons.local_fire_department_rounded,
  Icons.brightness_low,
  Icons.hourglass_empty
];
const List<String> litemsTop = [
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
                  typesBottomSheet(context);
                },
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        widget._icon,
                        color: Color.fromARGB(255, 121, 121, 121),
                        size: 25,
                      ),
                      Text(
                        '${widget._dropDownValue}',
                        style: const TextStyle(
                            color: Color.fromARGB(255, 121, 121, 121),
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                        textAlign: TextAlign.end,
                      ),
                      Icon(
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
            padding: const EdgeInsets.all(20),
            // height: MediaQuery.of(context).size.height * 0.35,
            // width: MediaQuery.of(context).size.width * 0.30,
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
                          child: Icon(
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
                              tappedIndexTop = null;
                              tappedIndex = index;
                              widget._icon = liItemIcons[index];
                             widget._dropDownValue =
                                  '${litems[index].toUpperCase()} POSTS ';
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
                            setState(() {
                              // topValue =
                              //     litemsTop[
                              //         index1];
                              tappedIndex = index;
                              tappedIndexTop = index1;
                              widget._icon = liItemIcons[index];
                              widget._dropDownValue =
                                  '${litems[index].toUpperCase()} POSTS ${litemsTop[index1].toUpperCase()}';
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
}
