import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../widgets/newswidget.dart';
import '../widgets/pronews.dart';

class Yours_Screen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:   FirebaseFirestore.instance.collection("favo").doc("usersposts").collection(FirebaseAuth.instance.currentUser!.uid).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {

            return snapshot.data!.docs.length ==0?Center(child: Text('Add Posts'),) :ListView.builder(
              itemCount: snapshot.data!.docs.length, itemBuilder: (BuildContext context, int index) {
              return  ProNews(
                News_model(
                    dateTime: DateTime.parse(snapshot.data!.docs[index].data()['datetime']),
                    id:snapshot.data!.docs[index].id,
                    isfavo: snapshot.data!.docs[index].data()['isfavo'],
                    title:snapshot.data!.docs[index].data()['title'],
                    desc: snapshot.data!.docs[index].data()['desc'],
                    imgurl:snapshot.data!.docs[index].data()['imgurl'])
                );

            },);

          } else if (!snapshot.hasData) {
            return Center(child: Text('Add Posts'),);
          } else {
            return Center(child: CircularProgressIndicator(),);
          }
        });
  }
}
