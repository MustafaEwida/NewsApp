import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/helper/nav.dart';
import 'package:newsapp/screens/nav_screen.dart';

class verify extends StatefulWidget {
  

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  Timer? timer;
  bool ver = false;
  bool again = false;
  @override
  void initState() {
   ver=FirebaseAuth.instance.currentUser!.emailVerified;
   if(!ver){
      sendver();
   timer =  Timer.periodic(Duration(seconds: 3), (timer) {
         check();
       });
    }
    super.initState();
    
  }
  check(){
    FirebaseAuth.instance.currentUser!.reload();
    setState(() {
       ver=FirebaseAuth.instance.currentUser!.emailVerified;
    });
   if (ver) timer!.cancel();
  }
  sendver()async{
  final user = FirebaseAuth.instance.currentUser;
  await user!.sendEmailVerification();
     
    
  }
  @override
  Widget build(BuildContext context) {
    return ver? Nav_Screen() :Scaffold(
    appBar: AppBar(),
    body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
    Text("verify  email").tr(),
     
   SizedBox(
     width: 200.w,
    child: ElevatedButton(
      style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
      
      onPressed: again?null:(){sendver();} ,child: Text("send again").tr(),)),
     SizedBox(
       width: 200.w,
       child: ElevatedButton(
          style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
        
        onPressed: again?null:(){
          
          FirebaseAuth.instance.signOut();} ,child: Text("Cancel").tr(),),
     )
    ],),),
            

    );
    
  }
}