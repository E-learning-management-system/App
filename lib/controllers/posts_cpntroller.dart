


import 'dart:html';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/comment_model.dart';
import 'package:project/models/like_model.dart';
import 'package:project/models/post_model.dart';

import '../models/list_of_comment.dart';

class PostsController extends ChangeNotifier
{
  final textEditController = TextEditingController();
  late String _token;
  int id=0;
  List<PostItemModel> posts=[];
  List<PostItemModel> savedPosts=[];
  late Map<int,List<LikeItemModel>> postLikes={};
  late Map<int,ListOfComment> postComments={};
  String user='';


  setId(int id){
    this.id=id;
  }
  setToken()async{
    _token=await sharedPreferences.getToken('token');
  }
  getPostsOfSubject(int id)async{
    posts=[];
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/subjects/$id/posts/';
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of Posts)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      if (data["results"].length>0) {
        final List< dynamic> list = data["results"];
        for(var v in list) {
          posts.add(PostItemModel.fromJson(Map<String,dynamic>.from(v)));
          getLikeOfPost(Map<String,dynamic>.from(v)['id']);
          getCommentsOfPost(Map<String,dynamic>.from(v)['id']);
          if(Map<String,dynamic>.from(v)['is_saved']=='True'){
            savedPosts.add(PostItemModel.fromJson(Map<String,dynamic>.from(v)));
          }
        }
      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  // getPost(){
  //
  // }
  getCommentsOfPost(int id)async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/posts/$id/comments/';
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of comments)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      List <CommentItemModel> comments=[];
      if (data["results"].length>0) {
        final List< dynamic> list = data["results"];
        for(var v in list) {
          comments.add(CommentItemModel.fromJson(Map<String,dynamic>.from(v)));
        }
        postComments[id]=ListOfComment(number: data["count"], comments: comments);
        notifyListeners();
        return true;
      }
      postComments[id]=ListOfComment(number: data["count"], comments: comments);
      notifyListeners();
      return false;
    }
    notifyListeners();
    return false;
  }
  getLikeOfPost(int id)async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/posts/$id/likes/';
    var response= await http.get(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(list of likes)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("results")){
      if (data["results"].length>0) {
        final List< dynamic> list = data["results"];
        List <LikeItemModel> likes=[];
        for(var v in list) {
          likes.add(LikeItemModel.fromJson(Map<String,dynamic>.from(v)));
        }
        postLikes[id]=likes;
      }
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  addPost(){}
  deletePost(){}
  savePost(data)async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/savepost/${data.id}/';
    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
      body: jsonEncode({
        "file":''
      })
    );

    print("jsonDecode(save post)=   "+const Utf8Decoder().convert(response.bodyBytes));
    if(response.statusCode==200){
      savedPosts.add(data);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  unSavePost(id)async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/unsavepost/$id/';
    var response= await http.post(Uri.parse(_url),
        headers: { "content-type": "application/json",
          "Authorization": "Token " + _token,},
        body: jsonEncode({
          "file":''
        })
    );

    if(response.statusCode==200){
      savedPosts.removeWhere((element) => element.id==id);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  addComment(String text,int id )async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/posts/$id/newcomment/';
    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
      body: jsonEncode({
        "text": text,
      }),
    );

    print("jsonDecode(comment post)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("id")){
      postComments[id]!.comment.add(CommentItemModel.fromJson(data));
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  removeLike(int PostId)async{
    await setToken();
    int id=0;
    postLikes[PostId]!.map((e) => {
      if(e.user==user){
        id=e.id
      }
    });
    String  _url= 'https://api.piazza.markop.ir/soren/removelike/$id/';
    var response= await http.delete(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    if(response.statusCode==204){
      postLikes[PostId]!.removeWhere((element) => element.id == id);
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
  likePost(id)async{
    await setToken();
    String  _url= 'https://api.piazza.markop.ir/soren/posts/$id/newlike/';
    var response= await http.post(Uri.parse(_url),
      headers: { "content-type": "application/json",
        "Authorization": "Token " + _token,},
    );

    print("jsonDecode(like post)=   "+const Utf8Decoder().convert(response.bodyBytes));
    final Map<String, dynamic> data = json.decode(const Utf8Decoder().convert(response.bodyBytes));
    if(data.containsKey("id")){

      if(postLikes[id] == null){
        postLikes[id]=[LikeItemModel.fromJson(data)];
      }else{
        postLikes[id]!.add(LikeItemModel.fromJson(data));
      }
      user=data['user'];
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }

  void changeExpanded(int index) {
    posts[index].toggleExpand();
    notifyListeners();
  }

}
