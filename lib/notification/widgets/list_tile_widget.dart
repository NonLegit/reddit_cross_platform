import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  ListTileWidget({super.key, required this.icon, required this.title,this.onpressed});
  IconData? icon;
  String? title;
  VoidCallback? onpressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title!,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
