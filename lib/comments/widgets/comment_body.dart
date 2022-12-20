import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';

import '../../myprofile/screens/myprofile_screen.dart';
import '../../other_profile/screens/others_profile_screen.dart';

class CommentBody extends StatefulWidget {
  final String text;
  final String userName;
  const CommentBody({super.key, required this.text, required this.userName});

  @override
  State<CommentBody> createState() => _CommentBodyState(text);
}

class _CommentBodyState extends State<CommentBody> {
  String text;
  _CommentBodyState(this.text);
  List<String> prepareText(String text) {
    var list = text.split(' ');
    List<String> list1 = [];

    String temp = '';
    for (var word in list) {
      if (word.startsWith('u/')) {
        list1.add(temp);
        temp = ' ';
        list1.add(word);
      } else {
        temp += word;
        temp += ' ';
      }
    }
    if (temp != ' ') {
      list1.add(temp.trimRight());
    }
    return list1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsetsDirectional.only(
        top: 10,
      ),
      child: Text.rich(
        TextSpan(
          children: prepareText(parse(text).documentElement!.text).map((e) {
            if (e.startsWith('u/')) {
              return TextSpan(
                text: e,
                style: const TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (e.substring(2) == widget.userName) {
                      Navigator.of(context).pushNamed(MyProfileScreen.routeName,
                          arguments: e.substring(2));
                    } else {
                      Navigator.of(context).pushNamed(
                          OthersProfileScreen.routeName,
                          arguments: e.substring(2));
                    }
                  },
              );
            }
            return TextSpan(
              text: e,
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.brightness == Brightness.light
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                fontSize: 14,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
