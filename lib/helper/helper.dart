



import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import '../models/User.dart';
import '../models/news_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
class FireStoreHelper {
  FireStoreHelper._();
  static FireStoreHelper fireStoreHelper = FireStoreHelper._();

  addtofirestore(News_model news_model) {
    final userid = FirebaseAuth.instance.currentUser!.uid;
    DateTime f =  DateTime.now();
    FirebaseFirestore.instance.collection("news").doc(f.toString()).set({
      
      'id' : f.toString(),
      'isfavo':news_model.isfavo,
      'title': news_model.title,
      'desc': news_model.desc,
      'imgurl': news_model.imgurl,
      'datetime':news_model.dateTime!.toString(),

    });
   
    FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(userid).doc(f.toString()).set({
      'id' : f.toString(),
      'isfavo':news_model.isfavo,
      'title': news_model.title,
      'desc': news_model.desc,
      'imgurl': news_model.imgurl,
      'datetime':news_model.dateTime!.toString(),

    });

  }

  adduser(User user,UserMdoel userMdoel,File img)async{
  
   final imgpath =  FirebaseStorage.instance.ref().child("imgs").child(user.uid+'.jpg');
  await imgpath.putFile(img).whenComplete(() {
       
   });
 String  imgurl =  await  imgpath.getDownloadURL();
 final token = await FirebaseMessaging.instance.getToken();
  await FirebaseMessaging.instance.subscribeToTopic('drch');
 FirebaseFirestore.instance.collection('use').doc(user.uid).set({
 'email':userMdoel.email,
 'gender':userMdoel.gender,
 'birth': userMdoel.birth.toString(),
 'name': userMdoel.name,
 'img': imgurl,
 'token' : token
    });
   


  }
  updatetoken(User user)async{
final toker = await FirebaseMessaging.instance.getToken();
await FirebaseMessaging.instance.subscribeToTopic('drch');
 FirebaseFirestore.instance.collection('use').doc(user.uid).update({

 'token' : toker
    });
  }
  changefavo(News_model news_model){
  //  news_model.isfavo = !news_model.isfavo;
    final uid =  FirebaseAuth.instance.currentUser!.uid;
  /*  FirebaseFirestore.instance.collection('news').doc(news_model.id).update({
       'isfavo':news_model.isfavo,
     });*/
      FirebaseFirestore.instance.collection("favo").doc("favoraite").collection(uid).doc(news_model.id).set( 
        {
       'isfavo':news_model.isfavo,
        'title': news_model.title,
      'desc': news_model.desc,
      'imgurl': news_model.imgurl,
       'datetime':news_model.dateTime!.toString(),

     },SetOptions(merge: true)); 
      FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid).doc(news_model.id).update({
         'isfavo':news_model.isfavo,
      }
        
      );
     
      
   
  /*  WriteBatch b = FirebaseFirestore.instance.batch();
     b.update(  FirebaseFirestore.instance.collection('news').doc(news_model.id), {
       'isfavo':news_model.isfavo,
     });
  b.update(   FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid).doc(news_model.id), {
      'isfavo':news_model.isfavo, });
    b.commit();
*/


    print(news_model.id);
      /* FirebaseFirestore.instance.collection('news').doc(news_model.id).update({

   'isfavo':news_model.isfavo,
 });

    FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid).doc(news_model.id).update({
      'isfavo':news_model.isfavo,

    });
*/
    
 

  }
  sendnotify(String title,String body,String id)async{
    final uri = Uri.parse('https://fcm.googleapis.com/fcm/send');
  await post(
   uri,
     headers: <String, String>{
       'Content-Type': 'application/json',
       'Authorization': 'key=AAAACHt4Ysw:APA91bHFKPrrr3Kp1yidO3w3ao6zUCisdr2WUfwNBb-78c9RHek9NWuHpyonz-_NLEgEUWy7Dp6P9QzoJP6hCfMxhlzpCTRCJxXLWfKuCZsjBta0RSsT08nGP-gAIBDbV40YQ-5Abmrz',
     },
     body:json.encode(
     <String, dynamic>{
       'notification': <String, dynamic>{
         'body': body,
         'title': title
       },
       'priority': 'high',
       'data': <String, dynamic>{
         'click_action': 'FLUTTER_NOTIFICATION_CLICK',
         'to':'/tpoic/drch',
         'id': '1',
         'status': 'done'
       },
        'to':'/topics/drch'
     },
    ),
  );

  }
  update(String f,News_model news_model){
  final uid =  FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance.collection("news").doc(f).update({
   'isfavo':news_model.isfavo,
      'title': news_model.title,
      'desc': news_model.desc,
      'imgurl': news_model.imgurl,
      'datetime':news_model.dateTime!.toString(),

  });
    FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid).doc(f.toString()).update({
      'id' : f.toString(),
   

    });


  }
  delete(String f){
 final uid =  FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance.collection("news").doc(f.toString()).delete();
    FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid).doc(f.toString()).delete();




  }

}
