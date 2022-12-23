import 'package:flutter/material.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';

import '../models/moderator_tools.dart';
import '../widgets/alert_dialog.dart';
import '../constants/topics.dart';
import '../widgets/topic_main_body.dart';
import '../../widgets/loading_reddit.dart';

class TopicsScreen extends StatefulWidget {
  const TopicsScreen({super.key});
  static const routeName = './topicsScreen';
  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool _iselected = false;
  bool _pressed = false;
  Topics t1 = Topics();
  var topics = {};
  String selectedBefore = '';
  String subbredditName = '';

  var _selectedIndex = -1;
  bool fetchingDone = false;
  bool _isInit = true;
  String? choosenTopic;
  ModeratorToolsModel? moderatorToolsModel;

  @override
  void initState() {
    //return hardcoded topics from constant folder
    topics = t1.topic;
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      subbredditName = ModalRoute.of(context)?.settings.arguments as String;
      Provider.of<ModerationSettingProvider>(context, listen: false)
          .getCommunity(
              ModalRoute.of(context)?.settings.arguments as String, context
              )
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        choosenTopic = moderatorToolsModel!.choosenTopic1;
        setState(() {
          fetchingDone = true;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  //change the value of the choosen topic and remove styling from the old one
  //return value void
  //Parameters index of choosen topic to update selected index
  onClick(index, topic) {
    setState(() {
      _selectedIndex = index;
      _iselected = true;
      choosenTopic = topics.keys.elementAt(_selectedIndex);
    });
  }

  //enabling the save button to save the new topic chosen
  //return type void
  makeButtonEnable() async {
    setState(() {
      _pressed = true;
    });
    Provider.of<ModerationSettingProvider>(context, listen: false)
        .patchCommunity(
            {"primaryTopic": '${topics.keys.elementAt(_selectedIndex)}'},
            subbredditName,
            context).then((_) => Navigator.of(context).pop());
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
        child: (!fetchingDone)
            ? const LoadingReddit()
            //Calls TopicMainScreen widget to build Topics Screen
            : TopicMainScreen(
                iselected: _iselected,
                onClick: onClick,
                makeButtonEnable: makeButtonEnable,
                pressed: _pressed,
                selectedIndex: _selectedIndex,
                topic: topics,
                selectedBefore: choosenTopic!));
  }
}
