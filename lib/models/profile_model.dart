


import 'package:flutter/material.dart';
import 'package:project/helpers/colors.dart';

class ProfileModel {


  int id=0;
  String  name="";
  String  email="";
  String  university="";
  String  type="";
  String  date_joined="";
  String  last_login="";
  String bio='';
  String photo='';
  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.university,
    required this.type,
    required this.date_joined,
    required this.last_login,
  this.bio='',
  this.photo='',
  });

  ProfileModel.fromJson(Map<String,dynamic> item){
    id=item["id"];
    name=item["name"];
    email=item["email"];
    university=item["university"].runtimeType==String?item["university"]:'';
    type=item["type"];
   date_joined=item["date_joined"];
   last_login=item["last_login"];
  bio=item['bio'].runtimeType==String?item['bio']:'';
    photo=item['photo'].runtimeType==String?item['photo']:'';
  }

}