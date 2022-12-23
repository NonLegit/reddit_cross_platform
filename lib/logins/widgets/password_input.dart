import 'package:flutter/material.dart';
import '../../moderation_settings/widgets/status.dart';
import '../../models/wrapper.dart';

class PasswordInput extends StatefulWidget {
  ///the basic lable of the input text field

  final String lable;

  /// the input contrroler to listen to the password input field
  TextEditingController inputController;

  ///handler func to be called when change input event called

  final Function changeInput;

  ///handler func to be called when onpressed event called

  final Function ontap;

  ///wheter the password text is visible or not

  BoolWrapper isVisable;

  /// the current status of the poassword input field if it origin or taped or error
  InputStatus currentStatus;
  PasswordInput(
      {super.key,
      this.lable = '',
      this.currentStatus = InputStatus.original,
      required this.ontap,
      required this.isVisable,
      required this.changeInput,
      required this.inputController});

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Color.fromARGB(255, 228, 231, 239),
        child: Focus(
          onFocusChange: (hasfocus) {
            widget.ontap(hasfocus);
          },
          child: TextField(
            onChanged: (_) {
              widget.changeInput();
            },
            controller: widget.inputController,
            obscureText: !widget.isVisable.b,
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
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      widget.isVisable.b = !widget.isVisable.b;
                    });
                  },
                  color: Colors.black45,
                  icon: Icon(
                    widget.isVisable.b
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: (widget.currentStatus == InputStatus.sucess)
                        ? Colors.green
                        : (widget.currentStatus == InputStatus.failed)
                            ? Color.fromARGB(255, 178, 41, 66)
                            : Colors.black45,
                  )),
              label: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'password',
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
      ),
    );
  }
}
