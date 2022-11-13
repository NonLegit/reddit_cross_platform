import 'package:flutter/material.dart';
import 'package:post/networks/dio_client.dart';

import '../widgets/alert_dialog.dart';
import '../constants/topics.dart';
import '../widgets/topic_main_body.dart';
import '../../networks/const_endpoint_data.dart';

class TopicsScreen extends StatefulWidget {
  TopicsScreen({super.key});
  static const routeName = '/topicsScreen';
  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool _iselected = false;
  bool _pressed = false;
  Topics t1 = Topics();
  var topics = {};
  String selectedBefore = '';

 // var args; //from backend

  var _selectedIndex = -1;
  var _selectedTopic = '';

  @override
  void initState() {
    // TODO: implement initState
    DioClient.initModerationSetting();
    topics = t1.topic;

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // selectedBefore =
    //     ModalRoute.of(context)?.settings.arguments as String;
    print(selectedBefore);
  }

  //change the value of the choosen topic and remove styling from the old one
  onClick(index, topic) {
    setState(() {
      _selectedIndex = index;
      _iselected = true;
      selectedBefore = topics.keys.elementAt(_selectedIndex);
    });
  }

  //enabling the save button to save the new topic chosen
  makeButtonEnable() async {
    setState(() {
      _pressed = true;
    });
    print(topics.keys.elementAt(_selectedIndex));
    await DioClient.patch(
        path: moderationTools,
        data: {"primaryTopic": '${topics.keys.elementAt(_selectedIndex)}'});
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    //used to detect the back button of the mobile to check if user didn't save the changing that happened

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
            selectedBefore: selectedBefore));
  }
}
