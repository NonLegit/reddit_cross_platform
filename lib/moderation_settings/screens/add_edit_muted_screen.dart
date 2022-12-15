import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/muted.dart';

class EditMutedScreen extends StatefulWidget {
  final String? userName;
  final MuteInfo? mutedInfo;
  static const routeName = './editmuted';
  const EditMutedScreen({super.key, this.userName = '', this.mutedInfo = null});

  @override
  State<EditMutedScreen> createState() => _EditMutedScreenState();
}

class _EditMutedScreenState extends State<EditMutedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.userName as String;
    return Scaffold(
      body: Center(
        child: Text(
            (widget.userName != '') ? widget.userName as String : 'new muted'),
      ),
    );
  }
}
