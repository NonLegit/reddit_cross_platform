import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/community_type_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test('  ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 6;
      EditMuted.initialIsPlus18 = false;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('user name is not empty ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 12;
      EditMuted.initialIsPlus18 = false;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('user name is not empty ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 6;
      EditMuted.initialIsPlus18 = true;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('user name is not empty ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 12;
      EditMuted.initialIsPlus18 = true;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, false);
    });
  });
}
