import 'package:flutter/material.dart';
import '../../screens/emptyscreen.dart';

class NotifyButtonWeb extends StatefulWidget {
  static List<String> notifyItems = ["Off", "Low", 'Frequent'];
  static List<IconData> notifyItemsIcons = [
    Icons.notifications_off,
    Icons.notifications,
    Icons.notifications_active
  ];

  NotifyButtonWeb({
    Key? key,
  }) : super(key: key);

  @override
  State<NotifyButtonWeb> createState() => _NotifyButtonWebState();
}

class _NotifyButtonWebState extends State<NotifyButtonWeb> {
  String dropDownValue = "Low";

  IconData icon = Icons.notifications;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
        icon: Icon(icon,color: Colors.blue,),
        // Callback that sets the selected popup String item.
        onSelected: (String item) {
          setState(() {
            dropDownValue = item;
            if (item == "Off")
              icon = Icons.notifications_off;
            else if (item == "Low")
              icon = Icons.notifications;
            else
              icon = Icons.notifications_active;
          });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: "Off",
                child: Row(
                  children: const [
                    Icon(
                      Icons.notifications_off,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text("Off")
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: "Low",
                child: Row(
                  children: const [
                    Icon(Icons.notifications),
                    SizedBox(
                      width: 4,
                    ),
                    Text("Low")
                  ],
                ),
              ),
              PopupMenuItem<String>(
                value: 'Frequent',
                child: Row(
                  children: const [
                    Icon(Icons.notifications_active),
                    SizedBox(
                      width: 4,
                    ),
                    Text('Frequent')
                  ],
                ),
              ),
            ]);
  }
}
