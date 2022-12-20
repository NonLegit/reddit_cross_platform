import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ThreeDotDownMenu extends StatelessWidget {
  final List<Widget> list;
  final BuildContext cntx;
  const ThreeDotDownMenu({super.key, required this.cntx, required this.list});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        (!kIsWeb) ? Icons.more_vert : Icons.more_horiz,
        color: Colors.grey.shade600,
      ),
      onPressed: () {
        showModalBottomSheet(
          isScrollControlled: true,
          context: cntx,
          builder: (_) {
            return ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(keepScrollOffset: false),
              itemBuilder: (_, index) {
                return list[index];
              },
              itemCount: list.length,
            );
          },
        );
      },
    );
  }
}
