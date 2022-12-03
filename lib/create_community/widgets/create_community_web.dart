import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../constants/community_modal_sheet_constants.dart';
import 'radio_button_widget.dart';

class CreateCommunityWeb extends StatefulWidget {
  CreateCommunityWeb({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController communityNameController,
    required this.errorMessage,
    required this.count,
    required this.checked,
    required this.changeCounterValue,
    required this.onClick,
    required this.toggleSwitch,
    required this.saveCommunity,
    required this.validateTextField,
    required this.validateCommunity,
  })  : _formKey = formKey,
        _communityNameController = communityNameController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _communityNameController;
  String errorMessage;
  int count;
  bool checked;

  final Function changeCounterValue;
  final Function onClick;
  final Function toggleSwitch;
  final Function saveCommunity;
  final Function validateTextField;
  final Function validateCommunity;

  @override
  State<CreateCommunityWeb> createState() => _CreateCommunityWebState();
}

class _CreateCommunityWebState extends State<CreateCommunityWeb> {
  int selectedIndex = -1;
  bool validated = true;
  _onClickWeb(index, type) {
    setState(() {
      selectedIndex = index;
    });
    widget.onClick(type);
  }

  FocusNode textFieldFocus = FocusNode();

  _validateTextField() {
    if (widget._communityNameController.text.isEmpty) {
      setState(() {
        widget.errorMessage = 'A community name is required';
        validated = false;
      });
      return;
    }
    setState(() {
      widget.errorMessage =
          widget.validateTextField(widget._communityNameController.text) ?? '';
      if (widget.errorMessage != '') {
        validated = false;
        return;
      }
    });
    bool check = widget.validateCommunity();
    if (check == true) {
      setState(() {
        validated = false;
      });
    } else {
      setState(() {
        validated = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    textFieldFocus.addListener(() {
      if (!textFieldFocus.hasFocus) {
        _validateTextField();
      }
    });
    widget.count = 21 - widget._communityNameController.text.length;
    selectedIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textFieldFocus.removeListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: SizedBox(
            width: 70.h,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Create a community'),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const Divider(),
                const Text('Name'),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: const [
                    Text(
                      'Community names including capitalization cannot be changed.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Tooltip(
                      richMessage: TextSpan(
                          text:
                              'Names cannot have spaces (e.g,\n "r/bookclub" not "r/book club"),\nmust be between 3-21 characters,\nand underscores("_") are the only\nspecial characters allowed.Avoid\n using solely trademarked names\n (e.g., "r/FansOfAcme" not\n "r/Acme").'),
                      child: Icon(
                        Icons.error_outline,
                        size: 14,
                      ),
                    ),
                  ],
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                Form(
                    child: TextFormField(
                  focusNode: textFieldFocus,
                  key: widget._formKey,
                  textAlignVertical: TextAlignVertical.center,
                  controller: widget._communityNameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  cursorColor: Colors.black,
                  style: const TextStyle(color: Colors.black87),
                  onChanged: (value) => setState(() {
                    if (widget.errorMessage != '') widget.errorMessage = '';
                    widget.count = 21 - value.length;
                  }),
                  decoration: InputDecoration(
                    prefixText: 'r/',
                    isDense: true,
                    contentPadding: const EdgeInsets.all(13),
                    prefixStyle: const TextStyle(color: Colors.black45),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    label: const Text(
                      'r/',
                      style: TextStyle(color: Colors.black45),
                    ),
                    // errorMaxLines: 1,
                    // errorText: widget.errorMessage,
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: const BorderSide(color: Colors.black)),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5),
                        borderSide: BorderSide(color: Colors.grey.shade300)),
                    counterText: "",
                    labelStyle: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  maxLength: 21,
                  maxLengthEnforcement: MaxLengthEnforcement.enforced,
                )),
                Divider(
                  height: 2.h,
                  color: Colors.transparent,
                ),
                Text(
                  '${widget.count} Characters remaining',
                  style: const TextStyle(color: Colors.grey, fontSize: 11),
                ),
                if (widget.errorMessage != '')
                  Divider(
                    height: 1.h,
                    color: Colors.transparent,
                  ),
                if (widget.errorMessage != '')
                  Text(
                    widget.errorMessage,
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                Divider(
                  height: 3.5.h,
                  color: Colors.transparent,
                ),
                const Text('Community type'),
                Divider(
                  height: 1.5.h,
                  color: Colors.transparent,
                ),
                CommunityTypeWeb(
                  communityType: communityType,
                  selectedIndex: selectedIndex,
                  communityTypeIconWeb: communityTypeIconWeb,
                  onClick: _onClickWeb,
                ),
                Divider(
                  height: 3.h,
                  color: Colors.transparent,
                ),
                const Text('Adult content'),
                GestureDetector(
                  onTap: () {
                    widget.toggleSwitch(!widget.checked);
                  },
                  child: Row(
                    children: [
                      Icon(
                        (widget.checked)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank_outlined,
                        color: (widget.checked) ? Colors.blue : Colors.black45,
                      ),
                      RichText(
                        textAlign: TextAlign.start,
                        text: const TextSpan(
                          text: ' NSFW ',
                          style: TextStyle(
                              fontSize: 13,
                              backgroundColor: Colors.redAccent,
                              color: Colors.white),
                          children: <TextSpan>[
                            TextSpan(
                              text: ' 18+ year old community',
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 3.h,
                  color: Colors.transparent,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(color: Colors.blue),
                        ),
                      ),
                      child: const Text('Cancel',
                          style: TextStyle(color: Colors.blue)),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _validateTextField();
                        if (validated) {
                          widget.saveCommunity();
                          Navigator.of(context).pushNamed(
                              ModeratedSubredditScreen.routeName,
                              arguments: widget._communityNameController.text);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Create Community',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
