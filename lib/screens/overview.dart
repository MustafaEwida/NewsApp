import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/news_model.dart';
import '../providers/Main_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './add.dart';
import '../widgets/newswidget.dart';
import 'package:provider/provider.dart';

class OverView_screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
      future:   Provider.of<Main_provider>(context,listen: false).getdocs(),
     
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        return StreamProvider<List<News_model>>.value(
      value:Provider.of<Main_provider>(context,listen: false).allNews ,initialData: [],
  
    builder:((context, child) {
      Provider.of<Main_provider>(context,listen: false).news = Provider.of<List<News_model>>(context);
    // Provider.of<Main_provider>(context,listen: false).fillfav();
      return ListView.builder(
                          itemCount: Provider.of<List<News_model>>(context).length,
                          itemBuilder: (ctx, i) {
                          
    
                                
                                
                            return News_Widget(Provider.of<List<News_model>>(context)[i]);
                          },
                        );
    }) ,); ;
      },
    );
    
    
    
    /* StreamBuilder(
      stream: FirebaseFirestore.instance.collection("news").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        return snapshot.connectionState == ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection(
                        'favo/favouserd/${FirebaseAuth.instance.currentUser!.uid}')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshots) {
                  
                  Map<String, dynamic> xXx = {};
                  snapshots.data!.docs.forEach((e) {
                    xXx[e.id] = e.get(e.id);
                  });
          
              return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (ctx, i) {
                            final news_model = News_model(
                                dateTime: DateTime.parse(
                                    snapshot.data!.docs[i]['datetime']),
                                id: snapshot.data!.docs[i].id,
                                isfavo: xXx[snapshot.data!.docs[i].id] == null
                                    ? false
                                    : xXx[snapshot.data!.docs[i].id],
                                title: snapshot.data!.docs[i]['title'],
                                desc: snapshot.data!.docs[i]['desc'],
                                imgurl: snapshot.data!.docs[i]['imgurl']);
                            Provider.of<Main_provider>(context, listen: false)
                                .news
                                .add(news_model);
                                
                                
                            return News_Widget(news_model);
                          },
                        );
                },
              );
      },
    );*/
  }
}
