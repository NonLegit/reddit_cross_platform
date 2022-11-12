import 'package:flutter/material.dart';

import '../widgets/alert_dialog.dart';
import '../constants/topics.dart';
import '../widgets/topic_main_body.dart';

class TopicsScreen extends StatefulWidget {
  TopicsScreen({super.key});
  static const routeName = '/topicsScreen';
  String selectedBefore = '';
  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool _iselected = false;
  bool _pressed = false;
  Topics t1 = Topics();
  var topics = {};

  var args; //from backend

  var _selectedIndex = -1;
  var _selectedTopic = '';
  @override
  void initState() {
    // TODO: implement initState
    topics = t1.topic;

    super.initState();
  }

  onClick(index, topic) {
    setState(() {
      _selectedIndex = index;
      _iselected = true;
      widget.selectedBefore = topics.keys.elementAt(_selectedIndex);
    });
  }

  makeButtonEnable() {
    setState(() {
      _pressed = true;
    });
    print(topics.keys.elementAt(_selectedIndex));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          final shouldPop = _iselected
              ? await showDialog<bool>(
                  context: context,
                  builder: ((context) {
                    return const AlertDialog1();
                  }),
                )
              : true;
          return shouldPop!;
        },
        child: TopicMainScreen(
            iselected: _iselected,
            onClick: onClick,
            makeButtonEnable: makeButtonEnable,
            pressed: _pressed,
            selectedIndex: _selectedIndex,
            topic: topics,
            selectedBefore: widget.selectedBefore));
  }
}
