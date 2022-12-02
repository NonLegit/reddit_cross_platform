import 'package:flutter/material.dart';
import '../../models/wrapper.dart';

class BotomIconSheet extends StatefulWidget {
  // const BotomSheet({Key? key}) : super(key: key);
  final List<Map> sheetList;
  final String title;
  final IntWrapper choosenIndex;
  final Function change;
  BotomIconSheet(
      {required this.sheetList,
      required this.title,
      required this.choosenIndex,
      required this.change});
  @override
  State<BotomIconSheet> createState() => BotomIconSheetState(
      sheetList: sheetList,
      title: title,
      choosenIndex: choosenIndex,
      change: change);
}

class BotomIconSheetState extends State<BotomIconSheet> {
  final List<Map> sheetList;
  final String title;
  final IntWrapper choosenIndex;
  final Function change;
  BotomIconSheetState(
      {required this.sheetList,
      required this.title,
      required this.choosenIndex,
      required this.change});
  void chooseTheNew(index) {
    for (int i = 0; i < sheetList.length; i++) {
      sheetList[i]['selected'] = false;
    }
    choosenIndex.i = index;
    sheetList[choosenIndex.i]['selected'] = true;
    change();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500),
              title,
            ),
          ),
          for (int i = 0; i < sheetList.length; i++)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  chooseTheNew(i);
                });
              },
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: sheetList[i]['icon'],
                title: Text(sheetList[i]['title']),
                trailing: sheetList[i]['selected']
                    ? Icon(color: Colors.blue[600], Icons.check_outlined)
                    : null,
              ),
            ),
        ]);
  }
}
