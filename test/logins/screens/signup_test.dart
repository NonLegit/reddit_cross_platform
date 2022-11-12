import 'package:flutter_test/flutter_test.dart';
import '../../../lib/logins/screens/signup.dart';
import '../../../lib/logins/models/status.dart';

void main() {
  group('Check the continue bottom', () {
    test('data is all correct', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed@sayed.com';
      signUp.inputUserNameController.text = 'asdwa';
      signUp.inputPasswardController.text = 'asdsadasd';
      signUp.isUnige = true;
      signUp.changeInput();
      expect(signUp.isFinished, true);
    });
    test('data is all correct but username isnot uniqe', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed@sayed.com';
      signUp.inputUserNameController.text = 'asdwa';
      signUp.inputPasswardController.text = 'asdsadasd';
      signUp.isUnige = false;
      signUp.changeInput();
      expect(signUp.isFinished, false);
    });

    test('test when email isnot in format', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed.com';
      signUp.inputUserNameController.text = 'asdwa';
      signUp.inputPasswardController.text = 'asdsadasd';
      signUp.isUnige = true;
      signUp.changeInput();
      expect(signUp.isFinished, false);
    });
    test('test when user name is less than 3', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed@asd.com';
      signUp.inputUserNameController.text = 'as';
      signUp.inputPasswardController.text = 'asdsadasd';
      signUp.isUnige = true;
      signUp.changeInput();
      expect(signUp.isFinished, false);
    });
    test('test when user name is bigger than 20', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed@asd.com';
      signUp.inputUserNameController.text = '12345678901234567890123';
      signUp.inputPasswardController.text = 'asdsadasd';
      signUp.isUnige = true;
      signUp.changeInput();
      expect(signUp.isFinished, false);
    });
    test('password less than 8 (7 characters)', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahmed@sayed.com';
      signUp.inputUserNameController.text = 'asdwa';
      signUp.inputPasswardController.text = 'asdasds';
      signUp.isUnige = true;
      signUp.changeInput();
      expect(signUp.isFinished, false);
    });
  });
  group('validate the email', () {
    test('check the validation of the email when it is empty', () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = '';
      expect(signUp.validateEmail(), InputStatus.original);
    });
    test('check the validation of the email when it is in the correct formate',
        () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahe@asd.cs';
      expect(signUp.validateEmail(), InputStatus.sucess);
    });
    test('check the validation of the email when it is in the false formate',
        () {
      final signUp = SignUpState();
      signUp.inputEmailController.text = 'ahe.cs';
      expect(signUp.validateEmail(), InputStatus.failed);
    });
  });
  group('test the email input field', () {
    test('on tapign the email texfield ', () {
      // TODO: Implement test
      final signUp = SignUpState();
      signUp.controlEmailStatus(true);
      expect(signUp.inputEmailStatus, InputStatus.taped);
    });
  });

  group('validate the username', () {
    test('check the validation of the username when it is empty', () {
      final signUp = SignUpState();
      signUp.inputUserNameController.text = '';
      expect(signUp.validateUsername(), InputStatus.original);
    });
    test(
        'check the validation of the username when it has  (5 characters) and uniqe',
        () {
      final signUp = SignUpState();
      signUp.inputUserNameController.text = 'asdas';
      signUp.isUnige = true;
      expect(signUp.validateUsername(), InputStatus.sucess);
    });
    test(
        'check the validation of the username when it has (2 characters) and uniqe',
        () {
      final signUp = SignUpState();
      signUp.inputUserNameController.text = 'as';
      expect(signUp.validateUsername(), InputStatus.failed);
    });
    test(
        'check the validation of the username when it has (23 characters) and uniqe',
        () {
      final signUp = SignUpState();
      signUp.inputUserNameController.text = '01234567890123456789asd';
      expect(signUp.validateUsername(), InputStatus.failed);
    });
    test(
        'check the validation of the username when it has (5 characters) and not uniqe',
        () {
      final signUp = SignUpState();
      signUp.inputUserNameController.text = 'ahmed';
      expect(signUp.validateUsername(), InputStatus.failed);
    });
  });
  group('test the Username  input field', () {
    test('on tapign the username texfield ', () {
      // TODO: Implement test
      final signUp = SignUpState();
      signUp.controlUsernameStatus(true);
      expect(signUp.inputUsernameStatus, InputStatus.taped);
    });
  });

  group('validate the password', () {
    test('check the validation of the password when it is empty', () {
      final signUp = SignUpState();
      signUp.inputPasswardController.text = '';
      expect(signUp.validatePassword(), InputStatus.original);
    });
    test(
        'check the validation of the password when it has less than 8 char (3 characters)',
        () {
      final signUp = SignUpState();
      signUp.inputPasswardController.text = 'asd';
      signUp.validatePassword();
      expect(signUp.validatePassword(), InputStatus.failed);
    });
    test(
        'check the validation of the password when it has less than 7 char (3 characters)',
        () {
      final signUp = SignUpState();
      signUp.inputPasswardController.text = 'asdasd5';
      signUp.validatePassword();
      expect(signUp.validatePassword(), InputStatus.failed);
    });
    test(
        'check the validation of the password when it has less than 8 char (3 characters)',
        () {
      final signUp = SignUpState();
      signUp.inputPasswardController.text = '12345678';
      signUp.validatePassword();
      expect(signUp.validatePassword(), InputStatus.sucess);
    });
    test(
        'check the validation of the password when it has less than 12 char (3 characters)',
        () {
      final signUp = SignUpState();
      signUp.inputPasswardController.text = '123456789asd';
      signUp.validatePassword();
      expect(signUp.validatePassword(), InputStatus.sucess);
    });
  });
  group('test the password input field', () {
    test('on tapign the password texfield ', () {
      // TODO: Implement test
      final signUp = SignUpState();
      signUp.controlPasswordStatus(true);
      expect(signUp.inputPasswardStatus, InputStatus.taped);
    });
  });
}
