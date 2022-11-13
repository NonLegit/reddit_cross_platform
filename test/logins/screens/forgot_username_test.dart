import 'package:flutter_test/flutter_test.dart';
import '../../../lib/logins/screens/forgot_username.dart';
import '../../../lib/logins/models/status.dart';

void main() {
  group('Check the continue bottom', () {
    test('Email is correct', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'ahmed@asd.asd';
      forgotUserName.changeInput();
      expect(forgotUserName.isFinished, true);
    });
    test('empty email', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = '';
      forgotUserName.changeInput();
      expect(forgotUserName.isFinished, false);
    });

    test('incorrect format(without @ .)', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'asdas.';
      forgotUserName.changeInput();
      expect(forgotUserName.isFinished, false);
    });
    test('incorrect format (without  .)', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'asd@asd';
      forgotUserName.changeInput();
      expect(forgotUserName.isFinished, false);
    });
    test('incorrect format (without  @)', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'asd.asd';
      forgotUserName.changeInput();
      expect(forgotUserName.isFinished, false);
    });
  });

  group('validate the email', () {
    test('check the validation of the email when it is empty', () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = '';
      expect(forgotUserName.validateEmail(), InputStatus.original);
    });
    test('check the validation of the email when it is in the correct formate',
        () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'ahe@asd.cs';
      expect(forgotUserName.validateEmail(), InputStatus.sucess);
    });
    test('check the validation of the email when it is in the false formate',
        () {
      final forgotUserName = ForgotUserNameState();
      forgotUserName.inputEmailController.text = 'ahe.cs';
      expect(forgotUserName.validateEmail(), InputStatus.failed);
    });
  });
  group('test the email input field', () {
    test('on tapign the email texfield ', () {
      // TODO: Implement test
      final forgotUserName = ForgotUserNameState();
      forgotUserName.controlEmailStatus(true);
      expect(forgotUserName.inputEmailStatus, InputStatus.taped);
    });
  });
}
