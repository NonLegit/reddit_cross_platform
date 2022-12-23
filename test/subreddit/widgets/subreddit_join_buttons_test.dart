import 'package:flutter_test/flutter_test.dart';
import 'package:post/subreddit/widgets/subreddit_join_buttons.dart';
import '../../subreddit/widgets/subreddit_join_buttons_test.dart';

void main() {
  group(
    'subreddit join buttons ...',
    () {
      // final createCommunity = CreateCommunity();
      final subredditJoinButtonState = JoinButtonsState();
      test('changeNotificationMode ', () {
        // TODO: Implement test
        int result = subredditJoinButtonState.changeNotificationMode(1);
        expect(result, 1);
      });

    },
  );
}
