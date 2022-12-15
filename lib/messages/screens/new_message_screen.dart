import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class NewMessageScreen extends StatefulWidget {
  const NewMessageScreen({super.key});
  static const routeName = '/new-message-screen';

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Message'),
      ),
      body: Center(
          child: Text(
        'Hi 👋',
        style: TextStyle(fontSize: 15),
      )),
    );
  }
}
