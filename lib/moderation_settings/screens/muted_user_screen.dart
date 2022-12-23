import 'package:flutter/material.dart';
import '../../widgets/loading_reddit.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../icons/plus_icons.dart';
import '../widgets/muted_list.dart';
import '../models/user.dart';
import '../models/muted.dart';
import 'add_edit_muted_screen.dart';

class MutedScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/muted';

  const MutedScreen({super.key});

  @override
  State<MutedScreen> createState() => MutedScreenState();
}

class MutedScreenState extends State<MutedScreen> {
  /// Whether fetching the data from server done or not

  bool fetchingDone = true;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  /// list of all Muted from the provider
  List<Muted>? muted = [];

  ///list of all Muted to this subreddit to show in muted list screen

  List<Map<String, Object>> allmuted = [];

  ///the name of the current subreddit

  String subredditName = '';

  ///prepare the map allmuted  from the list muted
  ///
  ///process the data like prpare the data as String in formate %yr of %mon
  ///and prepare the muted info model for each user
  ///and fill the editable moderators list
  ///and prepare the _profilePicture of the each user

  void extractmuted() {
    ///Input: none
    ///output: none

    muted!.forEach((element) {
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
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });
      final provider =
          Provider.of<ModerationSettingProvider>(context, listen: false);

      subredditName = provider.getSubredditName(context);
      provider.getUser(subredditName, UserCase.muted, context).then((value) {
        muted = provider.muted;
        extractmuted();
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
    return (!fetchingDone)
        ? const LoadingReddit()
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditMutedScreen(
                              subredditName: subredditName,
                            ),
                          ));
                    },
                    child: Icon(Plus.plus))
              ],
            ),
            body: Column(
              children: [
                // Text(name),
                MutedList(
                  allMuted: allmuted,
                  subredditname: subredditName,
                ),
              ],
            ),
          );
  }
}
