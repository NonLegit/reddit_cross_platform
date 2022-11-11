import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:sw_code/create_community/models/create_community_model.dart';

import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../widgets/clear_text_field.dart';
import '../widgets/app_bar.dart';
import '../widgets/community_type.dart';
import '../widgets/list_of_community_type.dart';
import '../widgets/toggle_switch.dart';
import './post.dart';
import './login_screen.dart';

class CreateCommunity extends StatefulWidget {
  static const routeName = '/createCommunity';

  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => CreateCommunityState();
}

class CreateCommunityState extends State<CreateCommunity> {
  String choosenCommunityType = 'Public';
  String communityDefinition =
      'Anyone can view,post,and comment to this community';
  bool plus18Community = false;
  final _communityNameController = TextEditingController();
  var count = 21;
  bool _typed = false;
  bool validating = false;
  Timer? validateOnStopTyping;
  String errorMessage = '';
  bool uniqueCommunityName = false;

  _onChangeHandler(value) {
    //Used to detect if the user finished typing or not so it is called on changing the text field input
    const duration = Duration(
        milliseconds:
            300); // set the duration that you want call search() after that.
    if (validateOnStopTyping != null) {
      validateOnStopTyping!.cancel(); // clear timer
    }
    validateOnStopTyping = Timer(duration, () => _validateCommunityName());
  }

  _onChangeTextField(value) {
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
  }

  __clearTextField() {
    //called to clear the text field when pressing cancel icon 
    setState(() {
      _communityNameController.text = '';
      count = 21;
      _typed = false;
    });
  }

  _toggleSwitch(value) {
    setState(() {
      plus18Community = value;
    });
  }

  _changeCommunityType(key2) {
    Navigator.of(context).pop();
    setState(() {
      choosenCommunityType = key2;
      communityDefinition = communityType[key2]!;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DioClient.init();
  }

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
                'Community name',
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(
                height: 2.h,
              ),
              SizedBox(
                height: 10.h,
                child: Form(
                  key: _textFieldKey,
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    controller: _communityNameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      _validateTextField(value);
                    },
                    onChanged: (value) {
                      _onChangeTextField(value);
                    },
                    decoration: InputDecoration(
                        prefixText: 'r/',
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        labelText: 'r/Community_name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none),
                        counterText: "",
                        labelStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        filled: true,
                        errorText: (!uniqueCommunityName) ? errorMessage : null,
                        errorStyle:
                            const TextStyle(color: Colors.grey, fontSize: 10),
                        suffixIcon: ClearTextField(
                            typed: _typed,
                            clearTextField: __clearTextField,
                            count: count)),
                    maxLength: 21,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                ),
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Text('Community type',
                  style: Theme.of(context).textTheme.bodyText1),
              Container(
                height: 6.h,
                child: TextButton(
                  child: ListOfCommunityType(
                      choosenCommunityType: choosenCommunityType,
                      communityDefinition: communityDefinition),
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      builder: (context) {
                        return CommunityType(
                          communityType: communityType,
                          communityTypeIcon: communityTypeIcon,
                          getCommunityType: _changeCommunityType,
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(
                height: 3.h,
              ),
              ToggleSwitch(
                plus18Community: plus18Community,
                toggleSwitch: _toggleSwitch,
              ),
              SizedBox(
                height: 1.5.h,
              ),
              Container(
                width: 60.h,
                height: 5.5.h,
                child: ElevatedButton(
                  onPressed: (_textFieldKey.currentState == null ||
                              !_textFieldKey.currentState!.validate() ||
                              validating ||
                              !_typed) ||
                          !uniqueCommunityName
                      ? null
                      : () {
                          //GOTO POST IN COMMUNITY & SAVE THE CREATED COMMUNITY 
                          _saveCommunity();
                          Navigator.of(context).pushNamed(Post.routeName);
                        },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.blue[800],
                  ),
                  child: (validating && !uniqueCommunityName)
                      ? const CircularProgressIndicator()
                      : const Text(
                          'Create Community',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          )),
    );
  }
  String _validateTextField(value){
    if ((value!.length < 3 && value.isNotEmpty) ||
                          !RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
                        return 'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores';
                      }
                      return null;
  }
  _validateCommunityName() async {
    //Called to check if the choosen community name is unique or not
    if (_communityNameController.text.length >= 3) {
      setState(() {
        validating = true;
      });
      DioClient.get(path: getCommunity).then((value) {
        setState(() {
          uniqueCommunityName = false;
          errorMessage =
              'Sorry,${_communityNameController.text} is taken.Try another.';
          validating = false;
        });
      }).catchError((error) {
        if (error['status'] == '404') {
          setState(() {
            uniqueCommunityName = true;
            errorMessage = '';
            validating = false;
          });
        } else if (error['status'] == '400' || error['status'] == '409') {
          print('badRequest');
        } else if (error['status'] == '401') {
          Navigator.of(context).pushNamed(LoginPage.routeName);
        }
      });
    }
  }

  _saveCommunity() async {
    final createCommunityModel = CreateCommunityModel(
        nSFW: plus18Community,
        name: _communityNameController.text,
        type: choosenCommunityType);
      DioClient.post(
      path: createCommunity,
      data: createCommunityModel.toJson(),
    ).then((value) {
      print(value.toString());
    }).catchError((error) {
      if (error['status'] == '404') {
        print('error 404');
      } else if (error['status'] == '400' || error['status'] == '409') {
        print('badRequest');
      } else if (error['status'] == '401') {
        Navigator.of(context).pushNamed(LoginPage.routeName);
      }
    });
  }
}
