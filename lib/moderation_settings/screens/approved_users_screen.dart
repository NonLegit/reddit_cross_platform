import 'package:flutter/material.dart';
import '../../widgets/loading_reddit.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../provider/moderation_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';
import '../../icons/plus_icons.dart';
import '../widgets/approved_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user.dart';
import '../models/approved.dart';
import './add_edit_aproved_screen.dart';

class ApprovedScreen extends StatefulWidget {
  static const routeName = '/approved';

  const ApprovedScreen({super.key});
  // postTypes({super.key});

  @override
  State<ApprovedScreen> createState() => ApprovedScreenState();
}

class ApprovedScreenState extends State<ApprovedScreen> {
  bool fetchingDone = true;
  bool _isInit = true;
  bool isBuild = false;
  // ignore: non_constant_identifier_names
  List<Approved>? approved = [];
  List<Map<String, Object>> allapproved = [];
  String subredditName = '';

  void extractApproved() {
    approved!.forEach((element) {
      print(element);
      final _id = element.user!.sId as String;
      final _userName = element.user!.userName as String;
      String _joiningDate = '';
      final _profilePicture = element.user!.profilePicture;

      /// get the date as an one string
      final date = DateTime.parse(element.approvedDate as String);
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

      allapproved.add({
        "_id": _id,
        "userName": _userName,
        "approvedDate": _joiningDate,
        "profilePicture": _profilePicture as String,
      });
    });
    print(allapproved);
  }

  @override
  void initState() {
    fetchingDone = false;
    // final provider =
    //     Provider.of<ModerationSettingProvider>(context, listen: false);

    // subredditName = provider.getSubredditName(context);
    // provider.getUser(subredditName, UserCase.approved, context).then((value) {
    //   approved = provider.approved;
    //   print(approved);
    //   extractApproved();
    //   fetchingDone = true;
    //   if (isBuild) setState(() {});
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
      subredditName = provider.getSubredditName(context);
      provider.getUser(subredditName, UserCase.approved, context).then((value) {
        approved = provider.approved;
        print(approved);
        extractApproved();
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
              title: Text('Approved users'),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0, shape: CircleBorder()),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditApprovedScreen(
                              subredditName: subredditName,
                            ),
                          ));
                    },
                    child: Icon(Plus.plus))
              ],
            ),
            body: Column(
              children: [
                // Container(height: 10.h, color: Colors.red),
                ApprovedList(
                  allapproved: allapproved,
                  subredditName: subredditName,
                ),
              ],
            ));
  }
}
