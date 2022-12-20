import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../widgets/input_text_field.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import './approved_users_screen.dart';

class EditApprovedScreen extends StatefulWidget {
  // final String? userName;
  // final Baninfo? bannedInfo;
  static const routeName = './editapproved';
  final String subredditName;
  const EditApprovedScreen({super.key, required this.subredditName});
  @override
  State<EditApprovedScreen> createState() => _EditApprovedScreenState();
}

class _EditApprovedScreenState extends State<EditApprovedScreen> {
  bool isSlected = false;
  final inputUserNameController = TextEditingController();
  void changeUserNmae() {
    /// this function will active only
    /// when the state is add new moderators
    if (inputUserNameController.text.isEmpty == false) {
      isSlected = true;
    } else {
      isSlected = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> submitApproved() async {
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    await provider
        .addRemoveApproved(
            widget.subredditName, inputUserNameController.text, context, true)
        .then((value) {});
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
            isError: false,
            text: 'Add ${inputUserNameController.text} as approved succefuly',
            disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 2));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Navigator.pushNamed(context, ApprovedScreen.routeName,
          arguments: subredditName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add an approved user'), actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(elevation: 0),
            onPressed: isSlected ? submitApproved : null,
            child: Text(
              'Add',
              style: TextStyle(
                  color: isSlected
                      ? Color.fromARGB(255, 56, 93, 164)
                      : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            )),
      ]),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          InputTextField(
            hintText: 'Username',
            upperLable: 'Username',
            inputUserNameController: inputUserNameController,
            isEnabled: true,
            onChange: () {
              changeUserNmae();
              setState(() {});
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'this user will be able to submit sontent to your community',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromARGB(255, 128, 127, 127),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
