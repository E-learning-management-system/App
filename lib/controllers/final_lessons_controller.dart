

import 'package:flutter/material.dart';
import 'package:project/helpers/sharedPreferences.dart';

class FinalLessonsController extends ChangeNotifier
{

  final textEditController2 = TextEditingController();
  final ScrollController scrollController = ScrollController();
  List<String> listItems = [];


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