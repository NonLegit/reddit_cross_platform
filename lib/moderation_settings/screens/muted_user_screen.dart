import 'package:flutter/material.dart';
import '../widgets/alert_dialog.dart';
import '../../widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../icons/plus_icons.dart';
import '../widgets/muted_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/muted.dart';
import 'add_edit_muted_screen.dart';

class MutedScreen extends StatefulWidget {
  static const routeName = '/muted';

  const MutedScreen({super.key});
  // postTypes({super.key});

  @override
  State<MutedScreen> createState() => MutedScreenState();
}

class MutedScreenState extends State<MutedScreen> {
  bool fetchingDone = true;
  bool _isInit = true;
  // ignore: non_constant_identifier_names
  List<Muted>? muted = [];
  List<Map<String, Object>> allmuted = [];
  String subredditName = '';

  void extractmuted() {
    muted!.forEach((element) {
      print(element);
      final _id = element.sId as String;
      final _userName = element.userName as String;
      String _joiningDate = '';
      MuteInfo _muteinfo = element.muteInfo!;
      final _profilePicture = element.profilePicture;

      /// get the date as an one string
      final date = DateTime.parse(element.joiningDate as String);
      if (DateTime.now().year - date.year > 0) {
        _joiningDate = '${DateTime.now().year - date.year}yr';
      } else if (DateTime.now().month - date.month > 0) {
        _joiningDate = '${DateTime.now().month - date.month}mo';
      } else if (DateTime.now().day - date.day > 0) {
        _joiningDate = '${DateTime.now().day - date.day}day';
      } else if (DateTime.now().hour - date.hour > 0) {
        _joiningDate = '${DateTime.now().hour - date.hour}hr';
      } else {
        _joiningDate = '${DateTime.now().minute - date.minute}min';
      }

      allmuted.add({
        "_id": _id,
        "userName": _userName,
        "joiningDate": _joiningDate,
        "profilePicture": _profilePicture as String,
        "muteinfo": _muteinfo,
      });
    });
    print(allmuted);
  }

  @override
  void initState() {
    fetchingDone = false;
    final provider =
        Provider.of<ModerationSettingProvider>(context, listen: false);

    subredditName = provider.getSubredditName(context);
    provider
        .getUser(subredditName, UserCase.muted, context)
        .then((value) {
      muted = provider.muted;
      print(muted);
      extractmuted();
      fetchingDone = true;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            appBar: AppBar(
              elevation: 0,
              title: Text('muted users'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: CircleBorder()),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EditMutedScreen.routeName);
                    },
                    child: Icon(Plus.plus))
              ],
            ),
            body: SizedBox(
              height: 80.h,
              child: Column(
                children: [
                  // Text(name),

                  MutedList(allMuted: allmuted),
                ],
              ),
            ));
  }
}
