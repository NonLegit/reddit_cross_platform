import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class AlertDialog1 extends StatelessWidget {
  const AlertDialog1({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Leave without saving',
        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      ),
      insetPadding: EdgeInsets.zero,
      content: SizedBox(
        width: 40.h,
        child: const Text(
          'You cannot undo this action',
          style: TextStyle(fontSize: 11),
        ),
      ),
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        SizedBox(
          width: 20.h,
          height: 5.h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, false);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPrimary: Colors.grey[200],
              // backgroundColor: Colors.grey[200],
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        SizedBox(
          width: 20.h,
          height: 5.h,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              onPrimary: Colors.blue[800],
              // backgroundColor: Colors.blue[800],
            ),
            child: const Text('Leave'),
          ),
        )
      ],
    );
  }
}
