import 'package:flutter_test/flutter_test.dart';
import '../../../lib/logins/screens/login.dart';
import '../../../lib/logins/models/status.dart';

void main() {
  group('Check the continue bottom', () {
    test('data is all correct', () {
      final login = LoginState();
      login.inputUserNameController.text = 'asdwa';
      login.inputPasswardController.text = 'asdsadasd';
      login.changeInput();
      expect(login.isFinished, true);
    });
    test('data is all correct but username isnot uniqe', () {
      final login = LoginState();
      login.inputUserNameController.text = '';
      login.inputPasswardController.text = 'asdsadasd';
      login.changeInput();
      expect(login.isFinished, false);
    });

    test('test when email isnot in format', () {
      final login = LoginState();
      login.inputUserNameController.text = 'asdwa';
      login.inputPasswardController.text = '';
      login.changeInput();
      expect(login.isFinished, false);
    });
    test('test when user name is less than 3', () {
      final login = LoginState();
      login.inputUserNameController.text = '';
      login.inputPasswardController.text = '';
      login.changeInput();
      expect(login.isFinished, false);
    });
  });
}
