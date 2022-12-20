import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../moderation_settings/widgets/status.dart';
import '../../models/wrapper.dart';
import '../widgets/setting_text_input.dart';
import '../widgets/setting_password_input.dart';
import '../../widgets/custom_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPasswordDialog extends AlertDialog {
  ForgotPasswordDialog() : super();
}
