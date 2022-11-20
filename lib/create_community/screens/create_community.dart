import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:post/create_community/screens/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:footer/footer.dart';
import 'package:footer/footer_view.dart';

import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../widgets/radio_button_widget.dart';
import '../models/create_community_model.dart';
import '../../networks/const_endpoint_data.dart';
import '../../networks/dio_client.dart';
import '../widgets/clear_text_field.dart';
import '../widgets/app_bar.dart';
import '../widgets/community_type.dart';
import '../widgets/list_of_community_type.dart';
import '../widgets/toggle_switch.dart';
import '../widgets/create_community_web.dart';
import '../constants/community_modal_sheet_constants.dart';

class CreateCommunity extends StatefulWidget {
  static const routeName = '/createCommunity';

  const CreateCommunity({super.key});

  @override
  State<CreateCommunity> createState() => CreateCommunityState();
}

class CreateCommunityState extends State<CreateCommunity> {
  String? choosenCommunityType;
  String? communityDefinition;
  bool plus18Community = false;
  int count = 21;

  final _communityNameController = TextEditingController();

  bool _typed = false;
  bool validating = false;
  Timer? validateOnStopTyping;
  String errorMessage = '';
  bool uniqueCommunityName = false;
  final _formKey = GlobalKey<FormState>();

  bool mock = false;
  bool done = false;

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

  changeCounterValue(String value) {
    count = 21 - value.length;
    if (value.isEmpty) {
      _typed = false;
    } else {
      _typed = true;
    }
  }

  _onChangeTextField(value) {
    //called when changing the input field
    setState(() {
      changeCounterValue(value);
    });
    if (value.length >= 3) {
      _onChangeHandler(value);
    }
  }

  clearTextField() {
    _communityNameController.text = '';
    count = 21;
    _typed = false;
  }

  _clearTextField() {
    //called to clear the text field when pressing cancel icon
    setState(() {
      clearTextField();
    });
  }

  _toggleSwitch(value) {
    setState(() {
      plus18Community = value;
    });
  }

  _changeCommunityType(key2) {
    //changing the type of commmunity chosen
    if (!kIsWeb) Navigator.of(context).pop();
    setState(() {
      choosenCommunityType = key2;
      communityDefinition = communityType[key2]!;
    });
  }

  String? validateTextField(value) {
    if ((value!.length < 3 && value.isNotEmpty) ||
        !RegExp(r'^[A-Za-z0-9_.]+$').hasMatch(value)) {
      return 'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores';
    }
    return null;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _communityNameController.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DioClient.initCreateCoumunity();
    choosenCommunityType = communityType.keys.elementAt(0);
  }

  final _textFieldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return (!kIsWeb)
        ? Scaffold(
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
                      // width: 60.h,
                      child: Form(
                        //key:Key('Create-Community'),
                        key: _textFieldKey,
                        child: Container(
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.center,
                            controller: _communityNameController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: validateTextField,
                            cursorColor: Colors.black,
                            onChanged: (value) {
                              _onChangeTextField(value);
                            },
                            decoration: InputDecoration(
                                prefixText: 'r/',
                                isDense: true,
                                contentPadding: const EdgeInsets.all(16),
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.never,
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
                                errorText: (errorMessage == '')
                                    ? null
                                    : (!uniqueCommunityName)
                                        ? errorMessage
                                        : null,
                                errorStyle: const TextStyle(
                                    color: Colors.grey, fontSize: 10),
                                suffixIcon: ClearTextField(
                                    typed: _typed,
                                    clearTextField: clearTextField,
                                    count: count)),
                            maxLength: 21,
                            maxLengthEnforcement: MaxLengthEnforcement.enforced,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text('Community type',
                        style: Theme.of(context).textTheme.bodyText1),
                    Container(
                      height: 6.h,
                      child: TextButton(
                        child: ListOfCommunityType(
                            choosenCommunityType: (choosenCommunityType == null)
                                ? communityType.keys.elementAt(0)
                                : choosenCommunityType!,
                            communityDefinition: (communityDefinition == null)
                                ? communityType[
                                    communityType.keys.elementAt(0)]!
                                : communityDefinition!),
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
                    Center(
                      child: Container(
                        width: 60.h,
                        height: 5.5.h,
                        child: ElevatedButton(
                          key: const Key('create_community_submit_button'),
                          onPressed: (_textFieldKey.currentState == null ||
                                      !_textFieldKey.currentState!.validate() ||
                                      validating ||
                                      !_typed) ||
                                  !uniqueCommunityName
                              ? null
                              : () async {
                                  //GOTO POST IN COMMUNITY & SAVE THE CREATED COMMUNITY
                                  await _saveCommunity();
                                  Navigator.of(context).pushNamed(
                                      ModeratedSubredditScreen.routeName,
                                      arguments: _communityNameController.text);
                                },
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.grey[900],
                            primary: Colors.blue[800],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
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
                    ),
                  ],
                )),
          )
        : CreateCommunityWeb(
            formKey: _formKey,
            communityNameController: _communityNameController,
            errorMessage: errorMessage,
            count: count,
            checked: plus18Community,
            changeCounterValue: changeCounterValue,
            onClick: _changeCommunityType,
            toggleSwitch: _toggleSwitch,
            saveCommunity: _saveCommunity,
            validateCommunity: _validateCommunityName,
            validateTextField: validateTextField,
          );
    ;
  }

  Future<bool> _validateCommunityName() async {
    //Called to check if the choosen community name is unique or not
    if (_communityNameController.text.length >= 3) {
      setState(() {
        validating = true;
      });
      subredditName = _communityNameController.text;
      String pathMock = (mock) ? '1' : '2';
      DioClient.get(path: getCommunity + pathMock).then((value) {
       // if (!kIsWeb) {
          setState(() {
            uniqueCommunityName = false;
            errorMessage =
                'Sorry,${_communityNameController.text} is taken.Try another.';
            validating = false;
            mock = !mock;
          });
      //  }
        return true;
      }).catchError((error) {
       // if (!kIsWeb) {
          //&& error['status'] == 404) {
          setState(() {
            uniqueCommunityName = true;
            errorMessage = '';
            validating = false;
            mock = !mock;
          });
       // } else if (error['status'] == 401) {
     //     Navigator.of(context).pushNamed(LoginPage.routeName);
      //  } else {
          print(error);
      //  }
        return false;
      });
    }
    return false;
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
      print(createCommunityModel.nSFW);
      print(createCommunityModel.type);
      print(createCommunityModel.name);
      setState(() {
        done = true;
      });
    }).catchError((error) {
      print(error);
      // return 'Sorry, r/${createCommunityModel.name} is taken. try another.';
    });
  }
}
