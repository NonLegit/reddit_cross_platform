import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import '../models/status.dart';

import '../../icons/redditIcons.dart';
import '../../icons/GoogleFacebookIcons.dart';
import '../../icons/closeIcons.dart';
import '../models/wrapper.dart';

class PasswordInput extends StatefulWidget {
  // const PasswordInput({Key? key}) : super(key: key);
  final String lable;
  TextEditingController inputController;
  final Function changeInput;
  final Function ontap;
  BoolWrapper isVisable;
  InputStatus currentStatus;
  PasswordInput(
      {this.lable = '',
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
