import 'package:flutter/material.dart';
import './topics_button.dart';
import './topics_app_bar.dart';

class TopicMainScreen extends StatelessWidget {
  final iselected;
  bool pressed;
  VoidCallback makeButtonEnable;
  final toBeReturnedFromBackend;
  final int selectedIndex;
  final Function onClick;

  TopicMainScreen(
      {required this.iselected,
      required this.pressed,
      required this.makeButtonEnable,
      required this.toBeReturnedFromBackend,
      required this.selectedIndex,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: TopicsAppBar(
            iselected: iselected, makeButtonEnable: makeButtonEnable),
      ),
      body: Column(children: [
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var key = toBeReturnedFromBackend.keys.elementAt(index);
            return TopicButton(
                selectedIndex: selectedIndex,
                myIndex: index,
                selectedIcon: toBeReturnedFromBackend[key],
                onClick: onClick,
                keyAns: key);
            // return topicsButton(key, index, onClick);
          },
          itemCount: toBeReturnedFromBackend.length,
        )
      ]),
    );
  }
}
