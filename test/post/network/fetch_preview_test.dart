import 'package:flutter_test/flutter_test.dart';
import '../../../lib/post/network/fetch_preview.dart';

void main() {
 group(
    'fetch preview :',
    () {
      test('get website name from full url ', () async {
        String? result = await FetchPreview()
            .fetch('https://www.google.com/')
            .then((res) => res['link']);
        expect(result, 'google.com');
      });

      test('get website name f rom url without https://', () async {
        String? result = await FetchPreview()
            .fetch('www.google.com/')
            .then((res) => res['link']);
        expect(result, 'google.com');
      });

      test('get website name from invalid url', () async {
        String? result = await FetchPreview()
            .fetch('151655235155641654164865125/')
            .then((res) => res['link']);
        expect(result, null);
      });

      test('get website image from full url ', () async {
        String? result = await FetchPreview()
            .fetch('https://github.com/')
            .then((res) => res['image']);
        expect(result, isNotEmpty);
      });

      test('get website image from url without https://', () async {
        String? result = await FetchPreview()
            .fetch('https://github.com/')
            .then((res) => res['image']);
        expect(result, isNotEmpty);
      });

      test('get website image from url without image', () async {
        String? result = await FetchPreview()
            .fetch('www.google.com/')
            .then((res) => res['image']);
        expect(result, '');
      });

      test('get website image from invalid url', () async {
        String? result = await FetchPreview()
            .fetch('151655235155641654164865125/')
            .then((res) => res['image']);
        expect(result, null);
      });
    },
  );
  // testWidgets('fetch preview ...', (tester) async {
  //   // TODO: Implement test
  // });
}
