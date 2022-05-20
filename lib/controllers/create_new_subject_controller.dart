


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
}