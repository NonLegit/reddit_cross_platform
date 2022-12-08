import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import '../../../lib/post/network/prepare_images.dart';

void main() {
  const data = [
    "https://docs.flutter.dev/assets/images/flutter-logo-sharing.png",
    'https://dart.dev/assets/shared/dart-logo-for-shares.png?2',
    'https://martech.org/wp-content/uploads/2014/07/reddit-combo-1920.png'
  ];
  List<Image> imageList = [];
  PrepareImages.loadImages(data).then((res) {
    imageList = res;
  });
  group(
    'prepare images :',
    () {
      test('get list of images from list of urls', () async {
        List<Image> result = await PrepareImages.loadImages(data);
        expect(result, isNotEmpty);
      });

      test('get list of images from list of invalid urls', () async {
        List<Image> result =
            await PrepareImages.loadImages(['12521', 'hjkhjkjhl', '56gd']);
        expect(result, []);
      });

      test('get list of images from list of invalid and valid urls', () async {
        List<Image> result = await PrepareImages.loadImages([
          '12521',
          'hjkhjkjhl',
          '56gd',
          'https://dart.dev/assets/shared/dart-logo-for-shares.png?2'
        ]);
        expect(result, isNotEmpty);
      });
    },
  );

  // testWidgets('prepare image ...', (tester) async {
  //   // TODO: Implement test
  // });
}
