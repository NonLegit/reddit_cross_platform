import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/banned.dart';

class EditBannedScreen extends StatefulWidget {
  final String? userName;
  final Baninfo? bannedInfo;
  static const routeName = './editbanned';
  const EditBannedScreen(
      {super.key, this.userName = null, this.bannedInfo = null});

  @override
  State<EditBannedScreen> createState() => _EditBannedScreenState();
}

class _EditBannedScreenState extends State<EditBannedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text((widget.userName != null)
            ? widget.userName as String
            : 'new banned'),
      ),
    );
  }
}
