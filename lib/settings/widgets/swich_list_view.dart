import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SwichListView extends StatefulWidget {
  // const SwichListView({Key? key}) : super(key: key);

  bool choosen;
  final Icon? leadingIcon;
  final String title;
  final String subtitle;
  final Function? changeSwiching;
  SwichListView(
      {required this.choosen,
      this.leadingIcon = null,
      this.subtitle = '',
      this.title = '',
      this.changeSwiching = null});

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
                if (widget.changeSwiching == null)
                  changeState();
                else {
                  changeState();
                  widget.changeSwiching!();
                }
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
                  setState(() {
                    if (widget.changeSwiching == null)
                      changeState();
                    else {
                      changeState();
                      widget.changeSwiching!();
                    }
                  });
                },
              ),
            )));
  }
}
