import 'package:flutter/material.dart';

final communityType = {
  'Public': 'Anyone can view,post,and comment to this community',
  'Restricted':
      'Anyone can view this community,but only approved users can post',
  'Private': 'Only approved users can view and submit to this community',
};

final communityTypeIcon = {
  'Public': Icons.account_circle_outlined,
  'Restricted': Icons.task_alt_outlined,
  'Private': Icons.lock_outlined,
};
