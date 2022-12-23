import 'package:flutter_test/flutter_test.dart';
import '../../../lib/widgets/follow_button.dart';
void main() {
   group(
    'follow button ...',
    () {
      // final createCommunity = CreateCommunity();
      final followButtonsState = FollowButtonState();
       test('Follow test', () {
        // TODO: Implement test
   bool result =  followButtonsState.followSucceeded();
        expect(result, true);
      });
           test('unFollow', () {
        // TODO: Implement test
   bool result =  followButtonsState.unFollowsucceeded();
        expect(result, false);
      });
    },
  );
}