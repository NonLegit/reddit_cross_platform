import 'package:flutter/material.dart';
import '../../settings/widgets/setting_text_input.dart';
import '../../logins/models/status.dart';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import 'package:provider/provider.dart';
import '../provider/moderation_settings_provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/loading_reddit.dart';
import '../../settings/widgets/swich_list_view.dart';

class PostTypesScreen extends StatefulWidget {
  static const routeName = '/posttypes';
  // postTypes({super.key});

  @override
  State<PostTypesScreen> createState() => PostTypesScreenState();
}

class PostTypesScreenState extends State<PostTypesScreen> {
  // TextEditingController postTypesController = TextEditingController();
  InputStatus postTypesStatus = InputStatus.original;

  String? initialpostTypes;
  String? subbredditName;
  bool isSlected = false;
  ModeratorToolsModel? moderatorToolsModel;

  bool initialAllowImages = false;
  bool initialAllowVideos = false;
  bool initialAllowLinks = false;

  bool allowImages = false;
  bool allowVideos = false;
  bool allowLinks = false;

  bool fetchingDone = false;
  bool _isInit = true;
  bool isBuild = false;
  void changeAllowImage() {
    allowImages = !allowImages;
    changePostTypes();
  }

  void changeAllowVideos() {
    allowVideos = !allowVideos;
    changePostTypes();
  }

  void changeAllowLinks() {
    allowLinks = !allowLinks;
    changePostTypes();
  }

  void changePostTypes() {
    if (allowImages == initialAllowImages &&
        allowVideos == initialAllowVideos &&
        allowLinks == initialAllowLinks) {
      isSlected = false;
    } else {
      isSlected = true;
    }
  }

  // void change
  @override
  void initState() {
    //return hardcoded topics from constant folder
    super.initState();
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

  Future<void> savepostTypes() async {
    ////
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
