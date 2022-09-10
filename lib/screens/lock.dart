

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:newsapp/nav.dart';
import 'package:newsapp/screens/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class lock extends StatefulWidget {
  
/* if(did){
      shared();
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    print(x);
   if(x.length == 4){
     screenLock(
        canCancel: false,
  context: context,
  correctString: '5766',
   didConfirmed: (matchedText) {
    Navigator.of(context).pop();
  },
     ); 
    }
  }
  did = false;*/ 
  @override
  _lockState createState() => _lockState();
}

class _lockState extends State<lock> {
  bool w = false;
   bool did = true;
  String x = '' ;

 

 
  
   


  @override
  Widget build(BuildContext context) {
 Future.delayed(Duration(milliseconds: 250)).then((value) async{
 final b = await SharedPreferences.getInstance();
  x=  b.getString('apppass')!;
  if(x.length==4){
screenLock(
  context: context,
  correctString:  x,
 didUnlocked: (){
setState(() {
  Navigator.of(context).pop();
 Nav.NavigatorKey.currentState!.pushReplacementNamed('verify');
});
 }

);
  }
  });
    return Scaffold(
      
    );
  }
}