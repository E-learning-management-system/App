


import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project/helpers/sharedPreferences.dart';
import 'package:project/models/comment_model.dart';
import 'package:project/models/like_model.dart';
import 'package:project/models/post_model.dart';

class PostsController extends ChangeNotifier
{
  final textEditController = TextEditingController();
  late String _token;
  int id=0;
  List<PostItemModel> posts=[];
  List<PostItemModel> savedPosts=[];
  late Map<int,List<LikeItemModel>> postLikes;
  late Map<int,List<CommentItemModel>> postComments;


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
      if (data["results"].length>0) {
        final List< dynamic> list = data["results"];
        List <CommentItemModel> comments=[];
        for(var v in list) {
          comments.add(CommentItemModel.fromJson(Map<String,dynamic>.from(v)));
        }
        postComments[id]=comments;
      }
      notifyListeners();
      return true;
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
  savePost(){}
  unSavePost(){}
  addComment(){}
  deleteComment(){}
  likePost(){}

  void changeExpanded(int index) {
    posts[index].toggleExpand();
    notifyListeners();
  }

}
