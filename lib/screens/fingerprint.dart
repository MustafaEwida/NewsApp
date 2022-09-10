import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:newsapp/screens/nav_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class finger extends StatefulWidget {
  
  @override
  State<finger> createState() => _fingerState();
}

class _fingerState extends State<finger> {
 bool w = false;

   bool did = true;

  bool x = false ;

  @override
  Widget build(BuildContext context) {
    
  /*Future.delayed(Duration(milliseconds: 250)).then((value) async{
 final b = await SharedPreferences.getInstance();
  x=  b.getBool('print')!;
  if(x){
   final auth =   LocalAuthentication();
   
  final w = await auth.authenticate(
    
    localizedReason: 'localizedReason',
   options: const AuthenticationOptions(
    biometricOnly: true,useErrorDialogs:
     true,stickyAuth: true,sensitiveTransaction: true)
    );
    
    /*
screenLock(
  context: context,
  correctString:  x,
 didUnlocked: (){
setState(() {
  Navigator.of(context).pop();
 Nav.NavigatorKey.currentState!.pushReplacementNamed('verify');
});
 }

);*/
  }
  });*/
 return w?Nav_Screen()  : Scaffold(
       appBar: AppBar(),
       body: ElevatedButton(onPressed: ()async{
final b = await SharedPreferences.getInstance();
  x=  b.getBool('print')!;
  if(x){
   final auth =   LocalAuthentication();
   
  final w = await auth.authenticate(
    
    localizedReason: 'localizedReason',
   options: const AuthenticationOptions(
    biometricOnly: true,useErrorDialogs:
     true,stickyAuth: true,sensitiveTransaction: true)
    );
  }}, child: Text('finger')),
    );
  }
}