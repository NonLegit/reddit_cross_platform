import 'package:flutter_test/flutter_test.dart';
import 'package:post/settings/screens/change_password.dart';

void main() {
  group('validate Password', () {
    test(' the input password is empty ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputCurrentPasswordController.text = '';
      bool fine = EditMuted.validPassword();
      expect(fine, false);
    });
    test(' the input password is not empty ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputCurrentPasswordController.text = 'asd';
      bool fine = EditMuted.validPassword();
      expect(fine, true);
    });
  });
  group('validate new Password', () {
    test(' the input password is empty ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputNewPasswordController.text = '';
      bool fine = EditMuted.validNewPassword();
      expect(fine, false);
    });
    test(' the input password is not empty but les than 8 ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputNewPasswordController.text = '1234567';
      bool fine = EditMuted.validNewPassword();
      expect(fine, false);
    });
    test(' the input password is not empty and big than 8 ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputNewPasswordController.text = '123456789';
      bool fine = EditMuted.validNewPassword();
      expect(fine, true);
    });
  });
  group('validConfirmNewPassword', () {
    test(' the input password is empty ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputConfirmNewPasswordController.text = '';
      bool fine = EditMuted.validNewPassword();
      expect(fine, false);
    });
    test(' the input password is not empty but les than 8 ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputConfirmNewPasswordController.text = '1234567';
      EditMuted.inputNewPasswordController.text = '123456';
      bool fine = EditMuted.validNewPassword();
      expect(fine, false);
    });
    test(' the input password is not empty and big than 8 ', () {
      final EditMuted = ChangePasswordState();
      EditMuted.inputConfirmNewPasswordController.text = '123456789';
      EditMuted.inputNewPasswordController.text = '123456789';
      bool fine = EditMuted.validNewPassword();
      expect(fine, true);
    });
  });
}
