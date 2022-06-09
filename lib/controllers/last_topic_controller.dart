
import 'package:flutter/material.dart';
import 'package:project/models/book_mark_model.dart';
import 'package:project/models/item_category_model.dart';
import 'package:project/models/lessons_item_model.dart';

class LastTopicController extends ChangeNotifier
{
  final textEditController = TextEditingController();
  var listModel =[];
  var listComments = [];


  void changeExpanded(int index){

    listModel[index].isExpanded =!listModel[index].isExpanded;
    notifyListeners();

}

   void addItemComment()
   {
     final data = BookMarkModel(
         desc: 'انتگرال یگانه',
         title: textEditController.text,
         date: '1400/11/25',
         countCm: 25,
         name: 'دانیال صابر'
     );
     listComments.add(data);
     textEditController.clear();
     notifyListeners();
   }


}