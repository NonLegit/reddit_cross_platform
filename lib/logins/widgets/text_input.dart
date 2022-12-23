import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../moderation_settings/widgets/status.dart';

class TextInput extends StatefulWidget {
  ///the basic lable of the input text field
  final String lable;

  /// the input contrroler to listen to the password input field

  TextEditingController inputController;

  ///handler func to be called when change input event called

  final Function changeInput;

  ///handler func to be called when onpressed event called

  final Function ontap;

  /// the current status of the poassword input field if it origin or taped or error

  InputStatus currentStatus;

  TextInput(
      {this.lable = '',
      this.currentStatus = InputStatus.original,
      required this.ontap,
      required this.changeInput,
      required this.inputController});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Color.fromARGB(255, 228, 231, 239),
        child: Focus(
          onFocusChange: (hasfocus) {
            widget.ontap(hasfocus);
            int x = 12;
          },
          child: TextField(
            onChanged: (_) {
              widget.changeInput();
              setState(() {});
            },
            controller: widget.inputController,
            cursorColor: Colors.black,
            cursorWidth: .5,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    width: 3,
                    color: (widget.currentStatus == InputStatus.sucess)
                        ? Colors.green
                        : (widget.currentStatus == InputStatus.failed)
                            ? Color.fromARGB(255, 178, 41, 66)
                            : Color.fromARGB(
                                255, 228, 231, 239)), //<-- SEE HERE
              ),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                color: Colors.blue,
                width: 3,
              )),
              suffixIcon: widget.inputController.text.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          widget.inputController.clear();
                          widget.changeInput();
                        });
                      },
                      color: Colors.black45,
                      icon: Icon(
                          color: (widget.currentStatus == InputStatus.sucess)
                              ? Colors.green
                              : (widget.currentStatus == InputStatus.failed)
                                  ? Color.fromARGB(255, 178, 41, 66)
                                  : Colors.black45,
                          (widget.currentStatus == InputStatus.sucess)
                              ? Icons.check_outlined
                              : Icons.close_outlined)),
              label: Text(
                widget.lable,
                style: TextStyle(
                  color: (widget.currentStatus == InputStatus.sucess)
                      ? Colors.green
                      : (widget.currentStatus == InputStatus.failed)
                          ? Color.fromARGB(255, 178, 41, 66)
                          : Colors.black54,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
