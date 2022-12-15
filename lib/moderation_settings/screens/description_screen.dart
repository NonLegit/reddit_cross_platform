import 'package:flutter/material.dart';
import '../../settings/widgets/setting_text_input.dart';
import '../../logins/models/status.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import 'package:provider/provider.dart';
import '../provider/moderation_settings_provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/loading_reddit.dart';

class Description extends StatefulWidget {
  static const routeName = '/description';
  const Description({super.key});

  @override
  State<Description> createState() => DescriptionState();
}

class DescriptionState extends State<Description> {
  // TextEditingController descriptionController = TextEditingController();
  String descriptionController = '';
  InputStatus descriptionStatus = InputStatus.original;

  String? initialDescription;
  String? subbredditName;
  bool isSlected = false;
  ModeratorToolsModel? moderatorToolsModel;

  ///change the status of password input field
  ///
  ///make it taped or oreignal according to the focus listner
  void changeDescriptionFocus(focus) {
    descriptionStatus = (focus) ? InputStatus.taped : InputStatus.original;
  }

  void changeDescription(value) {
    descriptionController = value;
    print(descriptionController);
    if (descriptionController == initialDescription) {
      isSlected = false;
    } else {
      isSlected = true;
    }
  }

  Future<void> saveDescription() async {
    ////
    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({"description": '$descriptionController'},
        subbredditName!).then((response) {});

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

  bool fetchingDone = false;
  bool _isInit = true;

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
          .getCommunity(subbredditName!)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        initialDescription = moderatorToolsModel!.description;
        print(initialDescription);
        setState(() {
          fetchingDone = true;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
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
