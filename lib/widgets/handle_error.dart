import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../logins/screens/login.dart';

class HandleError {
  static errorHandler(DioError? error, BuildContext context) {
    String errorMessage = '';
    if (error!.response!.statusCode == 404) {
      errorMessage = error.response!.data['errorMessage'];
    } else if (error.response!.statusCode == 500) {
      errorMessage = error.response!.data['errorMessage'];
    } else if (error.response!.statusCode == 400) {
      errorMessage = error.response!.data['errorMessage'];
    } else if (error.response!.statusCode == 401) {
      Navigator.of(context).popAndPushNamed(Login.routeName);
    } else if (error.response!.statusCode == 304) {
      errorMessage = error.response!.data['errorMessage'];
    } else if (error.response!.statusCode == 405) {
      errorMessage = error.response!.data['errorMessage'];
    } else if (error.response!.statusCode == 409) {
      errorMessage = error.response!.data['errorMessage'];
    } else {
      errorMessage = error.error.toString();
    }
    HandleError.handleError(errorMessage, context);
  }

  static handleError(String errorText, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(errorText, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.red),
    );
  }
}
