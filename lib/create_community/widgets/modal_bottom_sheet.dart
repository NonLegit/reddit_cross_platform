import 'package:flutter/material.dart';

class ModalBottomSheetContent extends StatelessWidget {
  const ModalBottomSheetContent({
    Key? key,
    required this.key2,
    required this.communityTypeIcon,
    required this.communityType,
  }) : super(key: key);

  final String key2;
  final Map<String, IconData> communityTypeIcon;
  final Map<String, String> communityType;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            key2,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          leading: Icon(communityTypeIcon[key2]),
          subtitle: Text(
            '${communityType[key2]}',
            style:
                const TextStyle(fontSize: 13),
          ),
        ),
        const Divider(
          color: Colors.transparent,
        ),
      ],
    );
  }
}
