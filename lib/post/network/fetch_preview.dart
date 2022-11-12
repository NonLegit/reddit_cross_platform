import 'package:html/parser.dart';
import 'package:http/http.dart';

/// This class gets the name and image of a given url.

class FetchPreview {
  Future fetch(url) async {
    try {
      url = _validateUrl(url);
      final client = Client();
      final response = await client.get(Uri.parse(url));
      final document = parse(response.body);

      String? image;

      var elements = document.getElementsByTagName('meta');

      for (var tmp in elements) {
        if (tmp.attributes['property'] == 'og:image') {
          image = tmp.attributes['content'];
          break;
        }
      }
      final start = url.contains('https://')
          ? (url.contains('https://www.') ? 'https://www.' : 'https://')
          : (url.contains('http://www.') ? 'http://www.' : 'http://');
      const end = '/';
      final link = url.substring(
          start.length,
          (url.substring(start.length, url.length)).indexOf(end) == -1
              ? url.length
              : (url.substring(start.length, url.length).indexOf(end) +
                  start.length));
      return {
        'image': image ?? '',
        'link': link ?? '',
      };
    } on Exception catch (_) {
      return {
        'image': null,
        'link': null,
      };
    }
  }

  /// This function is used to validate a given url
  ///
  /// it adds 'http://' if missing
  _validateUrl(String url) {
    if (url.startsWith('http://') == true ||
        url.startsWith('https://') == true) {
      return url;
    } else {
      return 'http://$url';
    }
  }
}
