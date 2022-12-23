import 'package:flutter/material.dart';

class ViewComment extends StatefulWidget {
  final int level;
  const ViewComment({super.key, required this.level});

  @override
  State<ViewComment> createState() => _ViewCommentState();
}

class _ViewCommentState extends State<ViewComment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: const EdgeInsetsDirectional.only(start: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < widget.level; i++)
            const VerticalDivider(
              color: Colors.grey,
              thickness: 2,
            ),
          Text(widget.level.toString()),
        ],
      ),
    );
  }
}
