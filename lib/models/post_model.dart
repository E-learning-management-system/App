



class PostItemModel {
 int         id=0;
 int    user_id=0;
 String user_email='';
 int subject_id=0;
 int  course_id=0;
 int   comments=0;
 int      likes=0;
 int   subject_title=0;
 String course_teacher='';
 String   course_title='';
 String          title='';
 String    description='';
 String           date='';
 String           file='';
 String  is_liked='False';
 String  is_saved='False';

  PostItemModel({

    required this.id,
    required this.user_id,
    required this.user_email,
    required this.subject_id,
    required this.course_id,
    required this.comments,
    required this.likes,
    required this.subject_title,
    required this.course_teacher,
    required this.course_title,
    required this.title,
    required this.description,
    required this.date,
    required this.file,
    required this.is_liked,
    required this.is_saved,
  });

  PostItemModel.fromJson(Map<String,dynamic> item){
     id=item['id'];
     user_id=item['user_id'];
     user_email=item['user_email'];
     subject_id=item['subject_id'];
     course_id=item['course_id'];
     comments=item['comments'];
     likes=item['likes'];
     subject_title=item['subject_title'];
     course_teacher=item['course_teacher'];
     course_title=item['course_title'];
     title=item['title'];
     description=item['description'];
     date=item['date'];
     file=item['file'].runtimeType==String? item['file']:'';
     is_liked=item['is_liked'];
     is_saved=item['is_saved'];
  }

  bool isExpand=false;
  get isExpanded => isExpand;

  toggleExpand(){

    if(isExpand){
      isExpand=false;
    }else{
      isExpand=true;
    }
  }
}