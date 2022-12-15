import 'package:flutter/material.dart';
import 'package:post/moderation_settings/models/moderators.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/penciel_icons.dart';
import '../../icons/settings_icons.dart';
import '../screens/add_edit_moderator_screen.dart';

class ModeratorsList extends StatelessWidget {
  final List<Map<String, Object>> allModerator;
  final bool isEdit;
  ModeratorsList({super.key, required this.allModerator, this.isEdit = false});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final _id = allModerator[index]['_id'] as String;
        final _userName = allModerator[index]['userName'] as String;
        String _Date = allModerator[index]['joiningDate'] as String;
        final profilePicture = allModerator[index]['profilePicture'];
        final _permision = allModerator[index]['moderatorPermissions'];
        final ModeratorPermissions _allPermision = allModerator[index]
            ['moderatorAllPermissions'] as ModeratorPermissions;
        return ElevatedButton(
            style: ElevatedButton.styleFrom(
              elevation: 0,
              // backgroundColor: Colors.red
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(OthersProfileScreen.routeName,
                  arguments: _userName);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profilePicture as String),
                backgroundColor: Colors.black,
              ),
              title: Text(_userName),
              subtitle: Text('$_Date  / $_permision'),
              trailing: (isEdit)
                  ? ThreeDotDownMenu(
                      cntx: context,
                      list: [
                        ElevatedButton(
                            onPressed: () {
                              print(_userName);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditModeratorScreen(
                                      userName: _userName,
                                      moderatorPermissions: _allPermision,
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
                              leading: Icon(SettingsIcons.account_circle),
                              title: Text('Virw profile'),
                            )),
                        ElevatedButton(
                            onPressed: () {},
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
      itemCount: allModerator.length,
    );
  }
}
