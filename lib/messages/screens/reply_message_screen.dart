import 'package:flutter/material.dart';

class ReplyMessageScreen extends StatefulWidget {
  ReplyMessageScreen({super.key, this.savePost});
  static const routeName = '/reply-message-screen';
  Function? savePost;
  @override
  State<ReplyMessageScreen> createState() => _ReplyMessageScreenState();
}

class _ReplyMessageScreenState extends State<ReplyMessageScreen> {
  String messageBody = '';
  //Set the variable messageBody while changing the value of text field
  _onChangeTextField(value) {
    setState(() {
      messageBody = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Reply to message',
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              side: const BorderSide(
                color: Colors.transparent,
              ),
            ),
            onPressed: () {
              widget.savePost!(messageBody);
              Navigator.of(context).pop();
            },
            child: const Text(
              'Post',
              style: TextStyle(color: Colors.blue),
            ),
          )
        ],
        titleTextStyle: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
        backgroundColor: Colors.grey[50],
        titleSpacing: 0,
        elevation: 2,
        shadowColor: Colors.white,
      ),
      body: Container(
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          scrollPadding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          cursorColor: Colors.black,
          onChanged: (value) {
            _onChangeTextField(value);
          },
          keyboardType: TextInputType.multiline,
          maxLines: 20,
          textInputAction: TextInputAction.newline,
          decoration: const InputDecoration(
            hintText: 'Your Message',
            isDense: true,
            contentPadding:
                EdgeInsets.only(bottom: 3, left: 5, top: 25, right: 5),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            border: OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
            enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
            // filled: true,
          ),
        ),
      ),
    );
  }
}
