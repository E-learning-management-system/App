
import 'dart:convert';

import 'package:flutter/material.dart';

import '../helpers/sharedPreferences.dart';
import '../models/profile_model.dart';
import 'package:http/http.dart' as http;

class ProfileController extends ChangeNotifier
{


  getProfile(email)async{
    var url='https://api.piazza.markop.ir/profile/$email/';

    var response= await http.get(Uri.parse(url),
      headers: { "content-type": "application/json",},
    );
    print(response.statusCode);
    if(response.statusCode==200){
      final Map<String, dynamic> data = jsonDecode(response.body);
     try{
       ProfileModel profile=ProfileModel.fromJson(data);
       return profile;
     }catch(e){
       print(e);
     }
    }
    return false;

  }

}