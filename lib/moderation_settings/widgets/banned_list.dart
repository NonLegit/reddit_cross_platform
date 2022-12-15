import 'package:flutter/material.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../models/banned.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/settings_icons.dart';
import '../../icons/penciel_icons.dart';
import '../screens/add_edit_banned_screen.dart';

class BannedList extends StatelessWidget {
  final List<Map<String, Object>> allBaned;
  BannedList({super.key, required this.allBaned});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final _id = allBaned[index]['_id'] as String;
        final _userName = allBaned[index]['userName'] as String;
        String _Date = allBaned[index]['banDate'] as String;
        final _profilePicture = allBaned[index]['profilePicture'];
        final Baninfo _baninfo = allBaned[index]['baninfo'] as Baninfo;
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
                backgroundImage: NetworkImage(_profilePicture as String),
                backgroundColor: Colors.black,
              ),
              title: Text('u/$_userName'),
              subtitle: Text('$_Date /${_baninfo.punishReason!}'),
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
                        title: Text('Virw profile'),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: ListTile(
                        leading:
                            Icon(Icons.unpublished_outlined, color: Colors.red),
                        title: Text(
                          'Unban',
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            ));
      },
      itemCount: allBaned.length,
    );
  }
}
