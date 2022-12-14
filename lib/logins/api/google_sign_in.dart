import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _clientIDWeb =
      '374002806091-7pces2dv4vr0vb8lchmputreqnlalqes.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
}
