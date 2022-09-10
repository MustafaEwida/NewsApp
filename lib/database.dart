/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:provider/provider.dart';

import 'models/news_model.dart';

class Database {
  Database._();
  static Database database =  Database._(); 
   List<Map<String, dynamic>> xXx = [];
   Stream<List<News_model>> get yournews{
 return   FirebaseFirestore.instance
            .collection('favo')
            .doc("favouserd")
            .collection(FirebaseAuth.instance.currentUser!.uid)
            .snapshots().map((event) =>
           event.docs.map((e){
           
               return  News_model(
                  dateTime: DateTime.parse(e.data()['datetime']),
                  id: e.id,
                  isfavo: e.data()['isfavo'],
                  title: e.data()['title'],
                  desc: e.data()['desc'],
                  imgurl:e.data()['imgurl']);
            
           
           }

              ).toList()
            )
;

  }
  fill()async{
  FirebaseFirestore.instance
            .collection('favo')
            .doc("favouserd")
            .collection(FirebaseAuth.instance.currentUser!.uid).get();
    final favo = await FirebaseFirestore.instance
                    .collection(
                        'favo/favouserd/${FirebaseAuth.instance.currentUser!.uid}')
                    .get();
                
   final docs = favo.docs;
  xXx =  docs.map((e) {
   return {e.id:e.data()[e.id]};
   },).toList();
   print(xXx);
  }
  Stream<List<News_model>> get allNews{
/*
    FirebaseFirestore.instance.collection('').where('userId', isEqualTo: '').get();
    final favo = FirebaseFirestore.instance
                    .collection(
                        'favo/favouserd/${FirebaseAuth.instance.currentUser!.uid}')
                    .snapshots();
                  Map<String, dynamic> xXx = {};
   final docs = favo.map((event) {
   event.docs.forEach((e){
   xXx[e.id]=e.data()[e.id];
   });
   });   */
   
 return  FirebaseFirestore.instance.collection("news").snapshots()
           .map((event) =>
           event.docs.map((e){
 final newsl =  News_model( dateTime: DateTime.parse(e.data()['datetime']),
                  id: e.id,
                  isfavo:false//xXx[e.data()['id']],,
                 , title: e.data()['title'],
                  desc: e.data()['desc'],
                  imgurl:e.data()['imgurl']);
              
              
              
        return  newsl;
           
                              }
               
             
             
              ).toList()
            )
;

  }


}*/