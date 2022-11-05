import 'package:flutter/material.dart';
//import 'package:sizer/sizer.dart';
import 'package:sw_code/widgets/topic_main_body.dart';
//import '../widgets/topics_button.dart';
import '../functions/alert_dialog.dart';

class TopicsScreen extends StatefulWidget {
  TopicsScreen({super.key});
  static const routeName = 'topicsScreen';

  @override
  State<TopicsScreen> createState() => _TopicsScreenState();
}

class _TopicsScreenState extends State<TopicsScreen> {
  bool _iselected = false;
  bool _pressed = false;

  final toBeReturnedFromBackend = {
    'Activism': 0xe5db,
    'Animals and Pets': 0xe4a1,
  };
  var _selectedIndex = -1;
  var _selectedTopic = '';

  onClick(index, topic) {
    setState(() {
      _selectedIndex = index;
      _iselected = true;
    });
  }

  makeButtonEnable() {
    setState(() {
      _pressed = true;
    });
    print(toBeReturnedFromBackend.keys.elementAt(_selectedIndex));
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
                    return alertDialog();
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
          toBeReturnedFromBackend: toBeReturnedFromBackend,
        ));
  }
}
