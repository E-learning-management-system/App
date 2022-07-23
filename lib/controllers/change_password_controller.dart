import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';

class ChangePasswordController extends ChangeNotifier {
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  changePassword(password, oldPassword) async {
    final _token = await sharedPreferences.getToken('token');
    var url = 'https://api.piazza.markop.ir/changepassword/';
    isLoading = true;
    notifyListeners();
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Token " + _token,
      },
      body: jsonEncode({
        "old_password": oldPassword,
        "new_password": password,
        "new_password_confirmation": password
      }),
    );
    print(Utf8Decoder().convert(response.bodyBytes));
    if (response.statusCode == 200) {
      isLoading = false;
      sharedPreferences.setLogin();
      notifyListeners();
      return 'ok';
    } else if (response.statusCode == 400) {
      isLoading = false;
      notifyListeners();
      return 'old';
    } else {
      isLoading = false;
      notifyListeners();
      return 'others';
    }
  }
}
