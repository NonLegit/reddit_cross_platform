import 'package:flutter/material.dart';
import '../../settings/widgets/setting_text_input.dart';
import '../widgets/status.dart';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import 'package:provider/provider.dart';
import '../provider/moderation_settings_provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/loading_reddit.dart';

class Description extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/description';
  const Description({super.key});

  @override
  State<Description> createState() => DescriptionState();
}

class DescriptionState extends State<Description> {
  //the value that will be puth in the description at the first
  String descriptionController = '';

  /// the current status of the description input field
  InputStatus descriptionStatus = InputStatus.original;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  /// the initiall value of the description
  String? initialDescription;

  /// the current Subrddit name of the screen

  String? subbredditName;

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  ///model will be filed from the provider to take the data

  ModeratorToolsModel? moderatorToolsModel;

  /// Whether fetching the data from server done or not

  bool fetchingDone = false;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  ///change the status of descriton input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changeDescriptionFocus(focus) {
    descriptionStatus = (focus) ? InputStatus.taped : InputStatus.original;
  }

  ///change the isSelcted when change the descriptopn input
  ///
  ///when the descrition is the same as the initall
  ///other wise it will be true

  void changeDescription(value) {
    descriptionController = value;
    if (descriptionController == initialDescription) {
      isSlected = false;
    } else {
      isSlected = true;
    }
  }

  ///post the Descrition  to the sever
  ///
  /// take the data from descriptionController
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> saveDescription() async {
    /// input:  none
    /// output: none

    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({"description": '$descriptionController'},
        subbredditName!, context).then((response) {});

    if (provider.isError == true) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: true, text: provider.errorMessage, disableStatus: true),
      );
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change description succefuly',
            disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 1));

      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  void initState() {
    //return hardcoded topics from constant folder
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      subbredditName = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as String
          : '';

      ///should remove when end the mock server

      // subbredditName = 'Cooking';
      Provider.of<ModerationSettingProvider>(context, listen: false)
          .getCommunity(subbredditName!, context)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        initialDescription = moderatorToolsModel!.description;
        print(initialDescription);
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;

    // Future<void> getDescription = prepareDescription();
    // initialDescription = 'asd';
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = isSlected
            ? await showDialog<bool>(
                context: context,
                builder: ((context) {
                  return const AlertDialog1();
                }),
              )
            : true;
        return shouldPop!;
      },
      child: (!fetchingDone)
          ? const LoadingReddit()
          //Calls TopicMainScreen widget to build Topics Screen
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                elevation: 0,
                title: Text('Description'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: isSlected ? saveDescription : null,
                      child: Text(
                        'Save',
                        style: TextStyle(
                            color: isSlected
                                ? Color.fromARGB(255, 56, 93, 164)
                                : Colors.lightBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ))
                ],
              ),
              body: Center(
                child: SettingTextInput(
                  changeInput: (value) {
                    changeDescription(value);
                    setState(() {});
                  },
                  currentStatus: descriptionStatus,
                  ontap: (focus) {
                    changeDescriptionFocus(focus);
                    setState(() {});
                  },
                  lable: 'Describe your community',
                  // inputController: descriptionController,
                  maxLength: 500,
                  minLines: 1,
                  maxLines: 50,
                  initialValue: initialDescription,
                ),
              ),
            ),
    );
  }
}
