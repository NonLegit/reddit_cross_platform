import 'package:flutter_test/flutter_test.dart';
import 'package:post/settings/screens/change_email.dart';

void main() {
  group('validate Password', () {
    test(' the input password is empty ', () {
      final EditMuted = ChangeEmailState();
      EditMuted.inputPasswardController.text = '';
      bool fine = EditMuted.validPassword();
      expect(fine, false);
    });
    test(' the input password is not empty ', () {
      final EditMuted = ChangeEmailState();
      EditMuted.inputPasswardController.text = 'asd';
      bool fine = EditMuted.validPassword();
      expect(fine, true);
    });
  });
  group('validate Email', () {
    test(' the input password is empty ', () {
      final EditMuted = ChangeEmailState();
      EditMuted.inputEmailController.text = '';
      bool fine = EditMuted.validMail();
      expect(fine, false);
    });
    test(' the input password is not empty ', () {
      final EditMuted = ChangeEmailState();
      EditMuted.inputEmailController.text = 'asd';
      bool fine = EditMuted.validMail();
      expect(fine, false);
    });
    test(' the input password is not empty ', () {
      final EditMuted = ChangeEmailState();
      EditMuted.inputEmailController.text = 'asdasd@asd.cas';
      bool fine = EditMuted.validMail();
      expect(fine, true);
    });
  });
}
