
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';

import '../models/profile_model.dart';

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
      sharedPreferences.setLogin();
     await getProfile();
          return true;
    }
    else {
      return false;
    }
  }
  Future verifyEmailForget( var email, var code)
  async{
    print(code);
    isLoading=true;
    notifyListeners();
    var url='https://api.piazza.markop.ir/forgotpassword/verification/';
    var response= await http.put(Uri.parse(url),
      headers: {'Content-type':'application/json'},
      body: jsonEncode({
        "email":email,
        "code":code,
      }),
    );
    isLoading=false;
    notifyListeners();

    print(const Utf8Decoder().convert(response.bodyBytes));

    if( response.statusCode==200){
      Map<String, dynamic> res = jsonDecode(response.body);
      var token1=res["token"];
      await sharedPreferences.setToken("token", token1);
      _token=token1;
      await getProfile();
      notifyListeners();
      return true;
    }
    else {
      notifyListeners();
      return false;
    }
  }


  getProfile()async{
    var url='https://api.piazza.markop.ir/profile/';
    ProfileModel profile;
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );
    print("jsonDecode(list of lesson)=   "+ (response.body));
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data.containsKey("id")){
      profile=ProfileModel.fromJson(data);
      sharedPreferences.setType(data['type']);
      return profile;
    }
    return false;
  }
}

