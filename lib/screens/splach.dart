

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/screens/Home.dart';
import 'package:newsapp/screens/lock.dart';
import 'package:newsapp/screens/loginscreen.dart';
import 'package:newsapp/screens/nav_screen.dart';
import 'package:newsapp/screens/verfiy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import '../nav.dart';

class Splach extends StatefulWidget {
 
  @override
  State<Splach> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Splach> {
 

  @override
  Widget build(BuildContext context) {
  
     Future.delayed(Duration(seconds: 3)).then((value)async{
       Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  Home(),
),);
    /*  final sh = await SharedPreferences.getInstance();
       final  pass =  sh.getString('apppass');
       final x = sh.getBool('print');
  if(FirebaseAuth.instance.currentUser==null){
    Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  MyLogin(),
),);
    // Navigator.of(context).pushReplacementNamed('log');
     
     
  }else if(FirebaseAuth.instance.currentUser!=null&& pass!=''){
     Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  lock(),
),);
    // Nav.NavigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: ((context) =>  lock())));
  }/*else if(x!=null){
     Nav.NavigatorKey.currentState!.pushReplacementNamed('finger')   ;

  }*/
  
  
  
  else{
     Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  verify(),
),);
 //Navigator.of(context).pushReplacementNamed('nav');

  }*/
   
  } );
    return Scaffold(
   body: Stack(
    children: [
 Container(
      width: 1.sw,
      height:1.sh ,
     child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/preview.png',fit: BoxFit.cover,),
      Text('Posts App',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold ,color: Theme.of(context).primaryColor,))
    ],


     ),
   
   
   /*
   392.72727272727275
I/flutter (12874): 803.6363636363636*/ 
     ),

     Positioned(
      top:1.sh-70.h ,
      right: 1.sw/2,
      
      child:CircularProgressIndicator() )

    ],
    
   ),



    );
  }
}