import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import '../screens/topics_screen.dart';
import 'package:sizer/sizer.dart';

class TopicButton extends StatelessWidget {
  //const TopicButton({super.key});
  final int selectedIndex;
  final int myIndex;
  final Function onClick;
  final int selectedIcon;
  final String keyAns;

  TopicButton(
      {required this.selectedIndex,
      required this.myIndex,
      required this.onClick,
      required this.selectedIcon,
      required this.keyAns});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 90.h,
        height: 10.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: (selectedIndex == myIndex)
                  ? Colors.blueGrey.shade100
                  : Colors.grey.shade50,
              shadowColor: Colors.grey.shade50,
              side: const BorderSide(width: 1, color: Colors.transparent)),
          child: ListTile(
            leading: Icon(IconData(selectedIcon, fontFamily: 'MaterialIcons')),
            title: Text(keyAns),
            trailing: Icon(
              Icons.check,
              color:
                  (selectedIndex == myIndex) ? Colors.blue : Colors.transparent,
            ),
          ),
          onPressed: () => onClick(myIndex, keyAns),
        ),
      ),
    );
    ;
  }
}
