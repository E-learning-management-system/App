
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier
{
  late String _email="";
  final String _url='https://api.piazza.markop.ir/signup/';
  String get email=>_email;
  bool isLoading = false;

  Future SignUpRequest(var type,  var university, var email, var password, var passwordConfirmation)
  async{
     isLoading = true;
     notifyListeners();
     var response= await http.post(Uri.parse(_url),
        headers: {'Content-type':'application/json'},
        body: jsonEncode({
             "type":type,
             "email":email,
             "university":university,
             "password":password,
             "password_confirmation":passwordConfirmation,
        }),
    );
     isLoading = false;
     notifyListeners();
   // print("jsonDecode(response.body)=   "+jsonDecode(response.body));
   print ("email="+email);
   if(jsonDecode(response.body)==email){
     _email=email;
     return true;
   }
   return false;
  }

  String dropdownValue = "انتخاب کنید";
  final formSignupKey = GlobalKey<FormState>();

  void updateValueFormField(String value) {
   dropdownValue = value;
   notifyListeners();
  }

}