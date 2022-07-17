

import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:jalali_table_calendar/jalali_table_calendar.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:dio/dio.dart' ;
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
    print('file:   '+file!.path!);
    var headers = {
      "content-type":'multipart/form-data',
      "Authorization": "Token " + _token,
    };
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.fields.addAll({
              "title": titleController.text,
              "description": des!.replaceAll(exp, ' '),
              "deadline": date! ,
    });
    request.files
        .add(await http.MultipartFile.fromPath('file', file!.path!));
    request.headers.addAll(headers);

    var response = await request.send();
  //   var response=await http.post(Uri.parse(url),
  //       headers: {
  //     // "content-type": "application/json",
  //     //   "Authorization": "Token " + _token,},
  //     "content-type":'multipart/form-data',
  //     "Authorization": "Token " + _token,
  //   },
  // body: jsonEncode({
  //     "title": titleController.text, "description":  des , "deadline": date, "file":file!.path!
  //   }) );

    // print("request(new exercise)=   "+request.fields.toString());
    print("response status code(new exercise)=   "+(response.statusCode.toString()));
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
    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory(); // 1
    String appDocumentsPath = appDocumentsDirectory.path; // 2
    String filePath = '$appDocumentsPath/file$id.png'; // 3

    return filePath;
  }
  Future  downloadFile(file,id)async{
    Map<Permission, PermissionStatus> statuses = await [
      Permission.storage,
      //add more permission to request here.
    ].request();

    if(statuses[Permission.storage]!.isGranted){
        String savePath = await getFilePath(id);
    var response = await Dio().download(file,savePath,onReceiveProgress: (received, total) {
      if (total != -1) {
        print((received / total * 100).toStringAsFixed(0) + "%");
        //you can build progressbar feature too
      }
    });
        print("File is saved to $savePath.");
    return true;
    }
    print("No permission to read and write.");
    return false;
  }

  void showDate(BuildContext context)async{
     date =  await jalaliCalendarPicker(context: context, showTimePicker: true,
         selectedFormat: 'yyyy-mm-ddThh:m' );
     notifyListeners();
  }
}