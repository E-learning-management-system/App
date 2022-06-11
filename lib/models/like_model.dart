



class LikeItemModel {
  int id=0;
  int post_id=0;
  String  user='';
  String date='';


  LikeItemModel({

    required this.id,
    required this.user,
    required this.post_id,
    required this.date,

  });

  LikeItemModel.fromJson(Map<String,dynamic> item){
    id=item['id'];
    user=item['user'];
    post_id=item['post_id'];
    date=item['date'];

  }
}