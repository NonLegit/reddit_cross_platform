import 'package:flutter/material.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../models/banned.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/settings_icons.dart';
import '../../icons/penciel_icons.dart';
import '../screens/add_edit_banned_screen.dart';
// import '../../notification/widgets/three_dots_widget.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BannedList extends StatefulWidget {
  final List<Map<String, Object>> allBaned;
  final String subredditName;
  BannedList({super.key, required this.subredditName, required this.allBaned});

  @override
  State<BannedList> createState() => _BannedListState();
}

class _BannedListState extends State<BannedList> {
  Future<void> deleteBaned(int index) async {
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    String sucessMessage =
        'unban ${widget.allBaned[index]['userName']}  done succesfully';
    print(sucessMessage);
    await provider
        .addRemoveBanned(
            widget.subredditName,
            widget.allBaned[index]['userName'] as String,
            context,
            widget.allBaned[index]['baninfo'] as Baninfo,
            false)
        .then((value) {});
    Navigator.pop(context);
    if (provider.isError == false) {
      widget.allBaned.removeAt(index);
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
      child: (widget.allBaned.length == 0)
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
                final _id = widget.allBaned[index]['_id'] as String;
                final _userName = widget.allBaned[index]['userName'] as String;
                String _Date = widget.allBaned[index]['banDate'] as String;
                final _profilePicture =
                    widget.allBaned[index]['profilePicture'];
                final Baninfo _baninfo =
                    widget.allBaned[index]['baninfo'] as Baninfo;
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
                      title: Text('u/$_userName'),
                      subtitle: Text('$_Date /${_baninfo.note!}'),
                      trailing: ThreeDotDownMenu(
                        cntx: context,
                        list: [
                          ElevatedButton(
                              onPressed: () {
                                print(_userName);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditBannedScreen(
                                        subredditName: widget.subredditName,
                                        userName: _userName,
                                        bannedInfo: _baninfo,
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
                                deleteBaned(index);
                              },
                              child: ListTile(
                                leading: Icon(Icons.unpublished_outlined,
                                    color: Colors.red),
                                title: Text(
                                  'Unban',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ))
                        ],
                      ),
                    ));
              },
              itemCount: widget.allBaned.length,
            ),
    );
  }
}
