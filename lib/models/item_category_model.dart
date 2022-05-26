


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class ItemCategoryModel{

  final String title;
  String urlImage='assets/images/image_2.PNG';
  Color bgColor=MyColors.orange;
  final String category;

  ItemCategoryModel(
  {required this.title, required this.category,
    }){
    if(category=='Lesson'){
      bgColor=MyColors.orange;
      urlImage='assets/images/image_2.PNG';
    }
    if(category=='Exercise'){
      bgColor=MyColors.blueHex;
      urlImage='assets/images/image_3.PNG';
    }
    if(category=='Subject'){
      bgColor=MyColors.purpleHex;
      urlImage='assets/images/image_4.PNG';
    }
  }
}