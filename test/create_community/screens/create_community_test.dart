import 'package:flutter_test/flutter_test.dart';
import '../../../lib/create_community/screens/create_community.dart';

void main() {
<<<<<<< HEAD
=======
      final createCommunityState = CreateCommunityState();

>>>>>>> origin/Eman
  group(
    'Create Community',
    () {
      // final createCommunity = CreateCommunity();
<<<<<<< HEAD
      final createCommunityState = CreateCommunityState();
      test('create community ', () {
        // TODO: Implement test
        createCommunityState.choosenCommunityType = 'private';
=======
      test('create community ', () {
        // TODO: Implement test
>>>>>>> origin/Eman
        String? result = createCommunityState.validateTextField('ddsdfs');
        expect(result, null);
      });

      test('create community textFieldValidation wrong characters', () {
        // TODO: Implement test
        String? result = createCommunityState.validateTextField('ddware@ddf');
        expect(result,
            'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores');
      });
      test('create community textFieldValidation less than 3', () {
        // TODO: Implement test
        String? result = createCommunityState.validateTextField('dd');
        expect(result,
            'Community names must be between 3-21 characters,and\n only contain letters,numbers or underscores');
      });
    },
  );
<<<<<<< HEAD
=======

  test('Test how many remaining characters left and test clearing', () {
    createCommunityState.changeCounterValue('asdadczxc');
    expect(12, createCommunityState.count); 
    
    createCommunityState.clearTextField();
    expect(21, createCommunityState.count);
  },);


>>>>>>> origin/Eman
}
