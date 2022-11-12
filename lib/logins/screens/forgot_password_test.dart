import 'package:flutter_test/flutter_test.dart';
import '../../../lib/logins/screens/forgot_password.dart';
import '../../../lib/logins/models/status.dart';

void main() {
  group('Check the continue bottom', () {
    test('User and Email is correct', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = 'asd';
      ForgotPassword.inputEmailController.text = 'ahmed@asd.asd';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, true);
    });
    test('empty username and correct email', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = '';
      ForgotPassword.inputEmailController.text = 'ahmed@asd.asd';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });
    test('empty email and correct username', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = 'asda';
      ForgotPassword.inputEmailController.text = '';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });

    test('empty email and empty username', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = '';
      ForgotPassword.inputEmailController.text = '';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });

    test('incorrect format(without @ .)', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = 'asda';
      ForgotPassword.inputEmailController.text = 'asdas.';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });
    test('incorrect format (without  .)', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = 'asda';
      ForgotPassword.inputEmailController.text = 'asd@asd';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });
    test('incorrect format (without  @)', () {
      final ForgotPassword = ForgotPasswordState();
      ForgotPassword.inputUserNameController.text = 'asda';

      ForgotPassword.inputEmailController.text = 'asd.asd';
      ForgotPassword.changeInput();
      expect(ForgotPassword.isFinished, false);
    });
  });

  // group('validate the email', () {
  //   test('check the validation of the email when it is empty', () {
  //     final ForgotPassword = ForgotPasswordState();
  //     ForgotPassword.inputEmailController.text = '';
  //     expect(ForgotPassword.validateEmail(), InputStatus.original);
  //   });
  //   test('check the validation of the email when it is in the correct formate',
  //       () {
  //     final ForgotPassword = ForgotPasswordState();
  //     ForgotPassword.inputEmailController.text = 'ahe@asd.cs';
  //     expect(ForgotPassword.validateEmail(), InputStatus.sucess);
  //   });
  //   test('check the validation of the email when it is in the false formate',
  //       () {
  //     final ForgotPassword = ForgotPasswordState();
  //     ForgotPassword.inputEmailController.text = 'ahe.cs';
  //     expect(ForgotPassword.validateEmail(), InputStatus.failed);
  //   });
  // });
  // group('test the email input field', () {
  //   test('on tapign the email texfield ', () {
  //     // TODO: Implement test
  //     final ForgotPassword = ForgotPasswordState();
  //     ForgotPassword.controlEmailStatus(true);
  //     expect(ForgotPassword.inputEmailStatus, InputStatus.taped);
  //   });
  // });
}
