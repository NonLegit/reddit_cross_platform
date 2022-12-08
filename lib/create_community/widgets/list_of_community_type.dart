import 'package:flutter/material.dart';

class ListOfCommunityType extends StatelessWidget {
  const ListOfCommunityType({
    Key? key,
    required this.choosenCommunityType,
    required this.communityDefinition,
  }) : super(key: key);

  final String choosenCommunityType;
  final String communityDefinition;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding:
          const EdgeInsets.only(left: 0.0, right: 0.0),
      title: Row(
        children: [
          Text(
            choosenCommunityType,
            style: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const Icon(
            Icons.arrow_drop_down,
            color: Colors.grey,
            size: 20,
          ),
        ],
      ),
      subtitle: Text(
        communityDefinition,
        style: const TextStyle(
            fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}
