
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';

class VerifyEmailController extends ChangeNotifier
{

  final String _url='https://api.piazza.markop.ir/signup/verification/';
  late final String _token;
  String get token=>_token;
  bool isLoading = false;
  Future verifyEmailRequest( var email, var code)
  async{
    print(code);
    isLoading=true;
    notifyListeners();
    var response= await http.put(Uri.parse(_url),
      headers: {'Content-type':'application/json'},
      body: jsonEncode({
        "email":email,
        "code":code,
      }),
    );
    isLoading=false;
    notifyListeners();

    print(response.body);

    Map<String, dynamic> res = jsonDecode(response.body);
    _token=res.containsKey("token")?res["token"]:"";

    notifyListeners();
    if( _token.isNotEmpty){
      sharedPreferences.setToken("token", _token);
          return true;
    }
    else {
      return false;
    }
  }

}