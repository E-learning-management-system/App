
import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';

class LastTopicController extends ChangeNotifier
{
  final textEditController = TextEditingController();
  var listModel =[
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'زمان امتحان کی هست ؟ ',
          category: 'Subject'),
    ]
  ];
  var listComments = [
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'زمان امتحان کی هستزمان امتحان کی هستزمان امتحان کی هست ؟ ',
         category: 'Subject'),
    ]
  ];


  void changeExpanded(int index){

    listModel[index].isExpanded =!listModel[index].isExpanded!;
    notifyListeners();

}

   void addItemComment()
   {
     final data = ItemCategoryModel(
         title: textEditController.text,
         category: 'subjects');
     listComments.add(data);
     textEditController.clear();
     notifyListeners();
   }


}