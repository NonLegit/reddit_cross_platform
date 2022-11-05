import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../widgets/appBar.dart';
import '../widgets/modal_bottom_sheet.dart';
import '../widgets/bar_widget.dart';

class CreateCommunity extends StatefulWidget {
  //const CreateCommunity({super.key});
  static const routeName = '/createCommunity';

  @override
  State<CreateCommunity> createState() => _CreateCommunityState();
}

class _CreateCommunityState extends State<CreateCommunity> {
  String choosenCommunityType = 'Public';
  String communityDefinition =
      'Anyone can view,post,and comment to this community';
  bool plus18Community = false;
  //MediaQueryData mediaQuery;
  String inputField = 'Community name';
  String labelText = 'r/Community_name';
  String hintText = 'r/';
  final _communityNameController = TextEditingController();
  var count = 21;
  bool _typed = false;
  bool validating = false;
  Timer? validateOnStopTyping = null;

  _onChangeHandler(value) {
    const duration = Duration(
        milliseconds:
            300); // set the duration that you want call search() after that.
    if (validateOnStopTyping != null) {
      validateOnStopTyping!.cancel(); // clear timer
    }
    validateOnStopTyping = new Timer(duration, () => _validateValues());
  }

  StreamController<String> streamController = StreamController();
  final _textFieldKey = GlobalKey<FormState>();
  final communityType = {
    'Public': 'Anyone can view,post,and comment to this community',
    'Restricted':
        'Anyone can view this community,but only approved users can post',
    'Private': 'Only approved users can view and submit to this community',
  };

  final communityTypeIcon = {
    'Public': Icons.account_circle_outlined,
    'Restricted': Icons.task_alt_outlined,
    'Private': Icons.lock_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //leading if there is no button when pushing add it don't forget
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: appBar(),
      ),
      body: Container(
          height: 55.h,
          margin: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Text(
                inputField,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 2.h,
              ),
              Form(
                  key: _textFieldKey,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _communityNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.length < 3 && value.isNotEmpty) {
                        return 'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores';
                      } else if (value.isNotEmpty) {
                        if (!RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
                          //  print('here 2');
                          return 'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores';
                        }
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        count = 21 - _communityNameController.text.length;
                        if (value.isEmpty) {
                          _typed = false;
                        } else {
                          _typed = true;
                        }
                      });
                      if (value.length >= 3) {
                        _onChangeHandler(value);
                      }
                    },
                    decoration: InputDecoration(
                      prefixText: hintText,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      labelText: labelText,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none),
                      counterText: "",
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      filled: true,
                      errorStyle:
                          const TextStyle(color: Colors.grey, fontSize: 10),
                      suffixIcon: Container(
                        width: 10.h,
                        padding: const EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(count.toString()),
                            if (_typed)
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _communityNameController.text = '';
                                      count = 21;
                                      _typed = false;
                                    });
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ))
                          ],
                        ),
                      ),
                    ),
                    maxLength: 21,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  )),
              SizedBox(
                height: 3.h,
              ),
              Text('Community type',
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                height: 6.h,
                child: TextButton(
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.only(left: 0.0, right: 0.0),
                    title: Row(
                      children: [
                        Text(
                          choosenCommunityType,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      communityDefinition,
                      style: const TextStyle(
                          fontSize: 11, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return Container(
                          height: 40.h,
                          child: Column(
                            children: [
                              const Divider(
                                color: Colors.transparent,
                              ),
                              const barWidget(),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              const Text(
                                'Community type',
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              const Divider(
                                color: Colors.transparent,
                              ),
                              ListView.builder(
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  var key2 =
                                      communityType.keys.elementAt(index);
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                      setState(() {
                                        choosenCommunityType = key2;
                                        communityDefinition =
                                            communityType[key2]!;
                                        if (_typed)
                                          _onChangeHandler(
                                              _communityNameController.text);
                                      });
                                    },
                                    child: modalBottomSheetContent(
                                        key2: key2,
                                        communityTypeIcon: communityTypeIcon,
                                        communityType: communityType),
                                  );
                                },
                                itemCount: communityType.length,
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('18+ community',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  FlutterSwitch(
                    value: plus18Community,
                    width: 7.h,
                    height: 4.h,
                    activeColor: Colors.blue,
                    onToggle: (value) {
                      setState(() {
                        plus18Community = value;
                        if (_typed)
                          _onChangeHandler(_communityNameController.text);
                      });
                    },
                  )
                ],
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 80.h,
                height: 5.5.h,
                child: ElevatedButton(
                  onPressed: (_textFieldKey.currentState == null ||
                              !_textFieldKey.currentState!.validate() ||
                              validating) ||
                          !_typed
                      ? null
                      : () {
                          //GOTO POST IN COMMUNITY
                        },
                  child: (validating)
                      ? CircularProgressIndicator()
                      : Text(
                          'Create Community',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue[800],
                  ),
                ),
              ),
            ],
          )),
    );
  }

  _validateValues() {
    if (_communityNameController.text.length >= 3) {
      // code here
      setState(() {
        validating = true;
      });
      const duration = Duration(milliseconds: 1000);

      new Timer(
          duration,
          () => setState(() {
                validating = false;
              }));
      //validate to backend//////////////////////////////////
      print(_communityNameController.text);
      print(choosenCommunityType);
      print(plus18Community);
      print(communityDefinition);
    } else {
      // some other code here
    }
  }
}
