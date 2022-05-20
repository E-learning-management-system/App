import 'package:flutter/material.dart';

class ItemCategoryModel {
  final String title;
  final String? date;
  final String? nameLesson;
  final Color bgColor;
  final String? name;
  final int? countComment;
   bool? isExpanded;

  ItemCategoryModel(
      {this.isExpanded = false,
      required this.title,
      this.date,
      required this.bgColor,
      this.nameLesson,
      this.name,
      this.countComment});
}
