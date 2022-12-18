import 'package:flutter/material.dart';
import 'package:post/logins/providers/authentication.dart';
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
import '../provider/user_settings_provider.dart';
import 'package:provider/provider.dart';
import '../../widgets/custom_snack_bar.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);

class AccountSettings extends StatefulWidget {
  static const routeName = '/AccountSettings';
  final UserSettingsProvider? provider;

  AccountSettings({Key? key, this.provider}) : super(key: key);

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  Future<void> changeGender(String newValue) async {
    widget.provider?.userPrefrence!.gender = newValue;
    await widget.provider!
        .ChangePrefs(widget.provider!.userPrefrence!.toJson(), context);
    setState(() {});
    if (widget.provider!.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change your gender succefuhly',
            disableStatus: true),
      );
    }
  }

  Future<void> allowPeopleFllow() async {
    widget.provider!.userPrefrence!.canbeFollowed =
        !widget.provider!.userPrefrence!.canbeFollowed!;
    await widget.provider!
        .ChangePrefs(widget.provider!.userPrefrence!.toJson(), context);
    setState(() {});
    if (widget.provider!.isError == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'change allow fllowing you  succefuhly',
            disableStatus: true),
      );
    }
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangeEmail(
                            provider: widget.provider,
                          )),
                );
              },
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.settings),
              title: 'Change password',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChangePassword(
                            provider: widget.provider,
                          )),
                );
              },
              onlyIconPressed: false,
            ),
            IconListView(
              leadingIcon: Icon(Icons.location_on_outlined),
              title: 'Country',
              subtitle: 'Select the country you live in.',
              trailingIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.provider!.userPrefrence!.country!),
                  Icon(Icons.arrow_forward_outlined),
                ],
              ),
              handler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChooseCountry(
                            provider: widget.provider,
                            handler: () {
                              setState(() {});
                            },
                          )),
                );
              },
              onlyIconPressed: false,
            ),
            DorpDownListView(
              changeChoosen: (newValue) {
                changeGender(newValue);
              },
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Gender',
              trailingIcon: Container(
                width: 3.5.w,
                child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Icon(ArrowHeadDownWord.down_open)),
              ),
              choosenIndex: IntWrapper(),
              choosenElement: widget.provider!.userPrefrence!.gender!,
              listType: TypeStaus.selected,
              sheetList: [
                {'title': 'male', 'selected': false},
                {'title': 'female', 'selected': false},
              ],
            ),
            // TitleText(lable: 'CONNECTED ACCOUNTS'),
            // IconListView(
            //   leadingIcon: Icon(GoogleFacebookIcons.google),
            //   title: 'Google',
            //   trailingIcon: Text(
            //     'Connect',
            //     style: TextStyle(color: Colors.blue[900]),
            //   ),
            //   onlyIconPressed: true,
            //   handler: () {},
            // ),
            // IconListView(
            //   leadingIcon: Icon(GoogleFacebookIcons.facebook),
            //   title: 'Facebook',
            //   trailingIcon: Text(
            //     'Connect',
            //     style: TextStyle(color: Colors.blue[900]),
            //   ),
            //   onlyIconPressed: true,
            //   handler: () {},
            // ),
            TitleText(lable: 'BLOCKING AND PERMISSIONS'),
            IconListView(
              leadingIcon: Icon(Icons.block_flipped),
              title: 'Manged blocked accounts',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => BlockedAccounts(
                            provider: widget.provider,
                          )),
                );
              },
            ),
            SwichListView(
              changeSwiching: () {
                allowPeopleFllow();
              },
              choosen: widget.provider!.userPrefrence!.canbeFollowed!,
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
