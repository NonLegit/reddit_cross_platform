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
import '../widgets/blocked_account_item.dart';
// Navigator.of(context).pushNamed(homeLayoutScreen.routeName);

class BlockedAccounts extends StatefulWidget {
  static const routeName = '/BlockedAccounts';

  const BlockedAccounts({Key? key}) : super(key: key);

  @override
  State<BlockedAccounts> createState() => _BlockedAccountsState();
}

class _BlockedAccountsState extends State<BlockedAccounts> {
  List<Map<String, Object>> blockedAcounts = [];
  void getBlockedAcounts() async {
    blockedAcounts = [
      {
        'imageUrl':
            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
        'name': 'ahmed',
        'isBlock': BoolWrapper()
      },
      {
        'imageUrl':
            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
        'name': 'yasser',
        'isBlock': BoolWrapper()
      },
      {
        'imageUrl':
            'https://scontent.fcai19-6.fna.fbcdn.net/v/t1.18169-9/14731344_1268156939902850_4843578088361110846_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_eui2=AeEky4_3cTAH8AsHcH3UuXIKcLp-k-70xXVwun6T7vTFdcArTit-okcWlHaag26qfJeWLi2DDiYbw59pVU7sfWCM&_nc_ohc=1XlYxiGxy8EAX-_d8zz&_nc_oc=AQkYQ6qW4jQladaWIoltd2OvIh0LwAsNJpWkk9LpRsxmsvIEkKee_v9W2b0tH2sw1E0&_nc_ht=scontent.fcai19-6.fna&oh=00_AfBJHNRDkpnbmnXua9NObdrBX7KltBX87QLOKzmJdENzBg&oe=63B555D2',
        'name': 'yasser',
        'isBlock': BoolWrapper()
      }
    ];
  }

  void handler(index) async {
    (blockedAcounts[index]['isBlock'] as BoolWrapper).b =
        !(blockedAcounts[index]['isBlock'] as BoolWrapper).b;
  }

  @override
  Widget build(BuildContext context) {
    final isBlockd = BoolWrapper();
    getBlockedAcounts();
    return Scaffold(
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
