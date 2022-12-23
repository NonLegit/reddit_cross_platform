import 'package:flutter_test/flutter_test.dart';
import 'package:post/other_profile/widgets/position_other_profile_web.dart';
import '../../other_profile/widgets/position_other_profile_web_test.dart';
void main() {
   group(
    'follow button web ...',
    () {
      // final createCommunity = CreateCommunity();
      final positionOtherProfileWebState =PositionOtherProfileWebState();
       test('Follow test', () {
        // TODO: Implement test
   bool result =  positionOtherProfileWebState.followSucceeded();
        expect(result, true);
      });
           test('unFollow', () {
        // TODO: Implement test
   bool result = positionOtherProfileWebState.unFollowsucceeded();
        expect(result, false);
      });
    },
  );
}