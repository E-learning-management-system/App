import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project/controllers/home_controller.dart';
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/exercise_item_model.dart';
import 'package:project/models/lessons_item_model.dart';
import 'package:project/models/post_model.dart';
import 'package:project/models/subject_item_model.dart';
import 'package:project/widgets/app_bar_widget.dart';
import 'package:project/widgets/elevation_button.dart';
import 'package:project/widgets/text_field_widget.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
class ItemLessonsController extends ChangeNotifier{
  ItemLessonsController(){
    setLastTopics();
  }


late int id=0;

List<PostItemModel> savedPosts=[];
 List<SubjectsItemModel> _listOfSubjectOfCourse=[];
 List<ExerciseItemModel> _listOfExerciseOfCourse=[];
 get listOfSubjectOfCourse=> _listOfSubjectOfCourse;
 get listOfExerciseOfCourse=>_listOfExerciseOfCourse;
 get saved=>savedPosts;
late String _token;
var status ;
List<dynamic> listModel = [];

String titleOfNewSubject='';

 bool isLoading =false;

setId(int id){
  this.id=id;
}
unSavePost(id)async{
  await sharedPreferences.getToken('token').then((value)=>{_token=value});
  String  _url= 'https://api.piazza.markop.ir/soren/unsavepost/$id/';
  var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
      body: jsonEncode({
        "file":''
      })
  );
  if(response.statusCode==200){
    savedPosts.removeWhere((element) => element.id==id);
    await setItemCategory(StatusCategory.BookMark);
    notifyListeners();
    return true;
  }
  notifyListeners();
  return false;
}
getSavedPost()async{
  isLoading =true;
  notifyListeners();
  await sharedPreferences.getToken('token').then((value)=>{_token=value});
  String  _url= 'https://api.piazza.markop.ir/soren/savedposts/';
  var response= await http.get(Uri.parse(_url),
    headers: { "content-type": "application/json",
      "Authorization": "Token " + _token,},
  );

  print("jsonDecode(list of savedPosts)=   "+Utf8Decoder().convert(response.bodyBytes));
  final Map<String, dynamic> data = json.decode(Utf8Decoder().convert(response.bodyBytes));
  if(data.containsKey("results")){
    if (data["results"].length>0) {
      final List< dynamic> list = data["results"];
      for(var v in list) {
        savedPosts.add(PostItemModel.fromJson(Map<String,dynamic>.from(v)));
      }
    }
    isLoading=false;
    notifyListeners();
    return true;
  }
  isLoading=false;
  notifyListeners();
  return false;
}
Future getSubjectsOfCourse(id)
async{
  isLoading =true;
  notifyListeners();
  await sharedPreferences.getToken('token').then((value)=>{_token=value});
  String url='https://api.piazza.markop.ir/soren/courses/$id/subjects/';

  var response= await http.get(Uri.parse(url),
    headers: { "content-type": "application/json",
      "Authorization": "Token " + _token,},
  );
  isLoading =false;
  notifyListeners();
  print("jsonDecode(list of subjects)=   "+Utf8Decoder().convert(response.bodyBytes));
  final Map<String, dynamic> data = json.decode(Utf8Decoder().convert(response.bodyBytes));
  if(data.containsKey("results")) {
    if (data["results"].length>0) {
      final List< dynamic> list = data["results"];
      for(var v in list) {
        _listOfSubjectOfCourse.add(SubjectsItemModel.fromJson(Map<String,dynamic>.from(v)));
      }
      return true;
    }
    _listOfSubjectOfCourse=[];
    return true;
  }
    notifyListeners();
    return false;
}
Future getExerciseOfCourse(id)
async{
  isLoading =true;
  notifyListeners();
  await sharedPreferences.getToken('token').then((value)=>{_token=value});
  String url='https://api.piazza.markop.ir/soren/courses/$id/exercises/';

  var response= await http.get(Uri.parse(url),
    headers: { "content-type": "application/json",
      "Authorization": "Token " + _token,},
  );
  isLoading =false;
  notifyListeners();
  print("jsonDecode(list of subjects)=   "+const Utf8Decoder().convert(response.bodyBytes));
  final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
  if(data.containsKey("results")) {
    if (data["results"].length>0) {
      final List< dynamic> list = data["results"];
      for(var v in list) {
        _listOfExerciseOfCourse.add(ExerciseItemModel.fromJson(Map<String,dynamic>.from(v)));
      }
      return true;
    }
    _listOfExerciseOfCourse=[];
    return true;
  }
  notifyListeners();
  return false;
}
  setHomeWork() async{
  _listOfExerciseOfCourse=[];
   await getExerciseOfCourse(id);
    listModel=_listOfExerciseOfCourse;
    status = StatusCategory.HomeWork;
    notifyListeners();
  }
  setLastTopics()async {
  _listOfSubjectOfCourse=[];
   await getSubjectsOfCourse(id);
    listModel=_listOfSubjectOfCourse;
    status = StatusCategory.LastTopics;
    notifyListeners();
  }
  void setBookMark()async {
savedPosts=[];
await getSavedPost();
listModel=savedPosts;
    status = StatusCategory.BookMark;
    notifyListeners();
  }

  void setUsers()
  {
    listModel = [
      for (int i = 0; i < 3; i++) ...[
        LessonsItemModel(
            description: 'انتگرال یگانه',
            title: 'دانیال صابر',
            endDate: '1400/11/25',
            examDate: '',
            id: 4,
            startDate: '',
            teacher: ''
        ),
      ]
    ];
  }

 setItemCategory(StatusCategory status) async{

    if (status == StatusCategory.BookMark) {
      setBookMark();
      return;
    }
    if (status == StatusCategory.HomeWork) {
      await setHomeWork();
      return;
    }
    if (status == StatusCategory.LastTopics) {
      await setLastTopics();
      return;
    } else {
      this.status = status;
      setUsers();
      notifyListeners();
    }
  }





 openDialog(BuildContext context)
  {
    showDialog(context: context,
        builder: (cnt)
        => AlertDialog(
          scrollable: false,
          title: Text('نام مبحث'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormFieldWidget(hintText: 'نام موضوع را وارد کنید',onChanged: (text)=>{titleOfNewSubject=text},),
              sizedBox(height: 15),

              Consumer<ItemLessonsController>(
                builder: (context, value, child) {
                  if(value.isLoading)
                    {
                      return Center(child: const CircularProgressIndicator());
                    }
                  return ElevationButtonWidget(
                      call: ()async{var res=await addSubject(id);
                      if(res){
                        setLastTopics();
                        Navigator.pop(context);
                      }

                      },
                      text: 'ایجاد',
                    );
                },

              )
            ],
          ),
        )

        );
  }

addSubject(int id)async{
  isLoading =true;
  notifyListeners();
  var _url='https://api.piazza.markop.ir/soren/courses/$id/newsubject/';
  var _token=await sharedPreferences.getToken('token');
  var response= await http.post(Uri.parse(_url),
    headers: { "content-type": "application/json",
      "Authorization": "Token " + _token,},body:jsonEncode({
      "title":titleOfNewSubject,
    }),
  );
  isLoading =false;
  notifyListeners();
  print("jsonDecode(add subject)=   "+ const Utf8Decoder().convert(response.bodyBytes));
  final Map<String, dynamic> data = jsonDecode(const Utf8Decoder().convert(response.bodyBytes));
  if(data.containsKey("id")){
    return true;
  }

  return false;
}



}