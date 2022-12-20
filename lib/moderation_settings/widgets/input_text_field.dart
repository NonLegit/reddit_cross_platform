import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController inputUserNameController;
  final String upperLable;
  final String hintText;
  final Function onChange;
  final bool isEnabled;
  final double? width;
  final int? maxLenght;
  final TextInputType keyboradType;
  const InputTextField(
      {super.key,
      required this.onChange,
      required this.isEnabled,
      required this.hintText,
      this.maxLenght = null,
      this.upperLable = '',
      this.keyboradType = TextInputType.text,
      this.width = null,
      required this.inputUserNameController});

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (widget.width != null) ? widget.width : double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 6, left: 12),
            child: Text(
              widget.upperLable,
              style: TextStyle(color: Color.fromARGB(255, 128, 127, 127)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              color: Color.fromARGB(255, 228, 231, 239),
              child: TextField(
                controller: widget.inputUserNameController,
                enabled: widget.isEnabled,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                      color: Color(0xFF999999), fontWeight: FontWeight.bold),
                ),
                onChanged: (_) {
                  widget.onChange();
                  // widget.changeInput();
                  setState(() {});
                  // print(inputUserNameController.text);
                },
                cursorColor: Colors.black,
                cursorWidth: .5,
                minLines: 1,
                maxLines: 5,
                maxLength: widget.maxLenght,
                keyboardType: widget.keyboradType,
              ),
            ),
          )
        ],
      ),
    );
  }
}
