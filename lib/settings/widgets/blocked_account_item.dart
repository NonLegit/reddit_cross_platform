import 'package:flutter/material.dart';
import '../../models/wrapper.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BlockedAccountItem extends StatefulWidget {
  BlockedAccountItem(
      {Key? key,
      required this.imageUrl,
      required this.name,
      required this.isBlock,
      required this.handler})
      : super(key: key);
  final String imageUrl;
  final String name;
  final BoolWrapper isBlock;
  final Function handler;
  @override
  State<BlockedAccountItem> createState() =>
      BlockedAccountItemState(imageUrl: imageUrl, isBlock: isBlock, name: name);
}

class BlockedAccountItemState extends State<BlockedAccountItem> {
  final String imageUrl;
  final String name;
  final BoolWrapper isBlock;
  BlockedAccountItemState(
      {required this.imageUrl, required this.isBlock, required this.name});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
        backgroundColor: Colors.black,
      ),
      title: Text(name,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      trailing: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 0,
            primary:
                isBlock.b ? Colors.white : Color.fromARGB(255, 56, 93, 164),
            side: BorderSide(color: Color.fromARGB(255, 56, 93, 164)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0))),
        onPressed: () {
          setState(() {
            widget.handler();
          });
        },
        child: Container(
          width: 15.w,
          child: Text(isBlock.b ? 'Unblock' : 'Block',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isBlock.b
                      ? Color.fromARGB(255, 56, 93, 164)
                      : Colors.white)),
        ),
      ),
    );
  }
}
