import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../constants/community_modal_sheet_constants.dart';
import '../models/create_community_model.dart';
import '../provider/create_community_provider.dart';
import 'radio_button_widget.dart';

class CreateCommunityWeb extends StatefulWidget {
  CreateCommunityWeb({
    super.key,
    // required GlobalKey<FormState> formKey,
    required TextEditingController communityNameController,
    required this.errorMessage,
    required this.count,
    required this.checked,
    required this.saveCommunity,
  }) : _communityNameController = communityNameController;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _communityNameController;
  String errorMessage;
  int count;
  bool checked;

  // final Function changeCounterValue;
  // final Function toggleSwitch;
  final Function saveCommunity;
  // final Function validateTextField;
  // final Function validateCommunity;

  @override
  State<CreateCommunityWeb> createState() => _CreateCommunityWebState();
}

class _CreateCommunityWebState extends State<CreateCommunityWeb> {
  int selectedIndex = -1;
  bool validated = true;
  bool uniqueCommunityName = false;
  String? choosenCommunityType;
  String? communityDefinition;
  bool toggleSwitch = false;
  onClick(key2) {
    //changing the type of commmunity chosen
    //return type void
    //input takes the choosen community the either(private-public-restricted)
    setState(() {
      choosenCommunityType = key2;
      communityDefinition = communityType[key2]!;
    });
  }

  String? validateTextField(value) {
    //used to validate the text field check if not empty and check if it only contains (A to Z or a to z or _)
    //return type Strung: error message if not validated or null if validated
    //input the text written in textField
    if ((value!.length < 3 && value.isNotEmpty) ||
        !RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
      return 'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores';
    }
    return null;
  }

  _onChangeTextField(value) {
    //called when changing the input field
    //return type void
    //input the text written in textField

    setState(() {
      widget.count = 21 - value.length as int;
    });
  }

  _toggleSwitch(value) {
    //used to toggle the switch of 18+ to true or false
    //return type void

    setState(() {
      toggleSwitch = value;
    });
  }

  _onClickWeb(index, type) {
    setState(() {
      selectedIndex = index;
    });
    onClick(type);
  }

  FocusNode textFieldFocus = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    choosenCommunityType = communityType.keys.elementAt(0);
    widget.count = 21 - widget._communityNameController.text.length;
    selectedIndex = 0;
    super.initState();
  }

  Future<void> _checkIfUnique() async {
    String name = widget._communityNameController.text;
    print(widget._communityNameController.text);
    setState(() {
      uniqueCommunityName = false;
    });
    if (name.length >= 3
        ) {
      try {
        bool found =
            await Provider.of<CreateCommunityProvider>(context, listen: false)
                .getCommunity(widget._communityNameController.text, context);
        if (found) {
          setState(() {
            uniqueCommunityName = false;
            widget.errorMessage =
                'Sorry,${widget._communityNameController.text} is taken.Try another.';
          });
        } else {
          setState(() {
            uniqueCommunityName = true;
            widget.errorMessage = '';
          });
        }
      } catch (error) {
      }
    }
  }

  _validateTextField() {
    setState(() {
      validated = false;
    });
    if (widget._communityNameController.text.isEmpty) {
      setState(() {
        widget.errorMessage = 'A community name is required';
        validated = false;
      });
      return;
    }
    setState(() {
      widget.errorMessage =
          validateTextField(widget._communityNameController.text) ?? '';
      if (widget.errorMessage != '') {
        validated = false;
        return;
      } else
        validated = true;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    textFieldFocus.removeListener(() {});
  }

  _saveCommunity() async {
    //called to save the commmunity
    //return value void

    final createCommunityModel = CreateCommunityModel(
        nSFW: toggleSwitch,
        name: widget._communityNameController.text,
        type: choosenCommunityType);
    await Provider.of<CreateCommunityProvider>(context, listen: false)
        .postCommunity(createCommunityModel.toJson(), context)
        .then((value) {
      Navigator.of(context).pushNamed(ModeratedSubredditScreen.routeName,
          arguments: widget._communityNameController.text);
    });
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
                    _toggleSwitch(!toggleSwitch);
                  },
                  child: Row(
                    children: [
                      Icon(
                        (toggleSwitch)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank_outlined,
                        color: (toggleSwitch) ? Colors.blue : Colors.black45,
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
                      onPressed: () async {
                        _validateTextField();
                        if (validated) {
                          _checkIfUnique().then((value) {
                            if (uniqueCommunityName) {
                              _saveCommunity();
                            }
                          });
                        }
                        // if (validated) {
                        //   _saveCommunity();
                        //   // Navigator.of(context).pushNamed(
                        //   //     ModeratedSubredditScreen.routeName,
                        //   //     arguments: widget._communityNameController.text);
                        // }
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
