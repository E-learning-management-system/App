


import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:http/http.dart' as http;

class CreateNewSubjectController extends ChangeNotifier{

  final controllerTitle = TextEditingController();
  final controllerBody = TextEditingController();

  File? file;
  void uploadFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      notifyListeners();
    } else {
    }
  }
  void deleteFile()async{
    if(file!=null)
      {
        file!.delete();
        file=null;
      }
    notifyListeners();
  }

  addSubject(int id)async{
    var _url='https://api.piazza.markop.ir/soren/subjects/$id/newpost/';
    var _token=await sharedPreferences.getToken('token');
    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},body:jsonEncode({
        "title":controllerTitle.text,
        "description": controllerBody.text,
        "file": file!=null ? file!.path : null,
      }),
    );

    print("jsonDecode(add post)=   "+ const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("id")){
      return true;
    }
    return false;
  }
}