import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/verfiy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'lock.dart';
import 'loginscreen.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
Widget page =MyLogin();
Future<void>  GetPage()async{
   
      final sh = await SharedPreferences.getInstance();
       final  pass =  sh.getString('apppass');
  if(FirebaseAuth.instance.currentUser==null){
   /* Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  MyLogin(),
),);*/
page = MyLogin();
    // Navigator.of(context).pushReplacementNamed('log');
     
     
  }else if(FirebaseAuth.instance.currentUser!=null&& pass!=''){
    page = lock();
   /*  Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  lock(),
),)*/
    // Nav.NavigatorKey.currentState!.pushReplacement(MaterialPageRoute(builder: ((context) =>  lock())));
  }/*else if(x!=null){
     Nav.NavigatorKey.currentState!.pushReplacementNamed('finger')   ;

  }*/
  
  
  
  else{
     page = verify();
    /* Navigator.of(context).pushReplacement(MaterialPageRoute(
  builder: (_) =>  verify(),
),);*/
 //Navigator.of(context).pushReplacementNamed('nav');

  }
   
  print(page);
}
  @override
  void initState() {
   GetPage().then((value) {
setState(() {
  
});
   });
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
   
    return page;
  }
}