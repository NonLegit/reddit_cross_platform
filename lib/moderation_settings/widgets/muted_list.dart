import 'package:flutter/material.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../models/muted.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/penciel_icons.dart';
import '../../icons/settings_icons.dart';
import '../screens/add_edit_muted_screen.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MutedList extends StatefulWidget {
  final List<Map<String, Object>> allMuted;
  final String subredditname;
  MutedList({super.key, required this.allMuted, required this.subredditname});

  @override
  State<MutedList> createState() => _MutedListState();
}

class _MutedListState extends State<MutedList> {
  Future<void> deleteMute(int index) async {
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    String sucessMessage =
        'unmute ${widget.allMuted[index]['userName']}  done succesfully';
    print(sucessMessage);
    await provider
        .addRemoveMuted(
            widget.subredditname,
            widget.allMuted[index]['userName'] as String,
            context,
            widget.allMuted[index]['muteinfo'] as MuteInfo,
            false)
        .then((value) {});
    Navigator.pop(context);

    if (provider.isError == false) {
      widget.allMuted.removeAt(index);
      setState(() {});

      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false, text: sucessMessage, disableStatus: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (widget.allMuted.length == 0)
          ? Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  const Icon(
                    Icons.reddit,
                    size: 100,
                    color: Colors.grey,
                  ),
                  const Text(
                    'Wow,such empty',
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            )
          : ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemBuilder: (_, index) {
                final _id = widget.allMuted[index]['_id'] as String;
                final _userName = widget.allMuted[index]['userName'] as String;
                String _Date = widget.allMuted[index]['joiningDate'] as String;
                final _profilePicture =
                    widget.allMuted[index]['profilePicture'];
                final MuteInfo _muteInfo =
                    widget.allMuted[index]['muteinfo'] as MuteInfo;
                return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      // backgroundColor: Colors.red
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          OthersProfileScreen.routeName,
                          arguments: _userName);
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(_profilePicture as String),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(_userName),
                      subtitle: Text('$_Date '),
                      trailing: ThreeDotDownMenu(
                        cntx: context,
                        list: [
                          ElevatedButton(
                              onPressed: () {
                                print(_userName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditMutedScreen(
                                        subredditName: widget.subredditname,
                                        userName: _userName,
                                        mutedInfo: _muteInfo,
                                      ),
                                    ));
                              },
                              child: ListTile(
                                leading: Icon(Penciel.pencil),
                                title: Text('See details'),
                                trailing: Icon(Icons.arrow_forward),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed(
                                    OthersProfileScreen.routeName,
                                    arguments: _userName);
                              },
                              child: ListTile(
                                leading: Icon(SettingsIcons.account_circle),
                                title: Text('View profile'),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                deleteMute(index);
                              },
                              child: ListTile(
                                leading:
                                    Icon(Icons.volume_up, color: Colors.red),
                                title: Text(
                                  'Unmute',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ))
                        ],
                      ),
                    ));
              },
              itemCount: widget.allMuted.length,
            ),
    );
  }
}
