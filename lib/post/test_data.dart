import 'package:http/http.dart' as http;

class TestData {
  static Future fetchAlbum() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.6:3000/subreddits'));
    return response.body;
  }

  static final testData = [
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'text',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': false,
      'url': 'github.com',
      'votes': 0,
      'comments': 6,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'link',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': false,
      'url': 'github.com',
      'votes': 0,
      'comments': 0,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'image',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': false,
      'url': 'github.com',
      'votes': 5,
      'comments': 6,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'text',
      'text':
          'Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': false,
      'url': 'github.com',
      'votes': 0,
      'comments': 6,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'link',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': true,
      'spoiler': false,
      'url': 'github.com',
      'votes': 0,
      'comments': 0,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'image',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': true,
      'url': 'github.com',
      'votes': 5,
      'comments': 6,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'link',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': false,
      'spoiler': true,
      'url': 'github.com',
      'votes': 0,
      'comments': 0,
    },
    {
      'userName': 'Amr',
      'communityName': 'vexmains',
      'createDate': '2017-07-21T17:32:28Z',
      'title': 'hello world',
      'type': 'image',
      'text': 'Nice!',
      'images': [
        'https://docs.flutter.dev/assets/images/flutter-logo-sharing.png',
        'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
        'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
      ],
      'nsfw': true,
      'spoiler': true,
      'url': 'github.com',
      'votes': 5,
      'comments': 6,
    },
  ];
}
