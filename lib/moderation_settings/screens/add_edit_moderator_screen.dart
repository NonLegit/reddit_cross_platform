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
  final String? userName;
  // final Baninfo? bannedInfo;
  final ModeratorPermissions? moderatorPermissions;
  // final String subreddit;
  final String subredditName;

  static const routeName = './editmoderator';
  const EditModeratorScreen(
      {super.key,
      required this.subredditName,
      // required this.subreddit,
      this.userName = '',
      this.moderatorPermissions = null});

  @override
  State<EditModeratorScreen> createState() => _EditModeratorScreenState();
}

class _EditModeratorScreenState extends State<EditModeratorScreen> {
  bool isNew = true;
  String title = 'Add a moderator';
  bool isSlected = false;
  final inputUserNameController = TextEditingController();
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

      print(inputUserNameController.text);
    }
    super.initState();
  }

  void changeUserNmae() {
    /// this function will active only
    /// when the state is add new moderators
    if (inputUserNameController.text.isEmpty == false) {
      isSlected = true;
    } else {
      isSlected = false;
    }
  }

  void changePermossionAll(bool value) {
    if (permissions!.all == false || value == true) {
      permissions!.access = true;
      permissions!.config = true;
      permissions!.flair = true;
      permissions!.posts = true;
    }
    permissions!.all = value;
    changePermissions();
  }

  void changePermossionAccess(bool value) {
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

  void changePermossionFlair(bool value) {
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

  void changePermossionConfig(bool value) {
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

  void changePermossionPosts(bool value) {
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

  void changePermissions() {
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
      print('falied');
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   CustomSnackBar(
      //       isError: true, text: provider.errorMessage, disableStatus: true),
      // );
    } else {
      // ignore: use_build_context_synchronously
      print('sucess');
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: sucessMessage, disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 2));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      if (isNew == false) Navigator.of(context).pop();
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
