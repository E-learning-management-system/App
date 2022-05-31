

import 'package:flutter/material.dart';

class FinalLessonsController extends ChangeNotifier
{

  final textEditController = TextEditingController(text: 'مدار های منطقی');
  final textEditController2 = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<String> listItems = ['testet@gmail.com',
    'testet@gmail.com'];


  void removeItem(int index)
  {
    listItems.removeAt(index);
    notifyListeners();
  }
  void addItemToList()
  {
    if(textEditController2.text.isNotEmpty)
      {
        listItems.add(textEditController2.text);
        notifyListeners();
        FocusManager.instance.primaryFocus?.unfocus();
        textEditController2.clear();
      }
    return;
  }
}