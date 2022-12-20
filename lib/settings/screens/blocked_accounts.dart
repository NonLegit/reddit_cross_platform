import 'package:flutter/material.dart';
import 'package:post/main.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../widgets/icon_list_view.dart';
import '../widgets/title_text.dart';
import '../widgets/swich_list_view.dart';
import '../widgets/drop_down_list_view.dart';
import '../../models/wrapper.dart';
import '../../icons/settings_icons.dart';
import '../models/types.dart';
import '../../icons/google_facebook_icons.dart';
import '../widgets/blocked_account_item.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);
import '../provider/user_settings_provider.dart';
import 'package:provider/provider.dart';
import '../models/blocked_users.dart';
import '../../widgets/loading_reddit.dart';
import '../../widgets/custom_snack_bar.dart';

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/BlockedAccounts';
  late final UserSettingsProvider? provider;

  BlockedAccounts({Key? key, this.provider}) : super(key: key);

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  bool fetchingDone = true;

  bool _isInit = true;

  bool isBuild = false;

  List<Map<String, Object>> blockedAcounts = [];

  void handler(index) async {
    if ((blockedAcounts[index]['isBlock'] as BoolWrapper).b == true) {
      await widget.provider!.blockUnblock(
          blockedAcounts[index]['name'] as String, context, false);
    } else {
      await widget.provider!
          .blockUnblock(blockedAcounts[index]['name'] as String, context, true);
    }
    if (widget.provider!.isError == false) {
      String block = '';
      if ((blockedAcounts[index]['isBlock'] as BoolWrapper).b == false) {
        block = 'blocking';
      } else {
        block = 'unblocking';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            isError: false,
            text: 'you $block ${blockedAcounts[index]['name']}  succefuhly',
            disableStatus: true),
      );
      (blockedAcounts[index]['isBlock'] as BoolWrapper).b =
          !(blockedAcounts[index]['isBlock'] as BoolWrapper).b;
      setState(() {});
    }
  }

  @override
  void didChangeDependencies() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (_isInit) {
      setState(() {
        fetchingDone = false;
      });

      widget.provider!.getAllBlocked(context).then((value) {
        for (int i = 0;
            i < widget.provider!.allBlockedUsers!.blocked!.length;
            i = i + 1) {
          blockedAcounts.add({
            'imageUrl':
                widget.provider!.allBlockedUsers!.blocked![i].profilePicture!,
            'name': widget.provider!.allBlockedUsers!.blocked![i].userName!,
            'isBlock': BoolWrapper(b: true)
          });
        }
        print(widget.provider!.allBlockedUsers!.blocked!.length);
        print(blockedAcounts.length);
        fetchingDone = true;
        if (isBuild) setState(() {});
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isBuild = true;
    return (!fetchingDone)
        ? const LoadingReddit()
        :
        //Calls TopicMainScreen widget to build Topics Screen
        Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Blocked accounts'),
            ),
            body: (blockedAcounts.length == 0)
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
                    itemBuilder: (_, index) {
                      return BlockedAccountItem(
                        imageUrl: blockedAcounts[index]['imageUrl'] as String,
                        name: blockedAcounts[index]['name'] as String,
                        isBlock:
                            blockedAcounts[index]['isBlock'] as BoolWrapper,
                        handler: () {
                          handler(index);
                        },
                      );
                    },
                    itemCount: blockedAcounts.length,
                  ),
          );
  }
}
