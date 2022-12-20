import 'package:flutter/material.dart';
import 'package:post/icons/arrow_head_down_word_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/icon_list_view.dart';
import '../widgets/title_text.dart';
import '../widgets/swich_list_view.dart';
import '../widgets/drop_down_list_view.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../models/types.dart';
import './account_settings.dart';
import '../provider/user_settings_provider.dart';

import 'package:provider/provider.dart';
import '../models/all_prefrence.dart';
import '../../widgets/loading_reddit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../logins/screens/login.dart';
import '../../logins/providers/authentication.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
import '../../widgets/custom_snack_bar.dart';

class Settings extends StatefulWidget {
  static const routeName = '/Settings';
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;

  bool showNSFW = true;
  bool autoPlay = true;
  String SorthomePosts = 'Best';
  UserSettingsProvider? provider = null;
  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      provider = Provider.of<UserSettingsProvider>(context, listen: false);
      provider!.getAllPrefs(context).then((value) {
        provider!.userPrefrence;
        print(provider!.userPrefrence);
        fetchingDone = true;
        SorthomePosts = provider!.userPrefrence!.sortHomePosts!;
        autoPlay = provider!.userPrefrence!.autoplayMedia!;
        showNSFW = provider!.userPrefrence!.adultContent!;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> changeSortHome(String newValue) async {
  

    SorthomePosts = newValue;
    print('$SorthomePosts');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('sortHomePosts', SorthomePosts);
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(
          isError: false,
          text: 'change sort home posts successfuly',
          disableStatus: true),
    );
  }

  Future<void> changeAutoPlay(String newValue) async {
    autoPlay = newValue == 'Alwayes';
    provider!.userPrefrence!.autoplayMedia = autoPlay;
    print(autoPlay);
    provider!.ChangePrefs(provider!.userPrefrence!.toJson(), context);
    // provider
    if (provider!.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change auto play succefuhly',
            disableStatus: true),
      );
    }
  }

  Future<void> changeNSFW() async {
    showNSFW = !showNSFW;
    provider!.userPrefrence!.adultContent = showNSFW;
    print(showNSFW);
    provider!.ChangePrefs(provider!.userPrefrence!.toJson(), context);
    if (provider!.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change NSFW settings succefuhly',
            disableStatus: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(lable: 'GENERAL'),
                  IconListView(
                    leadingIcon: Icon(SettingsIcons.account_circle),
                    title: 'Account settings',
                    trailingIcon: Icon(Icons.arrow_forward_outlined),
                    handler: () {
                      // Navigator.of(context).pop(context);
                      // Navigator.of(context)
                      //     .pushNamed(AccountSettings.routeName);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AccountSettings(provider: provider)),
                      );
                    },
                  ),
                  TitleText(lable: 'FEED options '),
                  DorpDownListView(
                    changeChoosen: (String newValue) {
                      changeSortHome(newValue);
                    },
                    sheetList: [
                      {
                        'icon': Icon(Icons.rocket),
                        'title': 'Best',
                        'selected': false
                      },
                      {
                        'icon': Icon(SettingsIcons.fire_station),
                        'title': 'Hot',
                        'selected': false
                      },
                      {
                        'icon': Icon(SettingsIcons.north_star),
                        'title': 'New',
                        'selected': false
                      },
                      {
                        'icon': Icon(SettingsIcons.up_outline),
                        'title': 'Top',
                        'selected': false
                      },
                    ],

                    /// this string will come from the internal storage of the device
                    choosenElement: SorthomePosts,
                    leadingIcon: Icon(Icons.home_outlined),
                    title: 'Sort home posts by',
                    trailingIcon: Container(
                      width: 3.5.w,
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(ArrowHeadDownWord.down_open)),
                    ),
                    choosenIndex: IntWrapper(),
                    listType: TypeStaus.icons,
                  ),
                  TitleText(lable: 'View Options '),
                  DorpDownListView(
                    changeChoosen: (newValue) {
                      changeAutoPlay(newValue);
                    },
                    sheetList: [
                      {
                        'icon': Icon(Icons.rocket),
                        'title': 'Alwayes',
                        'selected': true
                      },
                      {
                        'icon': Icon(Icons.fireplace_outlined),
                        'title': 'Never',
                        'selected': false
                      },
                    ],

                    /// this string will come from the internal storage of the device
                    choosenElement: (autoPlay) ? 'ALwayes' : 'Never',
                    leadingIcon: Icon(SettingsIcons.triangle_right),
                    title: 'Autoplay',
                    trailingIcon: Container(
                      width: 3.5.w,
                      child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Icon(ArrowHeadDownWord.down_open)),
                    ),
                    choosenIndex: IntWrapper(),
                    listType: TypeStaus.selected,
                  ),
                  SwichListView(
                    changeSwiching: () {
                      changeNSFW();
                    },
                    choosen: showNSFW,
                    leadingIcon: Icon(SettingsIcons.account_circle),
                    title: 'Show NSFW content (i\'m over 18)',
                  ),
                ],
              ),
            ),
          );
  }
}
