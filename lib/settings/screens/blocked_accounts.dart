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
  void getBlockedAcounts() async {
    // blockedAcounts =
    // [
    //   {
    //     'imageUrl':
    //         'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
    //     'name': 'ahmed',
    //     'isBlock': BoolWrapper()
    //   },
    //   {
    //     'imageUrl':
    //         'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
    //     'name': 'yasser',
    //     'isBlock': BoolWrapper()
    //   },
    //   {
    //     'imageUrl':
    //         'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
    //     'name': 'yasser',
    //     'isBlock': BoolWrapper()
    //   }
    // ];
  }
//  ScaffoldMessenger.of(context).showSnackBar(
//             CustomSnackBar(
//                 isError: false,
//                 text:
//                     'Add ${inputUserNameController.text} as approved succefuly',
//                 disableStatus: true),
//           );
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
    getBlockedAcounts();
    return (!fetchingDone)
        ? const LoadingReddit()
        //Calls TopicMainScreen widget to build Topics Screen
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: Text('Blocked accounts'),
            ),
            body: ListView.builder(
              itemBuilder: (_, index) {
                return BlockedAccountItem(
                  imageUrl: blockedAcounts[index]['imageUrl'] as String,
                  name: blockedAcounts[index]['name'] as String,
                  isBlock: blockedAcounts[index]['isBlock'] as BoolWrapper,
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
