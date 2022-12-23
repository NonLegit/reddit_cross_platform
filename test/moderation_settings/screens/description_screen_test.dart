import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/description_screen.dart';

void main() {
  group('check change focus', () {
    test(' test change description when the new value is the initial ', () {
      final EditMuted = DescriptionState();
      EditMuted.initialDescription = 'hamada';
      EditMuted.changeDescription('hamada');
      expect(EditMuted.isSlected, false);
    });
    test(' test change description when the new value is not the initial ', () {
      final EditMuted = DescriptionState();
      EditMuted.initialDescription = 'hamada';
      EditMuted.changeDescription('yaser');
      expect(EditMuted.isSlected, true);
    });
  });
}
