import 'package:url_launcher/url_launcher.dart';

class OpenLink {
  static void openLink(url) async {
    url = Uri.parse(url);

    if (await canLaunchUrl(url)) {
      launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }
}
