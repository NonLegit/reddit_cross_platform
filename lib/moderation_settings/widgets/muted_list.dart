import 'package:flutter/material.dart';
import '../../other_profile/screens/others_profile_screen.dart';
import '../models/muted.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/penciel_icons.dart';
import '../../icons/settings_icons.dart';
import '../screens/add_edit_muted_screen.dart';

class MutedList extends StatelessWidget {
  final List<Map<String, Object>> allMuted;
  MutedList({super.key, required this.allMuted});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final _id = allMuted[index]['_id'] as String;
        final _userName = allMuted[index]['userName'] as String;
        String _Date = allMuted[index]['joiningDate'] as String;
        final _profilePicture = allMuted[index]['profilePicture'];
        final MuteInfo _muteInfo = allMuted[index]['muteinfo'] as MuteInfo;
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
                        title: Text('Virw profile'),
                      )),
                  ElevatedButton(
                      onPressed: () {},
                      child: ListTile(
                        leading: Icon(Icons.volume_up, color: Colors.red),
                        title: Text(
                          'Unmute',
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            ));
      },
      itemCount: allMuted.length,
    );
  }
}
