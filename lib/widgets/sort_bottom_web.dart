import 'package:flutter/material.dart';
//import 'package:flutter_code_style/analysis_options.yaml';
import 'package:responsive_sizer/responsive_sizer.dart';

class SortBottomWeb extends StatefulWidget {
  SortBottomWeb();
  @override
  State<SortBottomWeb> createState() => SortBottomWebState();
}

class SortBottomWebState extends State<SortBottomWeb> {
  var topPressed = false;
  List<bool> litems = [false, false, false];
  List<String> litemsTop = [
    "Past hour",
    "Past 24 hours",
    'Past week',
    ' Past month',
    'Past year',
    'All time'
  ];
  String? topValue = 'All time';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 10.h,
        width: 50.w,
        margin: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                  color: Colors.white,
                  // width: 10.w,
                  height: 8.h,
                  margin: const EdgeInsets.only(left: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              setState(() {
                                NewButton();
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.brightness_low,
                                    color:
                                        litems[0] ? Colors.blue : Colors.grey),
                                Text(
                                  'New',
                                  style: TextStyle(
                                      color: litems[0]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                HotButton();
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.local_fire_department_rounded,
                                    color:
                                        litems[1] ? Colors.blue : Colors.grey),
                                Text(
                                  'Hot',
                                  style: TextStyle(
                                      color: litems[1]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        TextButton(
                            onPressed: () {
                              setState(() {
                                TopButton();
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.hourglass_empty,
                                    color:
                                        litems[2] ? Colors.blue : Colors.grey),
                                Text(
                                  'Top',
                                  style: TextStyle(
                                      color: litems[2]
                                          ? Colors.blue
                                          : Colors.grey),
                                )
                              ],
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        if (topPressed)
                          DropdownButton<String>(
                            value: topValue,
                            icon: const Icon(Icons.keyboard_arrow_down_rounded),
                            elevation: 16,
                            underline: Container(),
                            onChanged: (String? value) {
                              setState(() {
                                topValue = value!;
                              });
                            },
                            items: litemsTop
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                      color: (topValue == value)
                                          ? Colors.blue
                                          : Colors.grey),
                                ),
                              );
                            }).toList(),
                          ),
                      ])),
            )
          ],
        ));
  }

  bool TopButton() {
    topPressed = true;
    litems = [false, false, true];
    return litems[2];
  }

  bool HotButton() {
    topPressed = false;
    litems = [false, true, false];
       return litems[1];
  }

 bool NewButton() {
    topPressed = false;
    litems = [true, false, false];
       return litems[0];
  }
}
