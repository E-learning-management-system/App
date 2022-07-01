
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';
class ChangePwController extends ChangeNotifier{

  bool isLoading =false;

  final keyForm = GlobalKey<FormState>();

  changhPW(password)async {
    final _token= await sharedPreferences.getToken('token');
    var url='https://api.piazza.markop.ir/forgotpassword/verification/changepassword/';
    isLoading = true;
    notifyListeners();
     var response = await http.put(Uri.parse(url),
        headers: {'Content-type': 'application/json',
          "Authorization": "Token " + _token,},
        body: jsonEncode({

          "new_password": password,
          "new_password_confirmation": password
        }),
      );
print(Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      isLoading=false;
      sharedPreferences.setLogin();
      notifyListeners();
      return true;
    }
    else {
      isLoading=false;
      notifyListeners();
      return false;
  }
  }

}