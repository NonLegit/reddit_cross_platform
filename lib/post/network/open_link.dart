import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';

class OpenLink {
  static void openLink(url) async {
    url = Uri.parse(url);

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
