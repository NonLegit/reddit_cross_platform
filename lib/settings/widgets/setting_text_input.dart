import 'package:flutter/material.dart';
import '../../moderation_settings/widgets/status.dart';

class SettingTextInput extends StatefulWidget {
  // const TextInput({Key? key}) : super(key: key);
  final String lable;
  TextEditingController? inputController;
  final Function changeInput;
  final Function ontap;
  InputStatus currentStatus;
  int? maxLength;
  int? maxLines;
  int? minLines;
  String? initialValue;
  SettingTextInput({
    this.lable = '',
    required this.currentStatus,
    required this.ontap,
    required this.changeInput,
    this.inputController = null,
    this.maxLength = null,
    this.minLines = 1,
    this.maxLines = null,
    this.initialValue = null,
  });

  @override
  State<SettingTextInput> createState() => _SettingTextInputState();
}

class _SettingTextInputState extends State<SettingTextInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        color: Colors.white, // Color.fromARGB(255, 228, 231, 239),
        child: Focus(
          onFocusChange: (hasfocus) {
            widget.ontap(hasfocus);
          },
          child: TextFormField(
            onChanged: (_) {
              if (widget.inputController == null) {
                widget.changeInput(_);
              } else {
                widget.changeInput();
              }
              setState(() {});
            },
            controller: widget.inputController,
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
              label: Text(
                widget.lable,
                style: TextStyle(
                  color: (widget.currentStatus == InputStatus.taped)
                      ? Color.fromARGB(255, 56, 93, 164)
                      : Colors.grey,
                ),
              ),
            ),
            initialValue: widget.initialValue,
            keyboardType: TextInputType.multiline,
            minLines: widget.minLines,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
          ),
        ),
      ),
    );
  }
}
