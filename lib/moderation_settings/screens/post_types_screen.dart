import 'package:flutter/material.dart';
import '../widgets/status.dart';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import 'package:provider/provider.dart';
import '../provider/moderation_settings_provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/loading_reddit.dart';
import '../../settings/widgets/swich_list_view.dart';

class PostTypesScreen extends StatefulWidget {
  /// the route name of the screen
  static const routeName = '/posttypes';
  // postTypes({super.key});

  @override
  State<PostTypesScreen> createState() => PostTypesScreenState();
}

class PostTypesScreenState extends State<PostTypesScreen> {
  /// the current status of the post type input field
  InputStatus postTypesStatus = InputStatus.original;

  /// the inital value of the post type in the subreddit
  String? initialpostTypes;

  /// the current Subrddit name of the screen

  String? subbredditName;

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  ///model will be filed from the provider to take the data

  ModeratorToolsModel? moderatorToolsModel;

  /// Whether the inital value of allow image check box is selected or not

  bool initialAllowImages = false;

  /// Whether the inital value of allow videos check box is selected or not

  bool initialAllowVideos = false;

  /// Whether the inital value of allow links check box is selected or not

  bool initialAllowLinks = false;

  /// Whether the current allow image check box is selected or not

  bool allowImages = false;

  /// Whether the current allow videos check box is selected or not

  bool allowVideos = false;

  /// Whether the current allow links check box is selected or not

  bool allowLinks = false;

  /// Whether fetching the data from server done or not

  bool fetchingDone = false;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  /// toggle the value of allow image swich
  void changeAllowImage() {
    /// input:  none
    /// output: none

    allowImages = !allowImages;
    changePostTypes();
  }

  /// toggle the value of allow videos swich

  void changeAllowVideos() {
    /// input:  none
    /// output: none

    allowVideos = !allowVideos;
    changePostTypes();
  }

  /// toggle the value of allow links swich

  void changeAllowLinks() {
    /// input:  none
    /// output: none

    allowLinks = !allowLinks;
    changePostTypes();
  }

  ///change the isSelcted when change the values of the thre swiches
  ///
  ///when the any one from the 3 swiches changed from the inital state
  ///then the is Selected will be true
  ///other wise it will be true

  void changePostTypes() {
    /// input:  none
    /// output: none

    if (allowImages == initialAllowImages &&
        allowVideos == initialAllowVideos &&
        allowLinks == initialAllowLinks) {
      isSlected = false;
    } else {
      isSlected = true;
    }
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      subbredditName = ModalRoute.of(context)?.settings.arguments != null
          ? ModalRoute.of(context)?.settings.arguments as String
          : '';
      // subbredditName = 'Cooking';
      Provider.of<ModerationSettingProvider>(context, listen: false)
          .getCommunity(subbredditName!, context)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;

        initialAllowImages = moderatorToolsModel!.allowImages!;
        initialAllowVideos = moderatorToolsModel!.allowVideos!;
        initialAllowLinks = moderatorToolsModel!.allowLinks!;
        allowImages = initialAllowImages;
        allowVideos = initialAllowVideos;
        allowLinks = initialAllowLinks;
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  /// post the post type changes to the sever
  ///
  /// take the data from variables allowVideos-allowLinks-allowImages
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> savepostTypes() async {
    /// input:  none
    /// output: none
    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({
      "allowImages": '$allowImages',
      "allowVideos": '$allowVideos',
      "allowLinks": '$allowLinks'
    }, subbredditName!, context).then((response) {});

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
            text: 'change postTypes succefuly',
            disableStatus: true),
      );
      await Future.delayed(const Duration(seconds: 1));
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;

    // Future<void> getpostTypes = preparepostTypes();
    // initialpostTypes = 'asd';
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
                title: Text('postTypes'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: isSlected ? savepostTypes : null,
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
              body: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwichListView(
                    choosen: allowImages,
                    leadingIcon: null,
                    title: 'Image posts',
                    subtitle:
                        'Allow images to be aploaded in posts in your subreddit',
                    changeSwiching: () {
                      changeAllowImage();
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwichListView(
                    choosen: allowVideos,
                    leadingIcon: null,
                    title: 'Videos posts',
                    subtitle:
                        'Allow Videos to be aploaded in posts in your subreddit',
                    changeSwiching: () {
                      changeAllowVideos();
                      setState(() {});
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SwichListView(
                    choosen: allowLinks,
                    leadingIcon: null,
                    title: 'Links posts',
                    subtitle:
                        'Allow Links to be aploaded in posts in your subreddit',
                    changeSwiching: () {
                      changeAllowLinks();
                      setState(() {});
                    },
                  ),
                ),
              ]),
            ),
    );
  }
}
