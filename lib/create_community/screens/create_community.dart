import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../moderated_subreddit/screens/moderated_subreddit_screen.dart';
import '../provider/create_community_provider.dart';
import '../models/create_community_model.dart';
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

  bool done = false;

  _onChangeHandler(value) {
    //Used to detect if the user finished typing or not so it is called on changing the text field input
    // return type : void

    const duration = Duration(
        milliseconds:
            300); // set the duration that you want call search() after that.
    if (validateOnStopTyping != null) {
      validateOnStopTyping!.cancel(); // clear timer
    }
    validateOnStopTyping = Timer(duration, () => _validateCommunityName());
  }

  changeCounterValue(String value) {
    //called when text field is changing to reload the counter
    //return type void
    //input the text written in textField

    count = 21 - value.length;
    if (value.isEmpty) {
      _typed = false;
    } else {
      _typed = true;
    }
  }

  _onChangeTextField(value) {
    //called when changing the input field
    //return type void
    //input the text written in textField

    setState(() {
      changeCounterValue(value);
    });
    if (value.length >= 3) {
      _onChangeHandler(value);
    }
  }

  clearTextField() {
    //Clearing the text field after clicking clear icon
    //return type void

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
    //used to toggle the switch of 18+ to true or false
    //return type void

    setState(() {
      plus18Community = value;
    });
  }

  _changeCommunityType(key2) {
    //changing the type of commmunity chosen
    //return type void
    //input takes the choosen community the either(private-public-restricted)
    if (!kIsWeb) Navigator.of(context).pop();
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

  @override
  void dispose() {
    super.dispose();
    _communityNameController.dispose();
  }

  @override
  void initState() {
    super.initState();
    choosenCommunityType = communityType.keys.elementAt(0);
  }

  final _textFieldKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return (!kIsWeb)
        ? Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: AppBar2(),
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
                      style: Theme.of(context).textTheme.bodyLarge,
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
                                  clearTextField: _clearTextField,
                                  count: count)),
                          maxLength: 21,
                          maxLengthEnforcement: MaxLengthEnforcement.enforced,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text('Community type',
                        style: Theme.of(context).textTheme.bodyLarge),
                    SizedBox(
                      height: 6.h,
                      child: TextButton(
                        //Calls the widget ListOfCommunityType(choosen community type by default Public ,community definition by default Public definition)
                        //To show UI of changing community type
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
                              //Calls CommunityType widget that takes list of commmunity type to build the modal bottom sheet to change the type of community
                              //calls function _changeCommunityType
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
                      child: SizedBox(
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
            communityNameController: _communityNameController,
            errorMessage: errorMessage,
            count: count,
            checked: plus18Community,
            saveCommunity: _saveCommunity,
          );
  }

  _validateCommunityName() async {
    //function called after waiting for 3 milliseconds to check uniqueness of the community name type
    // return type void
    // found takes returned value after calling backend
    if (_communityNameController.text.length >= 3 &&
        _textFieldKey.currentState!.validate()) {
      setState(() {
        validating = true;
      });
      final Map<String, dynamic> data = <String, dynamic>{};
      //data['subredditName'] = _communityNameController.text;
      try {
        bool found =
            await Provider.of<CreateCommunityProvider>(context, listen: false)
                .getCommunity(_communityNameController.text, context);
        if (found) {
          setState(() {
            uniqueCommunityName = false;
            errorMessage =
                'Sorry,${_communityNameController.text} is taken.Try another.';
            validating = false;
          });
        } else {
          setState(() {
            uniqueCommunityName = true;
            errorMessage = '';
            validating = false;
          });
        }
      } catch (error) {
        //print(error);
      }
    }
  }

  _saveCommunity() async {
    //called to save the commmunity
    //return value void

    final createCommunityModel = CreateCommunityModel(
        nSFW: plus18Community,
        name: _communityNameController.text,
        type: choosenCommunityType);
    await Provider.of<CreateCommunityProvider>(context, listen: false)
        .postCommunity(createCommunityModel.toJson(), context)
        .then((value) {
      Navigator.of(context).popAndPushNamed(ModeratedSubredditScreen.routeName,
          arguments: _communityNameController.text);
    });
  }
}
