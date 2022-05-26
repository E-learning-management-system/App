

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_summernote/flutter_summernote.dart';

class RecordHomeWorkController extends ChangeNotifier
{
  final controllerResponse =  TextEditingController();
  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
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