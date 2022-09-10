import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/nav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App_Pass extends StatefulWidget {
  

  @override
  _App_PassState createState() => _App_PassState();
}

class _App_PassState extends State<App_Pass> {
  TextEditingController tec = TextEditingController();
  validate(String pass){
    if(pass.isEmpty) {
      showDialog(context: context, builder: (ctx){
       return AlertDialog(title: Text("Something Went wrong").tr(),
       content: Text("Password cannat be empty").tr(),
       actions: [ElevatedButton(onPressed: (() {
         Navigator.of(ctx).pop();
       }), child: Text("Ok").tr())],
       );
      });
  } if(pass.length!=4) {
      showDialog(context: context, builder: (ctx){
       return AlertDialog(title:  Text("Something Went wrong").tr(),
       content: Text("Password must be 4 numbers").tr(),
       actions: [ElevatedButton(onPressed: (() {
         Navigator.of(ctx).pop();
       }), child: Text("Ok").tr())],
       );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PIN code").tr(),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
      
      children: [
     Text(
          style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
          
          
          "Enter PIN code").tr(),
          SizedBox(height: 10.h,)


        ,Padding(
          padding:  EdgeInsets.all(20.sp),
          child: TextField(
            keyboardType: TextInputType.number,
            controller: tec,
            decoration: InputDecoration(
                labelText: EasyLocalization.of(context)!.currentLocale==Locale('en','')?"Enter Password":"ادخل الرمز",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.w
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0.r),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 1.0.w,
                    ),
                  ),
            ),
          ),
        ),
       ElevatedButton(
        style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
        onPressed: (() async{
        
          validate(tec.text);
          final uid = FirebaseAuth.instance.currentUser!.uid;
             final sh=  await SharedPreferences.getInstance();
         sh.setString("apppass", tec.text);
          Nav.NavigatorKey.currentState!.pop();
       /*  await FirebaseFirestore.instance.collection('use').doc(uid).update({
           'apppass':  tec.text
          }
          );*/

        }),child: Text("Conform password").tr()),
        SizedBox(height: 15.h,),
       
        ElevatedButton(
          style:  ElevatedButton.styleFrom(
  
  shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
          onPrimary: Colors.white ,
               padding: EdgeInsets.all(20.sp),
               minimumSize: Size(0, 0),
               elevation: 8,),
          
          onPressed: (() async{
          
      /*    await FirebaseFirestore.instance.collection('use').doc(FirebaseAuth.instance.currentUser!.uid).update({
               'apppass': null
           });*/
         final sh=  await SharedPreferences.getInstance();
        if(sh.getString("apppass")==''){
 return showDialog(context: context, builder: (ctx){
       return AlertDialog(title: Text("Something Went wrong").tr(),
       content: Text("You have not set password").tr(),
       actions: [ElevatedButton(onPressed: (() {
         Navigator.of(ctx).pop();
       }), child: Text("Ok").tr())],
       );
      });
  
        }else{
             sh.setString("apppass", '');
         Nav.NavigatorKey.currentState!.pop();
        }
      
        }),child: Text("Delete Password").tr())
      ],
      
    ),
    );
  }
}
   