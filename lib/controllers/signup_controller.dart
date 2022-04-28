
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignUpController extends ChangeNotifier
{
  final String _url='https://api.piazza.markop.ir/signup/';

  Future SignUpRequest(var type,  var university, var email, var password, var passwordConfirmation)
  async{
    print("pass:"+password+ "  passc:"+passwordConfirmation);
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
   
   notifyListeners();
   return jsonDecode(response.body);
  }

  String dropdownValue = "استاد";
  final formSignupKey = GlobalKey<FormState>();

  void updateValueFormField(String value) {
   dropdownValue = value;
   notifyListeners();
  }

}