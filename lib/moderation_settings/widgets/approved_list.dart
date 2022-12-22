import 'package:flutter/material.dart';
// import 'package:post/notification/screens/messages_main_screen.dart';
import '../../messages/screens/new_message_screen.dart';
import '../../other_profile/screens/others_profile_screen.dart';
// import '../../notification/widgets/three_dots_widget.dart';
import '../widgets/three_dot_down_menu.dart';
import '../../icons/settings_icons.dart';
import 'package:provider/provider.dart';
import '../provider/change_user_management.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ApprovedList extends StatefulWidget {
  final List<Map<String, Object>> allapproved;
  final String subredditName;
  ApprovedList(
      {super.key, required this.subredditName, required this.allapproved});

  @override
  State<ApprovedList> createState() => _ApprovedListState();
}

class _ApprovedListState extends State<ApprovedList> {
  Future<void> deleteApproved(int index) async {
    final provider =
        Provider.of<ChangeUserManagementProvider>(context, listen: false);
    String sucessMessage =
        'unApprove ${widget.allapproved[index]['userName']}  done succesfully';
    print(sucessMessage);
    await provider
        .addRemoveApproved(widget.subredditName,
            widget.allapproved[index]['userName'] as String, context, false)
        .then((value) {});
    Navigator.pop(context);
    if (provider.isError == false) {
      widget.allapproved.removeAt(index);
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
      child: (widget.allapproved.length == 0)
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
                final _id = widget.allapproved[index]['_id'] as String;
                final _userName =
                    widget.allapproved[index]['userName'] as String;
                String _Date =
                    widget.allapproved[index]['approvedDate'] as String;
                final profilePicture =
                    widget.allapproved[index]['profilePicture'];
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
                                title: Text('View profile'),
                              )),
                          ElevatedButton(
                              onPressed: () {
                                deleteApproved(index);
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
                      ),
                    ));
              },
              itemCount: widget.allapproved.length,
            ),
    );
  }
}
