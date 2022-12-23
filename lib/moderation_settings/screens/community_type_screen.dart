import 'package:flutter/material.dart';
import '../widgets/status.dart';
import '../widgets/alert_dialog.dart';
import '../models/moderator_tools.dart';
import 'package:provider/provider.dart';
import '../provider/moderation_settings_provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../widgets/loading_reddit.dart';
import 'package:flutter/cupertino.dart';

class ComuunityTypesScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/communitytypes';

  @override
  State<ComuunityTypesScreen> createState() => ComuunityTypesScreenState();
}

class ComuunityTypesScreenState extends State<ComuunityTypesScreen> {
  ///values of text and color and sub title for the slider
  ///these values will be used when cahnge the value of the slider
  final sliderValues = [
    {
      'color': Colors.green,
      'title': 'Public',
      'subTitle': 'Anyone can see and participate in this community'
    },
    {
      'color': Color.fromARGB(255, 175, 172, 76),
      'title': 'Restricted',
      'subTitle':
          'Anyone can see, join or vote in this cmmunity, but you control who posts and comments.'
    },
    {
      'color': Colors.red,
      'title': 'Private',
      'subTitle':
          'Only people you approved can see and participate in this community'
    }
  ];

  ///the curret status of the post type input
  InputStatus postTypesStatus = InputStatus.original;

  ///the initiall value of the post type text unput
  String? initialpostTypes;

  /// the current Subrddit name of the screen

  String? subbredditName;

  /// Whether user enter data or not , then show the save buttom or not

  bool isSlected = false;

  ///model will be filed from the provider to take the data
  ModeratorToolsModel? moderatorToolsModel;

  ///the initiall value of the index of the slider

  double initialIndex = 1;

  ///the initiall value of the plus 18

  bool initialIsPlus18 = false;

  ///the initiall value index

  double index = 1;

  /// Whether the plus 18 box selected or not

  bool isPlus18 = false;

  /// Whether fetching the data from server done or not

  bool fetchingDone = true;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  /// change the index of the slider
  void changeType(newIndex) {
    ///Input:
    /// newindex : the new value of the index
    ///output: none

    index = newIndex;
    changeCommunityType();
  }

  /// change the pluse 18

  void changePlus18() {
    /// input:  none
    /// output: none

    isPlus18 = !isPlus18;
    changeCommunityType();
  }

  ///change the isSelcted when change the slider and is plus 18
  ///
  ///when the UserNmae input field and reason both are empty then the selected will be false
  ///other wise it will be true
  void changeCommunityType() {
    /// input:  none
    /// output: none

    if (index == initialIndex && isPlus18 == initialIsPlus18) {
      isSlected = false;
    } else {
      isSlected = true;
    }
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
      Provider.of<ModerationSettingProvider>(context, listen: false)
          .getCommunity(subbredditName!, context)
          .then((_) {
        moderatorToolsModel =
            Provider.of<ModerationSettingProvider>(context, listen: false)
                .moderatorToolsModel;
        String? type = moderatorToolsModel!.type!;
        for (int i = 0; i < sliderValues.length; i += 1) {
          if (sliderValues[i]['title'] == type) {
            initialIndex = i.toDouble();
            break;
          }
        }
        initialIsPlus18 = moderatorToolsModel!.nsfw!;
        index = initialIndex;
        isPlus18 = initialIsPlus18;
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  ///post the community type changes to the sever
  ///
  /// take the data from ban info model
  /// if the server return failed response then there is error message will appare
  /// other show sucess message

  Future<void> saveCommunityTypes() async {
    /// input:  none
    /// output: none

    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);
    await provider.patchCommunity({
      "type": sliderValues[index.toInt()]['title'],
      "nsfw": isPlus18,
    }, subbredditName!, context).then((response) {});
    if (provider.isError == true) {
    } else {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change Community tepe succefuly',
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
                title: Text('Community type'),
                actions: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 0),
                      onPressed: isSlected ? saveCommunityTypes : null,
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
              body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SliderTheme(
                      data: const SliderThemeData(
                        // activeTrackColor: Colors.green,

                        trackHeight: 5.0,
                        thumbShape:
                            RoundSliderThumbShape(enabledThumbRadius: 15.0),
                      ),
                      child: Slider(
                        thumbColor:
                            sliderValues[index.toInt()]['color'] as Color,
                        activeColor:
                            sliderValues[index.toInt()]['color'] as Color,
                        inactiveColor: Colors.grey[350],
                        divisions: (sliderValues.length - 1),
                        min: 0,
                        max: (sliderValues.length - 1).toDouble(),
                        value: index,
                        onChanged: (value) {
                          changeType(value);
                          setState(() {});
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        sliderValues[index.toInt()]['title'] as String,
                        style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                            color:
                                sliderValues[index.toInt()]['color'] as Color),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        sliderValues[index.toInt()]['subTitle'] as String,
                        style: TextStyle(fontSize: 21),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 20.0),
                      child: Divider(
                        thickness: 1,
                        // color: Colors.black26,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(elevation: 0),
                        onPressed: () {
                          changePlus18();
                          setState(() {});
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '18+ community',
                              style: TextStyle(
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CupertinoSwitch(
                              thumbColor: Colors.white,
                              activeColor: Colors.blue,
                              value: isPlus18,
                              onChanged: (_) {
                                changePlus18();
                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
    );
  }
}
