import 'package:flutter/material.dart';
import '../../logins/models/status.dart';
import '../models/moderators.dart';
import '../widgets/alert_dialog.dart';
import '../../widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../widgets/location_list.dart';
import '../../icons/plus_icons.dart';
import '../widgets/moderators_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import 'add_edit_moderator_screen.dart';

class ModeratorsScreen extends StatefulWidget {
  static const routeName = '/moderators';

  const ModeratorsScreen({super.key});
  // postTypes({super.key});

  @override
  State<ModeratorsScreen> createState() => ModeratorsScreenState();
}

class ModeratorsScreenState extends State<ModeratorsScreen> {
  int index = 0;
  bool fetchingDone = true;
  bool _isInit = true;
  // ignore: non_constant_identifier_names
  List<Moderators>? moderators = [];
  List<Map<String, Object>> allModerators = [];
  List<Map<String, Object>> editableModerators = [];
  String userName = '';
  DateTime? userJoinDate;
  bool userFullPermisions = false;
  String subredditName = '';

  void extractModeratorsLists() {
    moderators!.forEach((element) {
      print(element);
      final _id = element.sId as String;
      final _userName = element.userName as String;
      String _joiningDate = '';
      String _permision = '';
      final _profilePicture = element.profilePicture;

      /// get the date as an one string
      final joiningDate = DateTime.parse(element.joiningDate as String);
      if (DateTime.now().year - joiningDate.year > 0) {
        _joiningDate = '${DateTime.now().year - joiningDate.year}yr';
      } else if (DateTime.now().month - joiningDate.month > 0) {
        _joiningDate = '${DateTime.now().month - joiningDate.month}mo';
      } else if (DateTime.now().day - joiningDate.day > 0) {
        _joiningDate = '${DateTime.now().day - joiningDate.day}day';
      } else if (DateTime.now().hour - joiningDate.hour > 0) {
        _joiningDate = '${DateTime.now().hour - joiningDate.hour}hr';
      } else {
        _joiningDate = '${DateTime.now().minute - joiningDate.minute}min';
      }

      /// get the permisions as an one string
      if (element.moderatorPermissions!.access == true) {
        _permision = '${_permision}access';
      }
      if (element.moderatorPermissions!.config == true) {
        _permision = '$_permision - config';
      }
      if (element.moderatorPermissions!.flair == true) {
        _permision = '$_permision - flair';
      }
      if (element.moderatorPermissions!.posts == true) {
        _permision = '$_permision - posts';
      }
      if (element.moderatorPermissions!.all == true) {
        _permision = 'Full permision';
      }
      allModerators.add({
        "_id": _id,
        "userName": _userName,
        "joiningDate": _joiningDate,
        "profilePicture": _profilePicture as String,
        "moderatorPermissions": _permision,
        "moderatorAllPermissions": element.moderatorPermissions!,
      });
      if (element.userName == userName) {
        userJoinDate = DateTime.parse(element.joiningDate!);
        userFullPermisions = element.moderatorPermissions!.all!;
      }
    });
    print(allModerators);
    if (userFullPermisions) {
      int index = 0;
      moderators!.forEach((element) {
        DateTime _elementTime = DateTime.parse(element.joiningDate!);
        if (element.userName == userName ||
            userJoinDate!.isBefore(_elementTime)) {
          editableModerators.add(allModerators[index]);
        }
        index = index + 1;
      });
    }
  }

  @override
  void initState() {
    // final provider =
    //     Provider.of<ModerationSettingProvider>(context, listen: false);
    // fetchingDone = false;
    // subredditName = provider.getSubredditName(context);
    // provider.getUserName().then((value) {
    //   userName = value;
    //   provider
    //       .getModerators(subredditName, UserCase.moderator, context)
    //       .then((value) {
    //     moderators = provider.moderators;
    //     print(moderators);
    //     extractModeratorsLists();
    //     fetchingDone = true;
    //     setState(() {});
    //   });
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      final provider =
          Provider.of<ModerationSettingProvider>(context, listen: false);
      fetchingDone = false;
      subredditName = provider.getSubredditName(context);
      provider.getUserName().then((value) {
        userName = value;
        provider
            .getUser(subredditName, UserCase.moderator, context)
            .then((value) {
          moderators = provider.moderators;
          print(moderators);
          extractModeratorsLists();
          fetchingDone = true;
          setState(() {});
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<String> getuserName() async {
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userName'));
    return prefs.getString('userName') as String;
  }

  @override
  Widget build(BuildContext context) {
    // userName();
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            appBar: AppBar(
              elevation: 0,
              title: Text('Moderators'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: CircleBorder()),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditModeratorScreen.routeName);
                    },
                    child: Icon(Plus.plus))
              ],
            ),
            body: SizedBox(
              height: 80.h,
              child: Column(
                children: [
                  // Text(name),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            index = 0;
                            setState(() {});
                          },
                          child: Text('All'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                index == 0 ? Colors.blue : Colors.white,
                            elevation: 0,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            index = 1;
                            setState(() {});
                          },
                          child: Text('Editable'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                index == 1 ? Colors.blue : Colors.white,
                            elevation: 0,
                          ),
                        ),
                      )
                    ],
                  ),
                  if (index == 0)
                    ModeratorsList(allModerator: allModerators, isEdit: false),
                  if (index == 1)
                    ModeratorsList(
                      allModerator: editableModerators,
                      isEdit: true,
                    ),
                ],
              ),
            ));
  }
}
