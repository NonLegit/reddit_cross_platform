import 'package:flutter/material.dart';
import 'package:post/settings/widgets/botom_icons_list_sheet.dart';
import '../../icons/arrow_head_down_word_icons.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../models/wrapper.dart';
import './botom_icons_list_sheet.dart';
import './botom_screen_list_sheet.dart';
import './botom_selected_list_sheet.dart';
import '../models/types.dart';

class DorpDownListView extends StatefulWidget {
  // const IconListView({Key? key}) : super(key: key);
  bool firstTime = true;
  final Widget leadingIcon;
  final String title;
  final String subtitle;
  final Widget trailingIcon;
  final List<Map> sheetList;
  final IntWrapper choosenIndex;
  final TypeStaus listType;
  final Function changeChoosen;

  /// this string will come from the internal storage of the device

  String choosenElement;
  DorpDownListView(
      {required this.leadingIcon,
      required this.title,
      this.subtitle = '',
      required this.trailingIcon,
      required this.sheetList,
      required this.choosenIndex,
      this.choosenElement = '',
      required this.changeChoosen,
      this.listType = TypeStaus.icons});

  @override
  State<DorpDownListView> createState() => _DorpDownListViewState();
}

class _DorpDownListViewState extends State<DorpDownListView> {
  void showSheet(BuildContext cntx) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: cntx,
      builder: (_) {
        if (widget.listType == TypeStaus.icons)
          return BotomIconSheet(
            sheetList: widget.sheetList,
            title: widget.title,
            choosenIndex: widget.choosenIndex,
            change: updateState,
          );
        else if (widget.listType == TypeStaus.selected)
          return BotomSelectedSheet(
            sheetList: widget.sheetList,
            title: widget.title,
            choosenIndex: widget.choosenIndex,
            change: updateState,
          );
        else
          return BotomScreenSheet(
            sheetList: widget.sheetList,
            title: widget.title,
            choosenIndex: widget.choosenIndex,
            change: updateState,
          );
      },
    );
  }

  void updateState() {
    setState(() {});
    widget.choosenElement = widget.sheetList[widget.choosenIndex.i]['title'];
    widget.changeChoosen(widget.choosenElement);
    // print(widget.choosenElement);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.firstTime) {
      widget.firstTime = false;
      if (widget.choosenElement.isNotEmpty) {
        for (int i = 0; i < widget.sheetList.length; i++)
          if (widget.sheetList[i]['title'] == widget.choosenElement)
            widget.choosenIndex.i = i;
      } else {
        widget.choosenIndex.i = 0;
      }
    }
    widget.sheetList[widget.choosenIndex.i]['selected'] = true;
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: () {
          showSheet(context);
        },
        child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: widget.leadingIcon,
            title: Text(widget.title),
            subtitle: widget.subtitle.isEmpty ? null : Text(widget.subtitle),
            trailing: Container(
              width: 40.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FittedBox(
                      fit: BoxFit.contain,
                      child: SizedBox(
                        width: 32.w,
                        child: Text(
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500),
                            widget.sheetList[widget.choosenIndex.i]['title']
                                as String),
                      ),
                    ),
                    widget.trailingIcon,
                  ]),
            )),
      ),
    );
  }
}
