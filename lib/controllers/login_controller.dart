
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/profile_model.dart';
class LoginController extends ChangeNotifier
{

  final String _url='https://api.piazza.markop.ir/signin/';
  String? _token;
  String get token=>_token!;
  bool isLoading =false;
  String _email='';
  get email=>_email;

  Future loginRequest( var email, var password)
  async {

    isLoading = true;
    notifyListeners();
    print("sadsad");
    var response ;
    try {
       response = await http.post(Uri.parse(_url),
        headers: {'Content-type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
        }),
      );
    } on Exception catch (e) {
      print("Error  $e}");
      isLoading = false;
      notifyListeners();


    }


    print(response.body);
    isLoading=false;
    Map<String, dynamic> res = jsonDecode(response.body);
    _token=res.containsKey("token")?res["token"]:"";

    notifyListeners();
    if( _token!.isNotEmpty){
      sharedPreferences.setToken("token", _token);
      sharedPreferences.setLogin();
     await getProfile();
      return true;
    }
    else {
      isLoading=false;
      return false;
    }
  }

  getProfile()async{
    var url='https://api.piazza.markop.ir/profile/';
    ProfileModel profile;
    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token!,},
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    if(data.containsKey("id")){
      profile=ProfileModel.fromJson(data);
      sharedPreferences.setType(data['type']);
      print(sharedPreferences.getType());
      return profile;
    }
    return false;
  }
  final formLoginKey = GlobalKey<FormState>();

  forgetPassword(String email)async{
    var url='https://api.piazza.markop.ir/forgotpassword/';
    var response= await http.post(Uri.parse(url),
      headers: { "content-type": "application/json",},
        body:jsonEncode({
          "email": email
        }),
    );
    print(response.statusCode);
    if(response.statusCode==200){
      _email=email;
      return true;
    }
      return false;


  }

}