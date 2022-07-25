import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/profile_model.dart';

class ChangeSettingControler extends ChangeNotifier {
  bool isLoading = false;
  late final String _token;
  String get token => _token;

  final keyForm = GlobalKey<FormState>();
  getProfile() async {
    final _token = await sharedPreferences.getToken('token');
    var url = 'https://api.piazza.markop.ir/profile/';
    ProfileModel profile;
    var response = await http.get(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "Authorization": "Token " + _token,
      },
    );
    final Map<String, dynamic> data = jsonDecode(response.body);
    if (data.containsKey("id")) {
      profile = ProfileModel.fromJson(data);
      sharedPreferences.setType(data['type']);
      print(sharedPreferences.getType());
      return profile;
    }
    return false;
  }

  changeEmail(email) async {
    final _token = await sharedPreferences.getToken('token');
    var url = 'https://api.piazza.markop.ir/changeemail/';
    isLoading = true;
    notifyListeners();
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Token " + _token,
      },
      body: jsonEncode({
        "new_email": email,
      }),
    );
    print(Utf8Decoder().convert(response.bodyBytes));
    if (response.statusCode == 200) {
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

  changeProfile(inName, inBio, inPhoto) async {
    final _token = await sharedPreferences.getToken('token');
    var url = 'https://api.piazza.markop.ir/profile/';
    isLoading = true;
    notifyListeners();
    var response = await http.put(
      Uri.parse(url),
      headers: {
        'Content-type': 'application/json',
        "Authorization": "Token " + _token,
      },
      body: jsonEncode({
        "name": inName,
        "bio": inBio,
        "photo": inPhoto,
      }),
    );
    print(Utf8Decoder().convert(response.bodyBytes));
    if (response.statusCode == 200) {
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
