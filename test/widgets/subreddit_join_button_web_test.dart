import 'package:flutter_test/flutter_test.dart';
import 'package:post/widgets/subreddit_join_button_web.dart';

void main() {
  group(
    'Post type buttons ...',
    () {
      // final createCommunity = CreateCommunity();
      final joinButtonState = SubredditJoinButtonWebState();
      test(' disjoinButtonSubredditWeb', () {
        // TODO: Implement test
       bool result = joinButtonState.disJoin();
        expect(result, false);
      });

        test(' joinButtonSubredditWeb', () {
        // TODO: Implement test
       bool result = joinButtonState.join();
        expect(result, true);
      });
    },
  );
}
