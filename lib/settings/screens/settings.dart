import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/icon_list_view.dart';
import '../widgets/title_text.dart';
import '../widgets/swich_list_view.dart';
import '../widgets/drop_down_list_view.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../models/types.dart';
import './account_settings.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);

class Settings extends StatelessWidget {
  static const routeName = '/Settings';

  const Settings({Key? key}) : super(key: key);
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
            IconButton(
              padding: EdgeInsets.only(right: 30),
              icon: Icon(Icons.arrow_back_outlined),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text('Settings'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(lable: 'GENERAL'),
            IconListView(
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Account settings',
              trailingIcon: Icon(Icons.arrow_forward_outlined),
              handler: () {
                // Navigator.of(context).pop(context);
                Navigator.of(context).pushNamed(AccountSettings.routeName);
              },
            ),
            TitleText(lable: 'FEED options '),
            DorpDownListView(
              sheetList: [
                {
                  'icon': Icon(Icons.rocket),
                  'title': 'Best',
                  'selected': false
                },
                {
                  'icon': Icon(SettingsIcons.fire_station),
                  'title': 'Hot',
                  'selected': false
                },
                {
                  'icon': Icon(SettingsIcons.north_star),
                  'title': 'New',
                  'selected': false
                },
                {
                  'icon': Icon(SettingsIcons.up_outline),
                  'title': 'Top',
                  'selected': false
                },
              ],

              /// this string will come from the internal storage of the device
              choosenElement: '',
              leadingIcon: Icon(Icons.home_outlined),
              title: 'Sort home posts by',
              trailingIcon: Icon(Icons.arrow_forward),
              choosenIndex: IntWrapper(),
              listType: TypeStaus.icons,
            ),
            TitleText(lable: 'View Options '),
            DorpDownListView(
              sheetList: [
                {
                  'icon': Icon(Icons.rocket),
                  'title': 'Alwayes',
                  'selected': true
                },
                {
                  'icon': Icon(Icons.fireplace_outlined),
                  'title': 'Never',
                  'selected': false
                },
              ],

              /// this string will come from the internal storage of the device
              choosenElement: '',
              leadingIcon: Icon(SettingsIcons.triangle_right),
              title: 'Autoplay',
              trailingIcon: Icon(Icons.arrow_forward),
              choosenIndex: IntWrapper(),
              listType: TypeStaus.selected,
            ),
            SwichListView(
              choosen: true,
              leadingIcon: Icon(SettingsIcons.account_circle),
              title: 'Show NSFW content (i\'m over 18)',
            ),
          ],
        ),
      ),
    );
  }
}
