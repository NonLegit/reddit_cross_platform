import 'package:flutter_test/flutter_test.dart';

import '../../../lib/post/widgets/post_header.dart';

void main() {
  group(
    'calculateHowOld :',
    () {
      test('get time passed since  2017-07-21T17:32:28Z', () {
        String? result =
            PostHeaderBasic.calculateHowOld('2017-07-21T17:32:28Z');
        expect(result, '5y');
      });

      test('get time passed since  2018-07-21T17:32:28Z', () {
        String? result =
            PostHeaderBasic.calculateHowOld('2018-07-21T17:32:28Z');
        expect(result, '4y');
      });

      test('get time passed since  2022-01-21T17:32:28Z', () {
        String? result =
            PostHeaderBasic.calculateHowOld('2022-01-21T17:32:28Z');
        expect(result, '9mo');
      });
    },
  );

  // testWidgets('barwidget ...', (tester) async {
  //   // TODO: Implement test
  // });
}
