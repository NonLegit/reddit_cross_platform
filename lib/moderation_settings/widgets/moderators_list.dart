import 'package:flutter/material.dart';
import 'package:post/moderation_settings/models/moderators.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/penciel_icons.dart';
import '../../icons/settings_icons.dart';
import '../screens/add_edit_moderator_screen.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ModeratorsList extends StatefulWidget {
  final List<Map<String, Object>> allModerator;
  final bool isEdit;
  final String subredditName;
  ModeratorsList(
      {super.key,
      required this.allModerator,
      required this.subredditName,
      this.isEdit = false});

  @override
  State<ModeratorsList> createState() => _ModeratorsListState();
}

class _ModeratorsListState extends State<ModeratorsList> {
  Future<void> deleteModerator(int index) async {
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    String sucessMessage =
        'remove ${widget.allModerator[index]['userName']}  from moderators';
    print(sucessMessage);
    await provider
        .deleteModerator(
          widget.subredditName,
          widget.allModerator[index]['userName'] as String,
          context,
        )
        .then((value) {});
    Navigator.pop(context);

    if (provider.isError == false) {
      widget.allModerator.removeAt(index);
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
      child: (widget.allModerator.length == 0)
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
                final _id = widget.allModerator[index]['_id'] as String;
                final _userName =
                    widget.allModerator[index]['userName'] as String;
                String _Date =
                    widget.allModerator[index]['joiningDate'] as String;
                final profilePicture =
                    widget.allModerator[index]['profilePicture'];
                final _permision =
                    widget.allModerator[index]['moderatorPermissions'];
                final ModeratorPermissions _allPermision =
                    widget.allModerator[index]['moderatorAllPermissions']
                        as ModeratorPermissions;
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
                        backgroundImage: NetworkImage(profilePicture as String),
                        backgroundColor: Colors.black,
                      ),
                      title: Text(_userName),
                      subtitle: Text('$_Date  / $_permision'),
                      trailing: (widget.isEdit)
                          ? ThreeDotDownMenu(
                              cntx: context,
                              list: [
                                ElevatedButton(
                                    onPressed: () {
                                      print(_userName);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                EditModeratorScreen(
                                              subredditName:
                                                  widget.subredditName,
                                              userName: _userName,
                                              moderatorPermissions:
                                                  _allPermision,
                                            ),
                                          ));
                                    },
                                    child: ListTile(
                                      leading: Icon(Penciel.pencil),
                                      title: Text('Edit permission'),
                                      trailing: Icon(Icons.arrow_forward),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          OthersProfileScreen.routeName,
                                          arguments: _userName);
                                    },
                                    child: ListTile(
                                      leading:
                                          Icon(SettingsIcons.account_circle),
                                      title: Text('View profile'),
                                    )),
                                ElevatedButton(
                                    onPressed: () {
                                      deleteModerator(index);
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.highlight_remove,
                                          color: Colors.red),
                                      title: Text(
                                        'Remove',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ))
                              ],
                            )
                          : null,
                    ));
              },
              itemCount: widget.allModerator.length,
            ),
    );
  }
}
