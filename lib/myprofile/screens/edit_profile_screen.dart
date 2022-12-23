import 'package:flutter/material.dart';
import '../../moderation_settings/widgets/input_text_field.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:provider/provider.dart';
import '../../settings/provider/user_settings_provider.dart';

//import 'package:flutter_code_style/analysis_options.yaml';
class EditProfileScreen extends StatefulWidget {
  static const routeName = '/editprofile';
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Future<void> saveDescription() async {
    ////
    final provider = Provider.of<UserSettingsProvider>(context, listen: false);
    await provider.ChangePrefs({
      "displayName": '${inputUserNameController.text}',
      "description": '${inputNoteController.text}'
    }, context)
        .then((response) {});

    if (provider.isError == true) {
      // ignore: use_build_context_synchronously
      // ScaffoldMessenger.of(context).showSnackBar(
      //   CustomSnackBar(
      //       isError: true, text: provider.errorMessage, disableStatus: true),
      // );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change your profiel data succefuly',
            disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 1));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  bool isNew = true;
  String title = 'Add a muted user';
  bool isSlected = true;
  final inputUserNameController = TextEditingController();
  final inputNoteController = TextEditingController();
  void changeUserName(value) {
    // inputUserNameController = value;
    // print(descriptionController);
    // if (descriptionController == initialDescription) {
    //   isSlected = false;
    // } else {
    //   isSlected = true;
    // }
  }

  Future<void> doneChanges() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EditScreen'),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(elevation: 0),
              onPressed: (isSlected) ? saveDescription : null,
              child: Text(
                'SAVE',
                style: TextStyle(
                    color: isSlected
                        ? Color.fromARGB(255, 56, 93, 164)
                        : Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InputTextField(
            hintText: 'shown in your profiel page',
            upperLable: 'Display name',
            inputUserNameController: inputUserNameController,
            isEnabled: true,
            onChange: () {
              setState(() {});
            },
            maxLenght: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'this will be displayed to viewers of your profile page and dosnt change your username',
              style: TextStyle(color: Colors.black),
            ),
          ),
          InputTextField(
            hintText: 'alittle description for your self',
            upperLable: 'About you',
            inputUserNameController: inputNoteController,
            isEnabled: true,
            onChange: () {
              setState(() {});
            },
            maxLenght: 200,
          ),
        ],
      ),
    );
  }
}
