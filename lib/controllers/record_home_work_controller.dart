

import 'dart:convert';
import 'dart:async';
import 'package:async/async.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:path/path.dart';
import 'package:permission_handler/permission_handler.dart';


class RecordHomeWorkController extends ChangeNotifier
{
  final controllerResponse =  TextEditingController();
  GlobalKey<FlutterSummernoteState> keyEditor = GlobalKey();
  late TextEditingController titleController;
  late TextEditingController desController;
  setTitle(title){
    titleController=TextEditingController(text: title);
  }
  setDes(des){
    desController=TextEditingController(text: des);
  }
  File? file;
  String? date;
  bool isLoading=false;
  void uploadFile() async{
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: [ 'png']);
    if(result != null) {
      file = File(result.files.first.path!);
      print(file!.path);
      notifyListeners();
    } else {
    }
  }
  void deleteFile()async{
    if(file!=null)
    {
      file=null;
    }
    notifyListeners();
  }
  String calPercentage(int first , int two)
  {
    final per = (first / two ) * 100;
    final result = per.toString() +'%';
    return result + '\n'+ 'تخویل داده اند';
  }

  Future newExercise(id)async{
    String url='https://api.piazza.markop.ir/soren/courses/$id/newexercise/';
   var  _token = await sharedPreferences.getToken('token');
    RegExp exp = RegExp(r"<[^>]*>",multiLine: true,caseSensitive: true);
    var des=await keyEditor.currentState?.getText();

    var request = http.MultipartRequest("POST",Uri.parse(url));
    Map<String, String> headers = { "Authorization": "Token $_token"};
    var stream = http.ByteStream(DelegatingStream.typed(file!.openRead()));

    var length = await file?.length();

    var multipartFile = http.MultipartFile('file', stream, length!,
        filename: basename(file!.path));
    request.files.add(multipartFile);
    request.headers.addAll(headers);
    request.fields.addAll({"title": titleController.text,
      "description": des!.replaceAll(exp, ' '),
      "deadline": date! });

    var response = await request.send();
    print("response status code(new exercise)=   "+(response.statusCode.toString()));
    print("response =   "+(request.toString()));
    if(response.statusCode==201){
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;

  }
  Future deleteExercise(id)async{
    String url='https://api.piazza.markop.ir/soren/exercise-rd/$id/';
    var  _token = await sharedPreferences.getToken('token');

    var response= await http.delete(Uri.parse(url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(delete exercise)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==204){
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;

  }
  Future newAnswer(id)async{
    String url='https://api.piazza.markop.ir/soren/exercises/$id/newanswer/';
    var  _token = await sharedPreferences.getToken('token');
    var des=await keyEditor.currentState?.getText();
    print(des);
    var response= await http.post(Uri.parse(url),
        headers: { "content-type": "application/json",
          "Authorization": "Token " + _token,},body:
        jsonEncode
          ({
          "description": des,
          "file": file

        })
    );

    print("jsonDecode(new answer)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==201){
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;

  }
  Future<String> getFilePath(id) async {
      Directory? directory = await getExternalStorageDirectory();
      String newPath = "";
      List<String> paths = directory!.path.split("/");
      for (int x = 1; x < paths.length; x++) {
        String folder = paths[x];
        if (folder != "Android") {
          newPath += "/" + folder;
        } else {
          break;
        }
      }

    return newPath+'/file$id.png';
  }
  Future  downloadFile(file,id)async{
    isLoading=true;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      Permission.accessMediaLocation,
      Permission.manageExternalStorage
    ].request();

    if(statuses[Permission.storage]!.isGranted){
        String savePath = await getFilePath(id);
    var response = await Dio().download(file,savePath,onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
        //you can build progressbar feature too
      }
    });
        isLoading=false;
    return " فایل در آدرس $savePath ذخیره شد. ";
    }
    print("No permission to read and write.");
    isLoading=false;
    return false;
  }

  void showDate(BuildContext context)async{
     date =  await jalaliCalendarPicker(context: context, showTimePicker: true,
         selectedFormat: 'yyyy-mm-ddThh:m' );
     notifyListeners();
  }
}