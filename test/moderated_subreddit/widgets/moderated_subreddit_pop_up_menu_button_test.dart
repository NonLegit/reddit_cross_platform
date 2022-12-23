import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderated_subreddit/widgets/moderated_subreddit_pop_up_menu_button.dart';
import '../../moderated_subreddit/widgets/moderated_subreddit_pop_up_menu_button_test.dart';
void main() {
  group(
    'moderated subreddit pop up menu button ...',
    () {
      // final createCommunity = CreateCommunity();
      final subredditpopupButtonState =ModeratedSubredditPopupMenuButtonState();
      test('changeNotificationMode ', () {
        // TODO: Implement test
        int result = subredditpopupButtonState.chooseNotificationType(1);
        expect(result, 1);
      });
       test('Subscribe ', () {
        // TODO: Implement test
        bool result = subredditpopupButtonState.changeJoinStatus();
        expect(result, true);
      });
       test('UnSubcribe ', () {
        // TODO: Implement test
        bool result = subredditpopupButtonState.changeDisJoinStatus();
        expect(result, false);
      });
    },
  );
}
