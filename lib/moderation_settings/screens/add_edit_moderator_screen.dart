import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/moderators.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import './moderators_screen.dart';
import '../widgets/input_text_field.dart';

class EditModeratorScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = './editmoderator';

  /// user name who will be Aadded as moderators

  final String? userName;

  /// all the permissions of the moderator

  final ModeratorPermissions? moderatorPermissions;

  /// the current Subrddit name of the screen

  final String subredditName;
  const EditModeratorScreen(
      {super.key,
      required this.subredditName,
      this.userName = '',
      this.moderatorPermissions = null});

  @override
  State<EditModeratorScreen> createState() => EditModeratorScreenState();
}

class EditModeratorScreenState extends State<EditModeratorScreen> {
  /// Whether the banned user is  new or no the 3 inputs

  bool isNew = true;

  ///the title of the screen

  String title = 'Add a moderator';

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  /// listener to the Username input field

  final inputUserNameController = TextEditingController();

  ///all permissions of the moderator
  ModeratorPermissions? permissions = ModeratorPermissions(
      all: true, access: true, config: true, flair: true, posts: true);

  @override
  void initState() {
    // TODO: implement initState
    if (widget.userName != '') {
      isNew = false;
    }
    if (isNew == false) {
      title = 'Edit permissions';
      inputUserNameController.text = widget.userName!;
      permissions!.all = widget.moderatorPermissions!.all;
      permissions!.access = widget.moderatorPermissions!.access;
      permissions!.config = widget.moderatorPermissions!.config;
      permissions!.flair = widget.moderatorPermissions!.flair;
      permissions!.posts = widget.moderatorPermissions!.posts;
    }
    super.initState();
  }

  ///change the isSelcted when write data in input field
  ///
  ///when the UserNmae input field  is empty then the selected will be false
  ///other wise it will be true

  void changeUserNmae() {
    /// this function will active only
    /// when the state is add new moderators
    /// input: none
    /// output: none

    if (inputUserNameController.text.isEmpty == false) {
      isSlected = true;
    } else {
      isSlected = false;
    }
  }

  ///select all permision be true when the all box selected
  void changePermossionAll(bool value) {
    /// input:
    ///    value:whether the all box selected or not
    /// output: none

    if (permissions!.all == false || value == true) {
      permissions!.access = true;
      permissions!.config = true;
      permissions!.flair = true;
      permissions!.posts = true;
    }
    permissions!.all = value;
    changePermissions();
  }

  ///control checkboxed when access box change
  ///
  ///if the new value be false then permissions all will be false
  ///if the new value will be true and other check boxes was true
  ///then make all box true
  void changePermossionAccess(bool value) {
    /// input:
    ///    value:whether the Access box selected or not
    /// output: none

    if (value == false) {
      permissions!.all = false;
    } else if (permissions!.flair == true &&
        permissions!.config == true &&
        permissions!.posts == true) {
      permissions!.all = true;
    }
    permissions!.access = value;
    changePermissions();
  }

  ///control checkboxed when flair box change
  ///
  ///if the new value be false then permissions all will be false
  ///if the new value will be true and other check boxes was true
  ///then make all box true

  void changePermossionFlair(bool value) {
    /// input:
    ///    value:whether the Flair box selected or not
    /// output: none

    if (value == false) {
      permissions!.all = false;
    } else if (permissions!.access == true &&
        permissions!.config == true &&
        permissions!.posts == true) {
      permissions!.all = true;
    }
    permissions!.flair = value;
    changePermissions();
  }

  ///control checkboxed when Config box change
  ///
  ///if the new value be false then permissions all will be false
  ///if the new value will be true and other check boxes was true
  ///then make all box true

  void changePermossionConfig(bool value) {
    /// input:
    ///    value:whether the Config box selected or not
    /// output: none

    if (value == false) {
      permissions!.all = false;
    } else if (permissions!.flair == true &&
        permissions!.access == true &&
        permissions!.posts == true) {
      permissions!.all = true;
    }
    permissions!.config = value;
    changePermissions();
  }

  ///control checkboxed when Posts box change
  ///
  ///if the new value be false then permissions all will be false
  ///if the new value will be true and other check boxes was true
  ///then make all box true

  void changePermossionPosts(bool value) {
    /// input:
    ///    value:whether the Posts box selected or not
    /// output: none

    if (value == false) {
      permissions!.all = false;
    } else if (permissions!.flair == true &&
        permissions!.config == true &&
        permissions!.access == true) {
      permissions!.all = true;
    }
    permissions!.posts = value;
    changePermissions();
  }

  ///chagne the isSelected when change any box
  ///
  ///if it is not the same as initiall , then is Selected will be true
  ///other wise will be false
  void changePermissions() {
    /// input: none
    /// output: none
    if (!isNew) {
      if (permissions!.flair != widget.moderatorPermissions!.flair ||
          permissions!.config != widget.moderatorPermissions!.config ||
          permissions!.all != widget.moderatorPermissions!.all ||
          permissions!.posts != widget.moderatorPermissions!.posts ||
          permissions!.access != widget.moderatorPermissions!.access) {
        isSlected = true;
      } else {
        isSlected = false;
      }
    }
  }

  ///post the new Moderator  info to the backend server
  ///
  /// take the data from input controller info and from permisions model
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> doneChanges() async {
    String sucessMessage;
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);

    if (isNew) {
      print('new moderator');
      sucessMessage = 'Invite ${inputUserNameController.text}  successfully';
      await provider
          .invideModerator(widget.subredditName, inputUserNameController.text,
              permissions!, context)
          .then((value) {});
    } else {
      sucessMessage =
          'change ${inputUserNameController.text} permissions successfully';
      await provider
          .changePermissionsModerator(widget.subredditName,
              inputUserNameController.text, permissions!, context)
          .then((value) {});
    }
    if (provider.isError == true) {
    } else {
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
      if (isNew == false) Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ModeratorsScreen.routeName,
          arguments: subredditName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [
        if (isNew)
          ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: isSlected ? doneChanges : null,
              child: Text(
                'Invite',
                style: TextStyle(
                    color: isSlected
                        ? Color.fromARGB(255, 56, 93, 164)
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        if (!isNew)
          ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: isSlected ? doneChanges : null,
              child: Text(
                'Save',
                style: TextStyle(
                    color: isSlected
                        ? Color.fromARGB(255, 56, 93, 164)
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
      ]),
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
                changeUserNmae();
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 6, left: 12),
              child: Text(
                'Permission',
                style: TextStyle(color: Color.fromARGB(255, 128, 127, 127)),
              ),
            ),
            Row(
              children: [
                Checkbox(
                    checkColor: Colors.white,
                    value: permissions!.all,
                    onChanged: (bool? value) {
                      setState(() {
                        changePermossionAll(value!);
                      });
                    }),
                Text('Full permissions')
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50.w,
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: permissions!.access,
                          onChanged: (bool? value) {
                            setState(() {
                              changePermossionAccess(value!);
                            });
                          }),
                      Text('Access')
                    ],
                  ),
                ),
                Container(
                  width: 50.w,
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: permissions!.config,
                          onChanged: (bool? value) {
                            setState(() {
                              changePermossionConfig(value!);
                            });
                          }),
                      Text('Config')
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Container(
                  width: 50.w,
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: permissions!.flair,
                          onChanged: (bool? value) {
                            setState(() {
                              changePermossionFlair(value!);
                            });
                          }),
                      Text('Flair')
                    ],
                  ),
                ),
                Container(
                  width: 50.w,
                  child: Row(
                    children: [
                      Checkbox(
                          checkColor: Colors.white,
                          value: permissions!.posts,
                          onChanged: (bool? value) {
                            setState(() {
                              changePermossionPosts(value!);
                            });
                          }),
                      Text('posts')
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
