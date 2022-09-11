import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../helper/auth.dart';
import '../models/User.dart';
import '../models/news_model.dart';
import '../widgets/newswidget.dart';
import '../helper/helper.dart';

class Main_provider extends ChangeNotifier {
  List<News_model> news = [];
  bool? hasinternet;
  List<News_model> favoraite = [];
List<QueryDocumentSnapshot<Map<String, dynamic>>>  x = [];
Map<String,dynamic> xx = {};
  final firestore = FirebaseFirestore.instance;
  Stream<List<News_model>> get yournews {
    return FirebaseFirestore.instance
        .collection('favo')
        .doc("favouserd")
        .collection(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((event) => event.docs.where((element) {
              return element.data()['isfavo'];
            }).map((e) {
              return News_model(
                  dateTime: DateTime.parse(e.data()['datetime']),
                  id: e.id,
                  isfavo: e.data()['isfavo'],
                  title: e.data()['title'],
                  desc: e.data()['desc'],
                  imgurl: e.data()['imgurl']);
            }).toList());

    ;
  }
getdocs()async{
 final fav= await FirebaseFirestore.instance
                    .collection(
                        '/favo/favoraite/${FirebaseAuth.instance.currentUser!.uid}')
                    .get();
                    
                    x = fav.docs;
                     
           //         print(x);
x.forEach((element) {
  xx[element.id] = element['isfavo'];
 // xx.putIfAbsent(element.id, () => element['isfavo']);
});
 //print("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//print(xx);

}
  Stream<List<News_model>> get allNews {
  
/* FirebaseFirestore.instance
                    .collection(
                        '/favo/usersposts/${FirebaseAuth.instance.currentUser!.uid}')
                    .snapshots().listen((event) { 
             

                    });*/
               /*     print(x);
                  Map<String, dynamic> xXx = {};*/
  /* final docs = favo.map((event) {
   event.docs.forEach((e){
   xXx[e.id]=e.data()[e.id];
   });
  
   }); */
  // print("pppppppppppppppppppppppppppppppppppppp");
//print(xx);
    return FirebaseFirestore.instance
        .collection("news")
        .snapshots()
        .map((event) => event.docs.map((e) {
              final newsl = News_model(
                  dateTime: DateTime.parse(e.data()['datetime']),
                  id: e.data()['id'],
                  isfavo: xx.length==0?false:!xx.containsKey(e.id)?false: xx[e.id]   //e.data()['isfavo'] //xXx[e.data()['id']],,
                  ,
                  title: e.data()['title'],
                  desc: e.data()['desc'],
                  imgurl: e.data()['imgurl']);
           
         //    news.add(newsl);
            print(news);
              print("pppppppppppppppppppppppppppppppppppppp");
                 fillfav();
              print(favoraite);
         
              notifyListeners();

              return newsl;
            }).toList());
          
  }
  /*fillnews(List<News_model> list){
    news = list;
    fillfav();
  }*/
fillfav(){
  favoraite=[];
 favoraite = news.where((element) => element.isfavo==true).toList() ;
 notifyListeners();
}
  fillfavo() async {
  /*  final ro = await FirebaseFirestore.instance
        .collection("news")
        .where('isfavo', isEqualTo: true)
        .get();
    ro.docs.forEach((e) {
      if (!favoraite.contains(News_model(
          id: e.id,
          title: e.data()['title'],
          desc: e.data()['desc'],
          imgurl: e.data()['imgurl']))) {
        final n = News_model(
            dateTime: DateTime.parse(e.data()['datetime']),
            id: e.id,
            isfavo: e.data()['isfavo'],
            title: e.data()['title'],
            desc: e.data()['desc'],
            imgurl: e.data()['imgurl']);
        favoraite.insert(0, n);
      }
    });
    print(favoraite);*/
  }

  fillfavofirestore() {
   /* User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('favo')
        .doc("favouserd")
        .collection(user!.uid)
        .doc();*/
  }

  checkinternet() {
final checker = InternetConnectionChecker.createInstance(checkInterval: Duration(seconds: 1));

    checker.onStatusChange.listen((event) {
      final has = event == InternetConnectionStatus.connected;
      print(has);
      hasinternet = has;
      print(hasinternet);

      notifyListeners();
    });
  }

  addnews(News_model news_model,File b) {
    FireStoreHelper.fireStoreHelper.addtofirestore(news_model,b);
    news.insert(0, news_model);

    notifyListeners();
  }

  
  changefavo(News_model news_model) {
    News_model x = news.firstWhere((element) => element.id == news_model.id);
    x.isfavo = !x.isfavo;
    fillfav();
    FireStoreHelper.fireStoreHelper.changefavo(x);
  }
}
