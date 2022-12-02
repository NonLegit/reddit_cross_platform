import 'package:flutter_test/flutter_test.dart';
import '../../lib/widgets/sort_bottom_web.dart';

void main() {
  group(
    'Sort Post type buttons ...',
    () {
      // final createCommunity = CreateCommunity();
      final sorttypeButtonWebState = SortBottomWebState();
      test('HotButton', () {
        // TODO: Implement test
       bool result = sorttypeButtonWebState.HotButton();
        expect(result, true);
      });

      test('NewButton', () {
        // TODO: Implement test
       bool result = sorttypeButtonWebState.NewButton();
        expect(result, true);
      });
            test('TopButton', () {
        // TODO: Implement test
       bool result = sorttypeButtonWebState.TopButton();
        expect(result, true);
      });
    },
  );
}
