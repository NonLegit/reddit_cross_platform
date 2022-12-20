import 'package:flutter/material.dart';
// import 'package:post/notification/screens/messages_main_screen.dart';
import '../../messages/screens/new_message_screen.dart';
import '../../other_profile/screens/others_profile_screen.dart';
// import '../../notification/widgets/three_dots_widget.dart';
import '../../messages/screens/message_main_screen.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/settings_icons.dart';

class ApprovedList extends StatelessWidget {
  final List<Map<String, Object>> allapproved;
  ApprovedList({super.key, required this.allapproved});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        final _id = allapproved[index]['_id'] as String;
        final _userName = allapproved[index]['userName'] as String;
        String _Date = allapproved[index]['joiningDate'] as String;
        final profilePicture = allapproved[index]['profilePicture'];
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
              subtitle: Text('$_Date  '),
              trailing: ThreeDotDownMenu(
                cntx: context,
                list: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                            NewMessageScreen.routeName,
                            arguments: _userName);
                      },
                      child: ListTile(
                        leading: Icon(Icons.email),
                        title: Text('Send messsage'),
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
                            Icon(Icons.highlight_remove, color: Colors.red),
                        title: Text(
                          'Remove',
                          style: TextStyle(color: Colors.red),
                        ),
                      ))
                ],
              ),
            ));
      },
      itemCount: allapproved.length,
    );
  }
}
