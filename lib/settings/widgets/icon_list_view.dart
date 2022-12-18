import 'package:flutter/material.dart';
import '../provider/user_settings_provider.dart';
import 'package:provider/provider.dart';

class IconListView extends StatelessWidget {
  // const IconListView({Key? key}) : super(key: key);
  final Widget leadingIcon;
  final String title;
  final String subtitle;
  final Widget trailingIcon;
  final Function handler;

  final onlyIconPressed;
  final UserSettingsProvider? provider;

  IconListView(
      {required this.leadingIcon,
      required this.title,
      this.subtitle = '',
      required this.trailingIcon,
      required this.handler,
      this.onlyIconPressed = false,
      this.provider});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: ElevatedButton(
        onPressed: onlyIconPressed ? null : () => handler(),
        child: ListTile(
            contentPadding: const EdgeInsets.all(0),
            leading: leadingIcon,
            title: Text(title),
            subtitle: subtitle.isEmpty ? null : Text(subtitle),
            trailing: onlyIconPressed
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        shadowColor: Colors.white,
                        side: BorderSide(color: Colors.white),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                    onPressed: () => handler(),
                    child: trailingIcon)
                : trailingIcon),
      ),
    );
  }
}
