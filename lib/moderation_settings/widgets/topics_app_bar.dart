import 'package:flutter/material.dart';

class TopicsAppBar extends StatelessWidget {
  const TopicsAppBar({
    Key? key,
    required this.iselected,
    required this.makeButtonEnable,
  }) : super(key: key);

  final iselected;
  final VoidCallback makeButtonEnable;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Topics',
      ),
      actions: [
        OutlinedButton(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          onPressed: (iselected) ? () => makeButtonEnable() : null,
          child: Text(
            'Save',
            style: TextStyle(
                color: (iselected)
                    ? Colors.blue
                    : Colors.blue.shade900.withOpacity(0.5)),
          ),
        )
      ],
      titleTextStyle: const TextStyle(
          color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
      backgroundColor: Colors.grey[50],
      titleSpacing: 0,
      elevation: 2,
      shadowColor: Colors.white,
    );
  }
}
