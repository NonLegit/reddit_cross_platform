import 'package:flutter/material.dart';
import '../../widgets/loading_reddit.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../icons/plus_icons.dart';
import '../widgets/banned_list.dart';
import '../models/user.dart';
import '../models/banned.dart';
import 'add_edit_banned_screen.dart';

class BannedScreen extends StatefulWidget {
  /// the route name of the screen

  static const routeName = '/banned';

  const BannedScreen({super.key});

  @override
  State<BannedScreen> createState() => BannedScreenState();
}

class BannedScreenState extends State<BannedScreen> {
  /// Whether fetching the data from server done or not

  bool fetchingDone = true;

  /// Whether the didChangeDependencies is called for the first time or not

  bool _isInit = true;

  /// Whether the build fuction calling at least one time or not

  bool isBuild = false;

  /// list of all banned users in sub reddit comming from the provider
  List<Banned>? banned = [];

  ///banned users as map to be send to edit screen

  List<Map<String, Object>> allbanned = [];

  /// the current Subrddit name of the screen

  String subredditName = '';

  ///prepare the map all banned from the list banned

  void extractBanned() {
    banned!.forEach((element) {
      print(element);
      final _id = element.sId as String;
      final _userName = element.userName as String;
      String _banDate = '';
      Baninfo _baninfo = element.baninfo!;
      final _profilePicture = element.profilePicture;

      /// get the date as an one string
      final banDate = DateTime.parse(element.banDate as String);
      if (DateTime.now().year - banDate.year > 0) {
        _banDate = '${DateTime.now().year - banDate.year}yr';
      } else if (DateTime.now().month - banDate.month > 0) {
        _banDate = '${DateTime.now().month - banDate.month}mo';
      } else if (DateTime.now().day - banDate.day > 0) {
        _banDate = '${DateTime.now().day - banDate.day}day';
      } else if (DateTime.now().hour - banDate.hour > 0) {
        _banDate = '${DateTime.now().hour - banDate.hour}hr';
      } else {
        _banDate = '${DateTime.now().minute - banDate.minute}min';
      }
      _banDate += (_baninfo.duration == -1)
          ? ' ( permenant)'
          : ' (${_baninfo.duration.toString()} days) ';
      allbanned.add({
        "_id": _id,
        "userName": _userName,
        "banDate": _banDate,
        "profilePicture": _profilePicture as String,
        "baninfo": _baninfo,
      });
    });
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
      provider.getUser(subredditName, UserCase.banned, context).then((value) {
        banned = provider.banned;
        print(banned);
        extractBanned();
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
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Color.fromARGB(255, 228, 231, 239),
            appBar: AppBar(
              elevation: 0,
              title: Text('Banned users'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: CircleBorder()),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditBannedScreen(
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
                // Container(height: 10.h, color: Colors.red),

                BannedList(allBaned: allbanned, subredditName: subredditName),
              ],
            ),
          );
  }
}
