import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class alertDialog extends StatelessWidget {
  const alertDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Leave without saving',
        style: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold),
      ),
      insetPadding: EdgeInsets.zero,
      content: Container(
        //height: 4.h,
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
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey),
            ),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.grey[200],
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
            child: const Text('Leave'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: Colors.blue[800],
            ),
          ),
        )
      ],
    );
  }
}
