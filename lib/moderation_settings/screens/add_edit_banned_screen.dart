import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/banned.dart';
import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/muted.dart';
import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/moderators.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import './banned_user_sceen.dart';
import '../widgets/input_text_field.dart';
import '../models/moderator_tools.dart';
import '../provider/moderation_settings_provider.dart';

class EditBannedScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = './editbanned';

  /// user name who will be banned
  final String? userName;

  /// all the info of banne
  Baninfo? bannedInfo;

  /// the current Subrddit name of the screen

  final String subredditName;
  EditBannedScreen(
      {super.key,
      this.userName = '',
      required this.subredditName,
      this.bannedInfo = null});

  @override
  State<EditBannedScreen> createState() => EditBannedScreenState();
}

class EditBannedScreenState extends State<EditBannedScreen> {
  /// Whether the banned user is  new or no the 3 inputs

  bool isNew = true;

  /// Whether fetching the data from server done or not

  bool fetchingDone = false;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  ///the title of the screen
  String title = 'Add a banned user';

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  /// Whether user enter data or not , then show the save buttom or not

  String reasonForBan = '';

  /// Whether the ban duration is permenant or not

  bool permenant = true;

  /// list of all rules in sub reddit to chose from it for ban reson
  List<Rules> rules = [];

  /// the description of the current subreddit
  List<String> rulesDescription = [];

  /// listener to the Username input field

  final inputUserNameController = TextEditingController();

  /// listener to the Mod note input field

  final inputModNoteController = TextEditingController();

  /// listener to the Duration input field

  final inputDurationController = TextEditingController();

  /// listener to the User note input field

  final inputUserNoteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.userName != '') {
      isNew = false;
    }
    if (isNew == false) {
      title = 'Show ban details';
      inputUserNameController.text = widget.userName!;
      reasonForBan = widget.bannedInfo!.punishType!;
      inputModNoteController.text = widget.bannedInfo!.note!;
      if (widget.bannedInfo!.duration == -1) {
        permenant = true;
      } else {
        permenant = false;
        inputDurationController.text = widget.bannedInfo!.duration.toString();
      }
      inputUserNoteController.text = widget.bannedInfo!.punishReason!;
    } else {
      widget.bannedInfo = Baninfo(
        note: '',
        punishReason: '',
        punishType: '',
        duration: 0,
      );
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      final provider =
          Provider.of<ModerationSettingProvider>(context, listen: false);

      provider.getCommunity(subredditName, context).then((value) {
        rules = provider.moderatorToolsModel!.rules!;
        rulesDescription = rules.map((Rules items) {
          return items.description!;
        }).toList();
        print(rules);
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  ///change the isSelcted when write data in input field
  ///
  ///when the UserNmae input field and reason both are empty then the selected will be false
  ///other wise it will be true

  void changNmaeReason() {
    /// this function will active only
    /// when the state is add new moderators
    /// input: none
    /// output: none

    if (inputUserNameController.text.isEmpty == false &&
        reasonForBan.isEmpty == false) {
      isSlected = true;
    } else {
      isSlected = false;
    }
  }

  ///clear the duration field if the check box of the permenation is select
  void changePermenant(bool changeedPermenant) {
    /// input:
    ///   changeedPermenant :-whether the changeedPermenant is true or not
    /// output: none

    if (isNew == true) {
      if (changeedPermenant == true) {
        inputDurationController.clear();
      }
      permenant = changeedPermenant;
    }
  }

  ///clear the permenant checkbox  when user write data in the input field

  void changeDuration() {
    /// input:  none
    /// output: none

    if (inputDurationController.text.isEmpty == false) {
      permenant = false;
    }
  }

  ///put the data from text field to model baninfo
  void prepareBanInfo() {
    /// input:  none
    /// output: none

    widget.bannedInfo!.punishType = reasonForBan;
    widget.bannedInfo!.note = inputModNoteController.text;
    widget.bannedInfo!.punishReason = inputUserNoteController.text;
    widget.bannedInfo!.duration = -1;
    if (permenant == false) {
      widget.bannedInfo!.duration = int.parse(inputDurationController.text);
    }
  }

  ///post the banned user  info to the backend server
  ///
  /// take the data from ban info model
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> addBaned() async {
    /// input:  none
    /// output: none

    prepareBanInfo();
    String sucessMessage =
        'bane ${inputUserNameController.text}  done succesfully';
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    await provider
        .addRemoveBanned(widget.subredditName, inputUserNameController.text,
            context, widget.bannedInfo!, true)
        .then((value) {});
    if (provider.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: sucessMessage, disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 2));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, BannedScreen.routeName,
          arguments: subredditName);
    }
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: (isSlected && isNew) ? addBaned : null,
              child: Text(
                'Add',
                style: TextStyle(
                    color: (isSlected && isNew)
                        ? Color.fromARGB(255, 56, 93, 164)
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InputTextField(
              hintText: 'username',
              upperLable: 'Username',
              inputUserNameController: inputUserNameController,
              isEnabled: isNew,
              onChange: () {
                changNmaeReason();
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 6, left: 12),
              child: Text(
                'Reson for ban',
                style: TextStyle(color: Color.fromARGB(255, 128, 127, 127)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 12,
                ),
                Container(
                  color: Color.fromARGB(255, 228, 231, 239),
                  child: Center(
                    child: DropdownButton(

                        // autofocus: true,
                        elevation: 0,
                        // Initial Value
                        value: (reasonForBan != '') ? reasonForBan : null,
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: rulesDescription.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (newValue) {
                          if (isNew) {
                            reasonForBan = (newValue as String);
                          }
                          changNmaeReason();
                          setState(() {});
                        }),
                  ),
                ),
              ],
            ),
            InputTextField(
              upperLable: 'Mod note',
              hintText: 'only mods will see this',
              inputUserNameController: inputModNoteController,
              isEnabled: isNew,
              onChange: () {
                setState(() {});
              },
            ),
            Row(
              children: [
                InputTextField(
                  width: 15.h,
                  upperLable: 'How long?',
                  hintText: '',
                  maxLenght: 7,
                  inputUserNameController: inputDurationController,
                  isEnabled: isNew,
                  keyboradType: TextInputType.number,
                  onChange: () {
                    changeDuration();
                    setState(() {});
                  },
                ),
                Text(
                  'Days',
                ),
                SizedBox(
                  width: 10.w,
                ),
                Checkbox(
                    checkColor: Colors.white,
                    value: permenant,
                    onChanged: (bool? value) {
                      setState(() {
                        changePermenant(value!);
                      });
                    }),
                Text('permanent')
              ],
            ),
            InputTextField(
              upperLable: 'Note to include in ban message',
              hintText: 'the user will recive this note in a message',
              inputUserNameController: inputUserNoteController,
              isEnabled: isNew,
              onChange: () {
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
