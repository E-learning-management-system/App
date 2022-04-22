

import 'package:flutter/material.dart';
class SignUpController extends ChangeNotifier
{
  String dropdownValue = "استاد";
  final formSignupKey = GlobalKey<FormState>();

  void updateValueFormField(String value) {
   dropdownValue = value;
   notifyListeners();
  }

}