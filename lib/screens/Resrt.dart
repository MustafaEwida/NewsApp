import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/helper/nav.dart';
import 'package:provider/provider.dart';

class Rest_screen extends StatefulWidget {
 

  @override
  _Rest_screenState createState() => _Rest_screenState();
}

class _Rest_screenState extends State<Rest_screen> {

  String? email;
@override
  void initState() {
    
     email =    Provider.of<Auth_provider>(context,listen: false).userMdoel!.email!;
     print(email);
    // TODO: implement initState
    super.initState();
  }


  TextEditingController tec = TextEditingController();
  onsubmit(String txt)async{
if(txt.isEmpty){
 return  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Reset Faild":"فشل اعادة التعيين"),
content: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Reset Faild":"ادخل الايميل"),
actions:<Widget>[
              FlatButton(
                child: Text('Ok').tr(),
                onPressed: () {
                     Navigator.of(ctx).pop();
                },
              )
            ],

);
});
}if( txt!= email ){
return showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Reset Faild":"فشل اعادة التعيين"),
content: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Reset Faild":"ادخل الايميل"),
actions:<Widget>[
              FlatButton(
                child: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Ok":" حسنا"),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);
});

}else {
 await FirebaseAuth.instance.sendPasswordResetEmail(email: txt.trim());

  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Verify Email").tr(),
content: Text('Go to your Email And Reset Password').tr(),
actions:<Widget>[
              FlatButton(
                child: Text('Ok'.tr()),
                onPressed: () {
                 FirebaseAuth.instance.signOut();
                  Nav.NavigatorKey.currentState!.pushReplacementNamed('home');
                },
              )
            ],

);
});
}


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
 appBar: AppBar(
  title: Text("Rest Your Password").tr(),
 ),
 body:  Column(
  mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
          
          
          'Enter Your Email').tr(),
          SizedBox(height: 10.h,),
        Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20.w),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
   controller: tec,
   decoration: InputDecoration(
    filled:  true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).primaryColor)
    ),
    focusedBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(50.r),
      borderSide: BorderSide(width: 1.w,color: Theme.of(context).primaryColor)
    )
   ),


          ),
        )
       , 
       SizedBox(height: 15.h,),
    SizedBox(
      width: 200.w,
      
      
      child:    ElevatedButton(
style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
          onPressed: (){
            onsubmit(tec.text);
          }, child: Text("Reset",style: TextStyle(fontSize: 20.sp),).tr()),)
      ],
      
    ),


    );
  }
}