import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../models/muted.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import './muted_user_screen.dart';
import '../widgets/input_text_field.dart';

class EditMutedScreen extends StatefulWidget {
  /// user name who will be muted

  final String? userName;

  /// model carry the data of muted

  MuteInfo? mutedInfo;

  /// the current Subrddit name of the screen

  final String subredditName;

  /// the route name of the screen

  static const routeName = './editmuted';
  EditMutedScreen(
      {super.key,
      required this.subredditName,
      this.userName = '',
      this.mutedInfo = null});

  @override
  State<EditMutedScreen> createState() => EditMutedScreenState();
}

class EditMutedScreenState extends State<EditMutedScreen> {
  bool isNew = true;
  String title = 'Add a muted user';
  bool isSlected = false;
  final inputUserNameController = TextEditingController();
  final inputNoteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    if (widget.userName != '') {
      isNew = false;
    }
    if (isNew == false) {
      title = 'Show mute details';
      inputUserNameController.text = widget.userName!;
      inputNoteController.text = widget.mutedInfo!.muteMessage!;
    } else {
      widget.mutedInfo = MuteInfo(muteMessage: '');
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

  /// post the Muted  info to the backend server
  ///
  /// take the data from input controller info and from Mute model
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> doneChanges() async {
    String sucessMessage;
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    print('new Muted');
    sucessMessage = 'Mute ${inputUserNameController.text}  done succesfully';
    print(widget.mutedInfo!.muteMessage);
    await provider
        .addRemoveMuted(widget.subredditName, inputUserNameController.text,
            context, widget.mutedInfo!, true)
        .then((value) {});
    if (provider.isError == false) {
      print('sucess');
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: sucessMessage, disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 2));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.pushNamed(context, MutedScreen.routeName,
          arguments: subredditName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: (isSlected && isNew) ? doneChanges : null,
              child: Text(
                'Add',
                style: TextStyle(
                    color: isSlected
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
                changeUserNmae();
                setState(() {});
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Mod note about why they were muted',
                style: TextStyle(color: Colors.black),
              ),
            ),
            InputTextField(
              hintText: 'For other mods to know why this user has been muted',
              upperLable: 'Note visible to user',
              inputUserNameController: inputNoteController,
              isEnabled: isNew,
              onChange: () {
                widget.mutedInfo?.muteMessage = inputNoteController.text;
                // print(inputNoteController.text);
                // print('----------------------------');
                // print(widget.mutedInfo?.muteMessage);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }
}
