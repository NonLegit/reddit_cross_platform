import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/location_screen.dart';

void main() {
  group('check change focus', () {
    test(' test change description when the new value is the initial ', () {
      final location = LocationScreenState();
      location.initialLocation = 'asd';
      location.changeLocation('ww');
      expect(location.isSlected, true);
    });
    test(' test change description when the new value is not the initial ', () {
      final location = LocationScreenState();
      location.initialLocation = 'asd';
      location.changeLocation('asd');
      expect(location.isSlected, false);
    });
  });
}
