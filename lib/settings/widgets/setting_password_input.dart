import 'package:flutter/material.dart';
import '../../moderation_settings/widgets/status.dart';
import '../../models/wrapper.dart';

class SettingPasswordInput extends StatefulWidget {
  // const PasswordInput({Key? key}) : super(key: key);
  final String lable;
  TextEditingController inputController;
  final Function changeInput;
  final Function ontap;
  BoolWrapper isVisable;
  InputStatus currentStatus;
  SettingPasswordInput(
      {this.lable = '',
      required this.currentStatus,
      required this.ontap,
      required this.isVisable,
      required this.changeInput,
      required this.inputController});

  @override
  State<SettingPasswordInput> createState() => _SettingPasswordInputState();
}

class _SettingPasswordInputState extends State<SettingPasswordInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white,
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
              contentPadding: EdgeInsets.all(10),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 3, color: Colors.grey[300] as Color), //<-- SEE HERE
              ),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                color: Color.fromARGB(255, 56, 93, 164),
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
                  widget.lable,
                  style: TextStyle(
                    color: (widget.currentStatus == InputStatus.taped)
                        ? Color.fromARGB(255, 56, 93, 164)
                        : Colors.grey,
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
