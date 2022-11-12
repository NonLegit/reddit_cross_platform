import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:post/networks/dio_client.dart';
>>>>>>> origin/Eman

import '../widgets/alert_dialog.dart';
import '../constants/topics.dart';
import '../widgets/topic_main_body.dart';
<<<<<<< HEAD
=======
import '../../networks/const_endpoint_data.dart';
>>>>>>> origin/Eman

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
<<<<<<< HEAD
  @override
  void initState() {
    // TODO: implement initState
=======


  @override
  void initState() {
    // TODO: implement initState
    DioClient.initModerationSetting();
>>>>>>> origin/Eman
    topics = t1.topic;

    super.initState();
  }

<<<<<<< HEAD
=======
    @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    widget.selectedBefore =  ModalRoute.of(context)?.settings.arguments as String;
    print(widget.selectedBefore);
  }

  

  //change the value of the choosen topic and remove styling from the old one
>>>>>>> origin/Eman
  onClick(index, topic) {
    setState(() {
      _selectedIndex = index;
      _iselected = true;
      widget.selectedBefore = topics.keys.elementAt(_selectedIndex);
    });
  }
<<<<<<< HEAD

  makeButtonEnable() {
=======
  //enabling the save button to save the new topic chosen
  makeButtonEnable() async {
>>>>>>> origin/Eman
    setState(() {
      _pressed = true;
    });
    print(topics.keys.elementAt(_selectedIndex));
<<<<<<< HEAD
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
=======
    await DioClient.patch(path: moderationTools, data: {"primaryTopic" :'${topics.keys.elementAt(_selectedIndex)}'});
    Navigator.of(context).pop();
  }
  

  @override
  Widget build(BuildContext context) {
    //used to detect the back button of the mobile to check if user didn't save the changing that happened 

>>>>>>> origin/Eman
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
