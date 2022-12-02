import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderated_subreddit/widgets/mod_subreddit_post_sort_bottom.dart';
import 'package:post/subreddit/widgets/subreddit_join_buttons.dart';
import '../../moderated_subreddit/widgets/mod_subreddit_post_sort_bottom_test.dart';

void main() {
  group(
    'Post type buttons ...',
    () {
      // final createCommunity = CreateCommunity();
      final posttypeButtonState = ModSubredditPostSortBottomState();
      test('changePost', () {
        // TODO: Implement test
        int result = posttypeButtonState.choosePostType(1);
        expect(result, 1);
      });

      test('changetopPost ', () {
        // TODO: Implement test
        int result = posttypeButtonState.chooseTimeTopPost(2, 1);
        expect(result, 1);
      });
    },
  );
}
