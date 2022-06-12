import 'package:project/models/comment_model.dart';

class ListOfComment{
  List<CommentItemModel> comment=[];
  int number;
  bool isTComment=false;
  late CommentItemModel tComment;
  ListOfComment({required this.number,required List<CommentItemModel> comments}){
    if(number>0){
      comment=comments;
      for(var i in comments){
        if(i.is_teacher=='True'){
          tComment=i;
          isTComment=true;
        }
      }
    }
  }
}