
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:newsapp/models/news_model.dart';
import 'package:newsapp/widgets/newswidget.dart';
import 'package:provider/provider.dart';

import '../providers/Main_provider.dart';

class Fav_screen extends StatefulWidget {
  @override
  State<Fav_screen> createState() => _Fav_screenState();
}

class _Fav_screenState extends State<Fav_screen> {
  bool isinit = true;
@override
  void initState() {
 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return /*StreamProvider<List<News_model>>.value(value: Provider.of<Main_provider>(context).yournews,
    initialData: [],
    builder:((context, child) {
    final favo =  Provider.of<List<News_model>>(context).where((element) => element.isfavo==true).toList();
      return ListView.builder(
  itemCount:  favo.length,
  itemBuilder: ((context, index) {
    
    return News_Widget(favo[index]);
  }));
    }) ,
    
     );*/
    // FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(uid)
    
    /*StreamBuilder(
        stream: FirebaseFirestore.instance.collection("favo").doc("favoraite").collection(FirebaseAuth.instance.currentUser!.uid)
            .where("isfavo",isEqualTo: true) .snapshots()

           ,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
         



         if(snapshot.connectionState==ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
         }else if(!snapshot.hasData){
           return Center(child: Text("No favoraite Yet"),);
         }
         else if(snapshot.hasData){

           return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, i) {
              final news_model = News_model(
                  dateTime: DateTime.parse(snapshot.data!.docs[i]['datetime']),
                  id: snapshot.data!.docs[i].id,
                  isfavo:snapshot.data!.docs[i]['isfavo'],
                  title: snapshot.data!.docs[i]['title'],
                  desc: snapshot.data!.docs[i]['desc'],
                  imgurl: snapshot.data!.docs[i]['imgurl']);

              return 
              
              
              News_Widget(news_model);
            },
          );
         }else{
           return Text("data");
         }
         
        });*/

Consumer<Main_provider>(builder: ((context, value, child) {
  print(value.favoraite);
  return ListView.builder(
  itemCount: value.favoraite.length,
  itemBuilder: ((context, index) {
    return News_Widget(value.favoraite[index]);
  }));
}));
  }
}
