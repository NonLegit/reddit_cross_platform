import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/icon_list_view.dart';
import '../widgets/title_text.dart';
import '../widgets/swich_list_view.dart';
import '../widgets/drop_down_list_view.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../models/types.dart';
import '../../icons/google_facebook_icons.dart';
import './blocked_accounts.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);

class AccountSettings extends StatelessWidget {
  static const routeName = '/AccountSettings';

  const AccountSettings({Key? key}) : super(key: key);
  void showSheet(BuildContext cntx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: cntx,
      builder: (_) {
        return Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('Best'), Text('Hot'), Text('New')]);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 228, 231, 239),
      appBar: AppBar(
        title: Row(
          children: [
            // IconButton(
            //   padding: EdgeInsets.only(right: 30),
            //   icon: Icon(Icons.arrow_back_outlined),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            Text('Account settings'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(lable: 'BASIC SETTINGS'),
            IconListView(
              leadingIcon: Icon(Icons.settings),
              title: 'Update email address',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {},
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.settings),
              title: 'Add password',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {},
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.location_on_outlined),
              title: 'Country',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {},
              onlyIconPressed: false,
            ),
            DorpDownListView(
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Gender',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              choosenIndex: IntWrapper(),
              choosenElement: 'man',
              listType: TypeStaus.selected,
              sheetList: [
                {'title': 'man', 'selected': false},
                {'title': 'woman', 'selected': false},
              ],
            ),
            TitleText(lable: 'CONNECTED ACCOUNTS'),
            IconListView(
              leadingIcon: Icon(GoogleFacebookIcons.google),
              title: 'Google',
              trailingIcon: Text(
                'Connect',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onlyIconPressed: true,
              handler: () {},
            ),
            IconListView(
              leadingIcon: Icon(GoogleFacebookIcons.facebook),
              title: 'Facebook',
              trailingIcon: Text(
                'Connect',
                style: TextStyle(color: Colors.blue[900]),
              ),
              onlyIconPressed: true,
              handler: () {},
            ),
            TitleText(lable: 'BLOCKING AND PERMISSIONS'),
            IconListView(
              leadingIcon: Icon(Icons.block_flipped),
              title: 'Manged blocked accounts',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                Navigator.of(context).pushNamed(BlockedAccounts.routeName);
              },
            ),
            SwichListView(
              choosen: true,
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Allow people to follow you',
              subtitle:
                  'followers will be notified about posts you mak to your profile and see them in their home feed',
            ),
          ],
        ),
      ),
    );
  }
}
