
import 'package:flutter/material.dart';
import 'package:project/models/item_category_model.dart';

class LastTopicController extends ChangeNotifier
{
  final textEditController = TextEditingController();
  var listModel =[
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'زمان امتحان کی هست ؟ ',
          date: '1400/11/25',
          name: 'دانیال صابر',
          countComment: 15,
          nameLesson: 'این تنهای یک پیغام تست است یک پیام تستتستتستتستتستتستتست تست',
          bgColor: Colors.white),
    ]
  ];
  var listComments = [
    for (int i = 0; i < 3; i++) ...[
      ItemCategoryModel(
          title: 'زمان امتحان کی هستزمان امتحان کی هستزمان امتحان کی هست ؟ ',
          date: '1400/11/25',
          name: 'علی',
          bgColor: Colors.white),
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
         bgColor: Colors.white,
        name: 'علی',
     date: '1400/11/25');
     listComments.add(data);
     textEditController.clear();
     notifyListeners();
   }


}