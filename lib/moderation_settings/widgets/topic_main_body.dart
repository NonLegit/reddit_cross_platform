import 'package:flutter/material.dart';

import './topics_button.dart';
import './topics_app_bar.dart';

class TopicMainScreen extends StatelessWidget {
  final iselected;
  bool pressed;
  VoidCallback makeButtonEnable;
  final topic;
  final int selectedIndex;
  final Function onClick;
  final String selectedBefore;

  TopicMainScreen(
      {super.key, required this.iselected,
      required this.pressed,
      required this.makeButtonEnable,
      required this.topic,
      required this.selectedIndex,
      required this.onClick,required this.selectedBefore});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: TopicsAppBar(
            iselected: iselected, makeButtonEnable: makeButtonEnable),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListView.builder(
            physics: const ClampingScrollPhysics(), 
            shrinkWrap: true,
            itemBuilder: (context, index) {
              var key = topic.keys.elementAt(index);
              //Calls TopicButton widget to create entity of each topic
              //key Ans is the text of the current topic being build
              return TopicButton(
                  selectedIndex: selectedIndex,
                  myIndex: index,
                  selectedBefore : selectedBefore ,
                  selectedIcon: topic[key],
                  onClick: onClick,
                  keyAns: key);
            },
            itemCount: topic.length,
          )
        ]),
      ),
    );
  }
}
