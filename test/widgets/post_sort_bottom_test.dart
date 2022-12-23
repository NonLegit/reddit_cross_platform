import 'package:flutter_test/flutter_test.dart';
import 'package:post/subreddit/widgets/subreddit_join_buttons.dart';
import '../../lib/widgets/post_sort_bottom.dart';

void main() {
  group(
    'Post type buttons ...',
    () {
      // final createCommunity = CreateCommunity();
      final posttypeButtonState = PostSortBottomState();
      test('changePost to Hot', () {
        // TODO: Implement test
        int result = posttypeButtonState.choosePostType(0);
        expect(result, 0);
      });
        test('changePost to New', () {
        // TODO: Implement test
        int result = posttypeButtonState.choosePostType(1);
        expect(result, 1);
      });
        test('changePost to Top', () {
        // TODO: Implement test
        int result = posttypeButtonState.choosePostType(2);
        expect(result, 2);
      });
      
    },
  );
}
