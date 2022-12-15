import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/moderators.dart';

class EditModeratorScreen extends StatefulWidget {
  final String? userName;
  // final Baninfo? bannedInfo;
  final ModeratorPermissions? moderatorPermissions;
  static const routeName = './editmoderator';
  const EditModeratorScreen(
      {super.key, this.userName = '', this.moderatorPermissions = null});

  @override
  State<EditModeratorScreen> createState() => _EditModeratorScreenState();
}

class _EditModeratorScreenState extends State<EditModeratorScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.moderatorPermissions!.all);
    // print(widget.moderatorPermissions!.access);
    // print(widget.moderatorPermissions!.config);
    // print(widget.moderatorPermissions!.flair);
    // print(widget.moderatorPermissions!.posts);
    String name = widget.userName as String;
    return Scaffold(
      body: Center(
        child: Text((widget.userName != '')
            ? widget.userName as String
            : 'new moderator'),
      ),
    );
  }
}
