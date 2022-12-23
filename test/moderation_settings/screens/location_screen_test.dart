import 'package:flutter_test/flutter_test.dart';
import '../../../lib/moderation_settings/screens/location_screen.dart';

void main() {
  group('check change focus', () {
    test(' test change description when the new value is the initial ', () {
      final EditMuted = LocationScreenState();
      EditMuted.initialDescription = 'hamada';
      EditMuted.changeDescription('hamada');
      expect(EditMuted.isSlected, false);
    });
    test(' test change description when the new value is not the initial ', () {
      final EditMuted = LocationScreenState();
      EditMuted.initialDescription = 'hamada';
      EditMuted.changeDescription('yaser');
      expect(EditMuted.isSlected, true);
    });
  });
}
