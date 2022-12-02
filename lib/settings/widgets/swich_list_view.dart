import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SwichListView extends StatefulWidget {
  // const SwichListView({Key? key}) : super(key: key);

  bool choosen;
  final Icon leadingIcon;
  final String title;
  final String subtitle;
  SwichListView(
      {required this.choosen,
      required this.leadingIcon,
      this.subtitle = '',
      this.title = ''});

  @override
  State<SwichListView> createState() => SwichListViewState(choosen: choosen);
}

class SwichListViewState extends State<SwichListView> {
  bool choosen;
  void changeState() {
    choosen = !choosen;
  }

  SwichListViewState({required this.choosen});
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ElevatedButton(
            onPressed: () {
              setState(() {
                changeState();
              });
            },
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: widget.leadingIcon,
              title: Text(widget.title),
              subtitle: widget.subtitle.isEmpty ? null : Text(widget.subtitle),
              trailing: CupertinoSwitch(
                thumbColor: Colors.white,
                activeColor: Colors.blue,
                value: choosen,
                onChanged: (_) {
                  int x = 0;
                  setState(() {
                    changeState();
                  });
                },
              ),
            )));
  }
}
