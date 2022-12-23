import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/add_edit_aproved_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test('input field is empty', () {
      final EditApproved = EditApprovedScreenState();
      EditApproved.inputUserNameController.text = '';
      EditApproved.changeUserNmae();
      expect(EditApproved.isSlected, false);
    });
    test('input field is empty', () {
      final EditApproved = EditApprovedScreenState();
      EditApproved.inputUserNameController.text = 'ahmed';
      EditApproved.changeUserNmae();
      expect(EditApproved.isSlected, true);
    });
  });
}
