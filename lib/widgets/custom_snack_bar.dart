import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomSnackBar extends SnackBar {
  final isError;
  final disableStatus;
  final widtth;
  final heightt;
  final durattion;
  final text;
  final leadingIcon;
  CustomSnackBar({
    this.disableStatus = false,
    this.isError = false,
    this.widtth = null,
    this.heightt = null,
    this.durattion = 2000,
    this.text = '',
    this.leadingIcon = null,
  }) : super(
          elevation: 5,
          behavior: SnackBarBehavior.floating,
          padding: const EdgeInsets.all(0.0),
          width: (widtth != null) ? widtth : 70.w,
          backgroundColor: Colors.white,
          content: Row(
            children: [
              if (disableStatus)
                Container(
                  height: (heightt != null) ? heightt : 9.h,
                  width: 2.w,
                  color: isError ? Colors.red : Colors.green,
                ),
              if (!disableStatus)
                Container(
                  height: (heightt != null) ? heightt : 9.h,
                  width: 0,
                  color: isError ? Colors.red : Colors.green,
                ),
              if (leadingIcon != null) Icon(leadingIcon as IconData),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  width: 50.w,
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.black),
                    maxLines: 2,
                  ),
                ),
              ),
            ],
          ),
          duration: Duration(milliseconds: (durattion as int)),
        );
}
