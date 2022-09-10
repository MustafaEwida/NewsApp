import 'dart:io';

class News_model {
  String? username;
  File? userimg;
 String? id;
 String title;
 String desc;
 DateTime? dateTime;
 String imgurl;
 bool isfavo ;
 News_model({required this.title,required this.desc,required this.imgurl,this.id ,this.dateTime,this.isfavo = false,this.username,this.userimg}) ;
  
}