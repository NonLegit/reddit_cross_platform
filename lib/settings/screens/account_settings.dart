import 'package:flutter/material.dart';
import 'package:post/settings/screens/change_email.dart';
import 'package:post/settings/screens/change_password.dart';
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
import '../../icons/arrow_head_down_word_icons.dart';
import './choose_country.dart';
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
        title: Text('Account settings'),
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
              handler: () {
                Navigator.of(context).pushNamed(ChangeEmail.routeName);
              },
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.settings),
              title: 'Change password',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                Navigator.of(context).pushNamed(ChangePassword.routeName);
              },
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.location_on_outlined),
              title: 'Country',
              subtitle: 'Select the country you live in.',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                Navigator.of(context).pushNamed(ChooseCountry.routeName);
              },
              onlyIconPressed: false,
            ),
            DorpDownListView(
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Gender',
              trailingIcon: Container(
                width: 3.5.w,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(ArrowHeadDownWord.down_open)),
              ),
              choosenIndex: IntWrapper(),
              choosenElement: 'Man',
              listType: TypeStaus.selected,
              sheetList: [
                {'title': 'Man', 'selected': false},
                {'title': 'Woman', 'selected': false},
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
