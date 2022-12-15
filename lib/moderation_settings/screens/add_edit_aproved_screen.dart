import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/banned.dart';

class EditApprovedScreen extends StatefulWidget {
  // final String? userName;
  // final Baninfo? bannedInfo;
  static const routeName = './editapproved';
  const EditApprovedScreen({super.key});

  @override
  State<EditApprovedScreen> createState() => _EditApprovedScreenState();
}

class _EditApprovedScreenState extends State<EditApprovedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('new approved'),
      ),
    );
  }
}
