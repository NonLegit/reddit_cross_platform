import 'package:flutter_test/flutter_test.dart';
import 'package:post/moderation_settings/screens/add_edit_moderator_screen.dart';

void main() {
  group('test the is Selected cahgned or not', () {
    test('user name is empty  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.inputUserNameController.text = '';

      // login.inputUserNameController.text = 'asdwa';
      EditBanned.changeUserNmae();
      expect(EditBanned.isSlected, false);
    });
    test('user name is not empty ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.inputUserNameController.text = 'asdw';

      // login.inputUserNameController.text = 'asdwa';
      EditBanned.changeUserNmae();
      expect(EditBanned.isSlected, true);
    });
  });
  group('test change all', () {
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = false;

      EditBanned.permissions!.access = false;
      EditBanned.changePermossionAll(true);
      expect(EditBanned.permissions!.access, true);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = false;

      EditBanned.permissions!.config = false;
      EditBanned.changePermossionAll(true);
      expect(EditBanned.permissions!.config, true);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = false;

      EditBanned.permissions!.flair = false;
      EditBanned.changePermossionAll(true);
      expect(EditBanned.permissions!.flair, true);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = false;

      EditBanned.permissions!.posts = false;
      EditBanned.changePermossionAll(true);
      expect(EditBanned.permissions!.posts, true);
    });
    test('all was false and then make it still false and test access  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.access = false;

      EditBanned.changePermossionAll(false);
      expect(EditBanned.permissions!.access, false);
    });
    test('all was false and then make it still false and test config  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.config = false;

      EditBanned.changePermossionAll(false);
      expect(EditBanned.permissions!.config, false);
    });
    test('all was false and then make it still false and test flair  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.flair = false;

      EditBanned.changePermossionAll(false);
      expect(EditBanned.permissions!.flair, false);
    });
    test('all was false and then make it still false and test posts  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.posts = false;

      EditBanned.changePermossionAll(false);
      expect(EditBanned.permissions!.posts, false);
    });
  });

  group('test change access', () {
    test('make access false and all initiall true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;

      EditBanned.permissions!.access = true;
      EditBanned.changePermossionAccess(false);
      expect(EditBanned.permissions!.all, false);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;

      EditBanned.permissions!.access = true;
      EditBanned.changePermossionAccess(false);
      expect(EditBanned.permissions!.access, false);
    });
    test('make access false , and  config-posts-flair true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.config = true;
      EditBanned.permissions!.flair = true;
      EditBanned.permissions!.posts = true;
      EditBanned.permissions!.all = false;
      EditBanned.changePermossionAccess(true);
      expect(EditBanned.permissions!.all, true);
    });
  });

  group('test change flair', () {
    test('make flair false and all initiall true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;

      EditBanned.permissions!.flair = true;
      EditBanned.changePermossionFlair(false);
      expect(EditBanned.permissions!.all, false);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;

      EditBanned.permissions!.flair = true;
      EditBanned.changePermossionFlair(false);
      expect(EditBanned.permissions!.flair, false);
    });
    test('make flaif false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.config = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.posts = true;
      EditBanned.permissions!.flair = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionFlair(true);
      expect(EditBanned.permissions!.all, true);
    });
    test('make flaif false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.config = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.posts = true;
      EditBanned.permissions!.flair = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionFlair(true);
      expect(EditBanned.permissions!.flair, true);
    });
  });

  group('test change config', () {
    test('make config false and all initiall true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.config = true;
      EditBanned.changePermossionConfig(false);
      expect(EditBanned.permissions!.all, false);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.config = true;
      EditBanned.changePermossionConfig(false);
      expect(EditBanned.permissions!.config, false);
    });
    test('make config false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.flair = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.posts = true;
      EditBanned.permissions!.config = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionConfig(true);
      expect(EditBanned.permissions!.all, true);
    });
    test('make flaif false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.flair = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.posts = true;
      EditBanned.permissions!.config = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionConfig(true);
      expect(EditBanned.permissions!.config, true);
    });
  });
  group('test change Posts', () {
    test('make posts false and all initiall true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.posts = true;
      EditBanned.changePermossionConfig(false);
      expect(EditBanned.permissions!.all, false);
    });
    test('all was false and then make it true  ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.all = true;
      EditBanned.permissions!.posts = true;
      EditBanned.changePermossionPosts(false);
      expect(EditBanned.permissions!.posts, false);
    });
    test('make config false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.flair = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.config = true;
      EditBanned.permissions!.posts = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionPosts(true);
      expect(EditBanned.permissions!.all, true);
    });
    test('make flaif false , and  config-posts-access true ', () {
      final EditBanned = EditModeratorScreenState();
      EditBanned.permissions!.flair = true;
      EditBanned.permissions!.access = true;
      EditBanned.permissions!.config = true;
      EditBanned.permissions!.posts = false;

      EditBanned.permissions!.all = false;
      EditBanned.changePermossionPosts(true);
      expect(EditBanned.permissions!.posts, true);
    });
  });
}
