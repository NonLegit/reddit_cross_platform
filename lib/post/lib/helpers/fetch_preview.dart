import 'package:html/parser.dart';
import 'package:http/http.dart';

class FetchPreview {
  Future fetch(url) async {
    final client = Client();
    final response = await client.get(Uri.parse(url));
    final document = parse(response.body);

    String? image;

    var elements = document.getElementsByTagName('meta');

    for (var tmp in elements) {
      if (tmp.attributes['property'] == 'og:image') {
        image = tmp.attributes['content'];
      }
    }
    final start = url.contains('https://www.') ? 'https://www.' : 'https://';
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
  }
}
