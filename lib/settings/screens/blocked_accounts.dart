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

// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/BlockedAccounts';

  const BlockedAccounts({Key? key}) : super(key: key);

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
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
            Text('Blocked accounts'),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleText(lable: 'BASIC SETTINGS'),
            TitleText(lable: 'CONNECTED ACCOUNTS'),
            TitleText(lable: 'BLOCKING AND PERMISSIONS'),
          ],
        ),
      ),
    );
  }
}
