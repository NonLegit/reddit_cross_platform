import 'package:shared_preferences/shared_preferences.dart';

class GetName {
  String? me;
  Future<void> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    me = prefs.getString('userName') as String;
  }

  String get username{
    return me!;
  }
}
