import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostFlairSettings extends StatefulWidget {
  const PostFlairSettings({super.key});
  static const routeName = '/post-flair-settings';

  @override
  State<PostFlairSettings> createState() => _PostFlairSettingsState();
}

class _PostFlairSettingsState extends State<PostFlairSettings> {
  bool modOnlySwitch = false;

  //Used to change state of mod Only switch
  toggleSwitch(value) {
    setState(() {
      modOnlySwitch = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit post flair',
        ),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: Container(
          child: Row(
        children: [
          Icon(Icons.shield, color: Colors.grey),
          Divider(),
          const Text(
            'Mod only',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          CupertinoSwitch(
            thumbColor: Colors.white,
            activeColor: Colors.blue,
            value: modOnlySwitch,
            onChanged: (value) => toggleSwitch(value),
          ),
        ],
      )),
    );
  }
}
