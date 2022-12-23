import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/add_edit_banned_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test('user name is empty , ban has enpty ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.inputUserNameController.text = '';
      EditBanned.reasonForBan = '';

      // login.inputUserNameController.text = 'asdwa';
      EditBanned.changNmaeReason();
      expect(EditBanned.isSlected, false);
    });
    test('user name is empty , ban has data ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.inputUserNameController.text = '';
      EditBanned.reasonForBan = 'asasd';
      EditBanned.changNmaeReason();
      expect(EditBanned.isSlected, false);
    });
    test('user name is has data , ban has enpty ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.inputUserNameController.text = 'ahmed';
      EditBanned.reasonForBan = '';

      // login.inputUserNameController.text = 'asdwa';
      EditBanned.changNmaeReason();
      expect(EditBanned.isSlected, false);
    });
    test('both has data ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.inputUserNameController.text = 'ahmed';
      EditBanned.reasonForBan = 'asd';

      // login.inputUserNameController.text = 'asdwa';
      EditBanned.changNmaeReason();
      expect(EditBanned.isSlected, true);
    });
  });

  group('test permenant and input duration', () {
    test('change the permenat if the moderator is new to be true', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.isNew = true;
      EditBanned.inputDurationController.text = 'asdsda';
      EditBanned.changePermenant(true);
      expect(EditBanned.inputDurationController.text.isEmpty, true);
    });
    test('change the permenat if the moderator is new to be false ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.isNew = true;
      EditBanned.inputDurationController.text = 'asdsda';
      EditBanned.changePermenant(false);
      expect(EditBanned.inputDurationController.text.isEmpty, false);
    });
    test('user name is has data , ban has enpty ', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.isNew = false;
      EditBanned.inputDurationController.text = 'asdsda';
      EditBanned.changePermenant(false);
      expect(EditBanned.inputDurationController.text.isEmpty, false);
    });
  });

  group('test the change duration', () {
    test('change the permenat if the moderator is new to be true', () {
      final EditBanned = EditBannedScreenState();
      EditBanned.inputDurationController.text = 'true';
      EditBanned.permenant = true;
      EditBanned.changeDuration();
      expect(EditBanned.inputDurationController.text.isEmpty, false);
    });
  });
}
