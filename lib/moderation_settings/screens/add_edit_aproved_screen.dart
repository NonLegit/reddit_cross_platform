import 'package:flutter/material.dart';
import 'package:post/networks/const_endpoint_data.dart';
import '../widgets/input_text_field.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import './approved_users_screen.dart';

class EditApprovedScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = './editapproved';

  /// the current Subrddit name of the screen

  final String subredditName;
  const EditApprovedScreen({super.key, required this.subredditName});
  @override
  State<EditApprovedScreen> createState() => EditApprovedScreenState();
}

class EditApprovedScreenState extends State<EditApprovedScreen> {
  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  /// listener to the Username input field

  final inputUserNameController = TextEditingController();

  ///change the isSelcted when write data in input field
  ///
  ///when the input field is empty then the selected will be false
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

  ///post the Approved user  info to the backend server
  ///
  /// take the data from inputs listener and sent it to the server
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> submitApproved() async {
    ///input : none
    ///output : none
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    await provider
        .addRemoveApproved(
            widget.subredditName, inputUserNameController.text, context, true)
        .then((value) {});
    if (provider.isError == true) {
    } else {
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
