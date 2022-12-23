import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/add_edit_muted_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test('user name is empty  ', () {
      final EditMuted = EditMutedScreenState();
      EditMuted.inputUserNameController.text = '';

      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeUserNmae();
      expect(EditMuted.isSlected, false);
    });
    test('user name is not empty ', () {
      final EditMuted = EditMutedScreenState();
      EditMuted.inputUserNameController.text = 'asdw';

      // login.inputUserNameController.text = 'asdwa';
      EditMuted.changeUserNmae();
      expect(EditMuted.isSlected, true);
    });
  });
}
