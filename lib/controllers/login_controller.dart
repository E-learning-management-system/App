
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';
class LoginController extends ChangeNotifier
{

  final String _url='https://api.piazza.markop.ir/signin/';
  late final String _token;
  String get token=>_token;
  bool isLoading =false;

  Future loginRequest( var email, var password)
  async{
    isLoading=true;
    notifyListeners();
    var response= await http.post(Uri.parse(_url),
      headers: {'Content-type':'application/json'},
      body: jsonEncode({
        "email":email,
        "password":password,
      }),
    );
    isLoading=false;
    Map<String, dynamic> res = jsonDecode(response.body);
    _token=res.containsKey("token")?res["token"]:"";

    notifyListeners();
    if( _token.isNotEmpty){
      sharedPreferences.setToken("token", _token);
      sharedPreferences.setLogin();
      return true;
    }
    else {
      return false;
    }
  }
  final formLoginKey = GlobalKey<FormState>();

}