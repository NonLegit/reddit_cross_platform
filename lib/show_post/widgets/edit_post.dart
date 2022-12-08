import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditPost extends StatefulWidget {
  static const routeName = '/editpost-screen';
  const EditPost({super.key});

  @override
  State<EditPost> createState() => _EditPostState();
}

class _EditPostState extends State<EditPost> {
  _editPost() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        title: Text(
          'Edit post',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: () => _editPost(),
            child: Text(
              'Save',
              style: TextStyle(color: Colors.blue.shade900),
            ),
          )
        ],
      ),
      body: TextField(
        enabled: true,
        style: TextStyle(fontSize: 15.0),
        showCursor: true,
        toolbarOptions: ToolbarOptions(copy: true, cut: true, paste: true),
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        autofocus: true,
        maxLines: null,
        textAlign: TextAlign.start,
        cursorColor: Colors.black,
        decoration: InputDecoration(
            border: InputBorder.none, filled: true, fillColor: Colors.white),
      ),
      bottomNavigationBar: Container(
        height: 5.h,
        child: Row(
          children: [
            IconButton(onPressed: () {}, icon: Icon(Icons.link)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
          ],
        ),
      ),
    );
  }
}
