// import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../networks/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final url = 'https://api.nonlegit.click/api/v1';
  bool error = false;
  String errorMessage = '';
  String token = '';
  String expiresIn = '';
  Future<void> sinUp(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/signup'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });

      error = response.statusCode != 201;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      } else {
        token = json.decode(response.body)['token'];
        expiresIn = (json.decode(response.body)['expiresIn'] as int).toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('expiresIn', expiresIn);
        await prefs.setString('userName', query['userName'] as String);
      }
      notifyListeners();
    } catch (error) {
      print('error');
    }
    print(token);
  }

  Future<void> login(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/login'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      error = response.statusCode != 200;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      } else {
        token = json.decode(response.body)['token'];
        expiresIn = (json.decode(response.body)['expiresIn'] as int).toString();
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);
        await prefs.setString('expiresIn', expiresIn);
        await prefs.setString('userName', query['userName'] as String);
      }
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<bool> availableUserName(userName) async {
    http.Response? response = null;
    try {
      response = await http.get(
          Uri.parse(url + '/users/username_available?userName=' + userName),
          headers: {
            'Accept': 'application/json',
          });
      notifyListeners();
    } catch (error) {
      print('error');
    }
    return jsonDecode(response!.body)['available'];
  }

  Future<bool> changeGender(String Gender) async {
    http.Response? response = null;

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') as String;
      print(token);

      /// change geneder need cookies
      response = await http.patch(Uri.parse(url + '/users/me/prefs'),
          body: json.encode({"gender": Gender}),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer ' + token,
          });
      notifyListeners();
    } catch (error) {
      print('error');
    }

    try {
      final prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token') as String;
      print(token);

      /// change geneder need cookies
      response = await http.get(Uri.parse(url + '/users/me/prefs'), headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ' + token,
      });
      notifyListeners();
    } catch (error) {
      print('error');
    }

    print(json.decode(response!.body)['errorMessage']);
    return response.statusCode == 200;
  }

  Future<void> forgetUserName(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/forgot_username'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      error = response.statusCode != 204;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }

  Future<void> forgetPassword(Map<String, String> query) async {
    try {
      final http.Response response = await http.post(
          Uri.parse(url + '/users/forgot_username'),
          body: json.encode(query),
          headers: {
            'Content-type': 'application/json',
            'Accept': 'application/json',
          });
      error = response.statusCode != 204;
      if (error) {
        errorMessage = json.decode(response.body)['errorMessage'];
      }
      notifyListeners();
    } catch (error) {
      print('error');
    }
  }
}
