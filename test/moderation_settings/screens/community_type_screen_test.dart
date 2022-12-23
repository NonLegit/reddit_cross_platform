import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/community_type_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test(' index and is plus 18 both changed ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 6;
      EditMuted.isPlus18 = false;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('is plus 18 only changed ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 12;
      EditMuted.isPlus18 = false;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('index only changed ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 6;
      EditMuted.isPlus18 = true;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, true);
    });
    test('both the same ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.initialIndex = 12;
      EditMuted.initialIsPlus18 = true;

      EditMuted.index = 12;
      EditMuted.isPlus18 = true;
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isSlected, false);
    });
  });
  group('test changeType', () {
    test('  ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.index = 12.0;
      EditMuted.changeType(20.0);
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.index.toDouble(), 20.0);
    });
  });
  group('changePlus18', () {
    test('  ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.isPlus18 = true;
      EditMuted.changePlus18();
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isPlus18, false);
    });
    test('  ', () {
      final EditMuted = ComuunityTypesScreenState();
      EditMuted.isPlus18 = false;
      EditMuted.changePlus18();
      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeCommunityType();
      expect(EditMuted.isPlus18, true);
    });
  });
}
