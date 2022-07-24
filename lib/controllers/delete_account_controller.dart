import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';

class DeleteAccountController extends ChangeNotifier {
  bool isLoading = false;

  final keyForm = GlobalKey<FormState>();

  deleteAccount() async {
    final _token = await sharedPreferences.getToken('token');
    var url = 'https://api.piazza.markop.ir/deleteaccount/';
    isLoading = true;
    notifyListeners();
    var response = await http.delete(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Token " + _token,
      },
    );
    print(Utf8Decoder().convert(response.bodyBytes));
    if (response.statusCode == 204) {
      isLoading = false;
      sharedPreferences.setLogin();
      notifyListeners();
      return true;
    } else {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
