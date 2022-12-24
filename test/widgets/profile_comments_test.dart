import 'package:flutter_test/flutter_test.dart';
import '../../lib/widgets/profile_comments.dart';
void main() {
  group(
    'profile comments ...',
    () {
      // final createCommunity = CreateCommunity();
      final profileCommentsState = ProfileCommentsState();
      test('Comment date1', () {
        // TODO: Implement test
       String result = profileCommentsState.dateOfcomment('2022-09-24T14:15:22Z');
        expect(result, '3mon');
      });
       test('Comment date2', () {
        // TODO: Implement test
       String result = profileCommentsState.dateOfcomment('2021-08-24T14:15:22');
        expect(result, '1y');
      });
       test('Comment date3', () {
        // TODO: Implement test
       String result = profileCommentsState.dateOfcomment('2022-11-24T14:15:22Z');
        expect(result, '3w');
      });

       test('Loading more comments', () {
        // TODO: Implement test
   bool result = profileCommentsState.toggleLoadingMore();
        expect(result, true);
      });
    },
  );
}
