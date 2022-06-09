



class CommentItemModel {
  int id=0;
  int post_id=0;
  String  user_email='';
  String  user_photo='';
  String   is_teacher='';
  String text='';
  String date='';


  CommentItemModel({

    required this.id,
    required this.user_photo,
    required this.user_email,
    required this.is_teacher,
    required this.post_id,
    required this.text,
    required this.date,

  });

  CommentItemModel.fromJson(Map<String,dynamic> item){
    id=item['id'];
    user_photo=item['user_photo'];
    user_email=item['user_email'];
    is_teacher=item['is_teacher'];
    post_id=item['post_id'];
    text=item['text'];
    date=item['date'];

  }
}