import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../logins/screens/login.dart';
import './custom_snack_bar.dart';

class HandleError {
  static errorHandler(DioError? error, BuildContext context) {
    String errorMessage = '';
    if (error!.response != null && error.response!.statusCode != null) {
      if (error.response!.statusCode == 404) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 404';
      } else if (error.response!.statusCode == 500) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 500';
      } else if (error.response!.statusCode == 400) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 400';
      } else if (error.response!.statusCode == 401) {
        Navigator.of(context).popAndPushNamed(Login.routeName);
      } else if (error.response!.statusCode == 304) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 304';
      } else if (error.response!.statusCode == 405) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 405';
      } else if (error.response!.statusCode == 409) {
        errorMessage = error.response!.data['errorMessage'] ?? 'Error 409';
      } else {
        errorMessage = error.error.toString();
      }
    } else {
      errorMessage = 'Error😔';
    }
    HandleError.handleError(errorMessage, context);
  }

  static handleError(String errorText, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      CustomSnackBar(isError: true, text: errorText, disableStatus: true),
      // SnackBar(
      //     content: Text(errorText, style: TextStyle(color: Colors.white)),
      //     backgroundColor: Colors.red),
    );
  }
}
