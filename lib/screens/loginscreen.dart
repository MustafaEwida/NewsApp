import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../helper/auth.dart';
import '../helper/nav.dart';
import 'package:provider/provider.dart';

import '../models/ex.dart';
import '../providers/Main_provider.dart';
import '../providers/StateProvider.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  bool isload = false;
  GlobalKey<FormState> form = GlobalKey();
  TextEditingController e = TextEditingController();
   TextEditingController p = TextEditingController();
   List info = ['',''];


showdialog(String txt){
   showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong").tr(),
content: Text(txt),
actions:<Widget>[
              FlatButton(
                child: Text("Ok").tr(),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);
});
}


 void onSvaed() async{
    if (form.currentState!.validate()) {
      form.currentState!.save();
        Provider.of<State_Provider>(context,listen:  false).changeIsLoad();
  try {
   await Provider.of<Auth_provider>(context,listen: false).sign_in(info[0], info[1]);
   final b = await SharedPreferences.getInstance();
 final x=  b.getString('apppass')!;
 if(x.length==4){
  Nav.NavigatorKey.currentState!.pushReplacementNamed('lock');
 }else{
   Nav.NavigatorKey.currentState!.pushReplacementNamed('nav');
 }
        
   }on MyEx catch (e) {
    String txt = '';
    if(e.msg.contains("correct")){
EasyLocalization.of(context)!.currentLocale==Locale('en','')?txt=e.msg:txt="المستخدم غير موجود\nادخل ايميل صحيح";
    }else if(e.msg.contains("password")){
EasyLocalization.of(context)!.currentLocale==Locale('en','')?txt=e.msg:txt="كلمة مرور خاطئة";
    }
     showdialog(txt);
   }on SocketException catch (e){
    showdialog("No connection,Check Internt and try again".tr());
   }
   
   
   catch(e){

 showdialog("Something Wrong,Try agian later".tr());

   }
     Provider.of<State_Provider>(context,listen:  false).changeIsLoad();
     /*setState(() {
           isload =false;
         });*/

    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
      
      ),
      child: Scaffold(
       backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(children: [
          Container(
             decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
            
            margin: EdgeInsets.symmetric(horizontal: 15.w,vertical: 80.h),
            padding: EdgeInsets.only(left: 35.w,right: 80.w ,top: 20.h,bottom: 20.h),
            child:  Text(
              "log",
              style: TextStyle(
                
                fontWeight: FontWeight.bold,
                color: Colors.white, fontSize: 27.sp),
            ).tr(),
          ),
  Positioned(
    top: 270.h,
    right: (1.sw/2-45.w),
    
    child:
       Container(
         decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
         child: CircleAvatar(
          radius: 50.r,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(
            size: 60.sp,
            Icons.person,color: Colors.white,),),
       ),
    )
          ,
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  right: 35.w,
                  left: 35.w,
                  top: 0.5.sh ),
              child: Form(
                key: form,
                child: Column(children: [
                
                Container(
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                    
                    child: TextFormField(
  validator: ((value) {
     if(value!.isEmpty){
    return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Email":"ادخل ايميل";
     }if(!value.contains("@")&&!value.contains(".com")){
        return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Valid Email":"ايميل غير صالح";
     }
     return null;
  }),


                      onSaved: (newValue) {
                        info[0] = newValue;
                      },
                      
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText:EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Email' :"الايميل",
                        focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        errorBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50),
                        ),
                         enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                    child: TextFormField(
                       validator: ((value) {
      if (value!.isEmpty) {
                          return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Password":"ادخل كلمة مرور";
                        }
                        if(value.length<6){
   return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Strong password":" ادخل كلمة قويه";
                        }

                        return null;
                      }),
                          onSaved: (newValue) {
                        info[1] = newValue;
                      },
                     
                      obscureText: true,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50),
                        ),
                          focusedBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Password' :"كلمة المرور",
                        enabledBorder: OutlineInputBorder(
                             borderSide: BorderSide(color: Theme.of(context).primaryColor,width: 1.w),
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                     
                      ),
                    ),
                  ),
                   SizedBox(
                    height: 40.h,
                  ),
                 Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "s",
                        
                        style: TextStyle(
                           shadows: <Shadow>[
      Shadow(
       
        blurRadius:1.r,
        offset: Offset(0, 5),
        color: Color.fromARGB(255, 92, 92, 92),
      ),
    
    ],
                          color: Theme.of(context).primaryColor,
                          fontSize: 27.sp,
                          fontWeight: FontWeight.w700,
                        ),
                      ).tr(),
                   Consumer<State_Provider>(builder: ((context, provider, child) {
                     return  provider.isload?CircularProgressIndicator() : 
                    
                    Container(
                          decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.sp,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                      child: CircleAvatar(
                          radius: 30.r,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: IconButton(
                            color: Colors.white,
                            onPressed:(){
                              onSvaed();
                            },
                            icon: const Icon(Icons.arrow_forward),
                          ),
                        ),
                    );
                   }))
                    ],
                  ),
                 SizedBox(
                    height: 40.h,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                          Nav.NavigatorKey.currentState!.pushReplacementNamed('sign');
                          },
                          child:  Text(
                            "create",
                            style: TextStyle(
                                shadows: <Shadow>[
      Shadow(
       
        blurRadius:1.r,
        offset: Offset(0, 5),
        color: Color.fromARGB(255, 92, 92, 92),
      ),
    
    ],
                              decoration: TextDecoration.underline,
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColor,
                            ),
                          ).tr(),
                        ),
                        TextButton(
                          onPressed: () {
                            Nav.NavigatorKey.currentState!.pushNamed('reset');
                          },
                          child:  Text(
                            'fp',
                            style: TextStyle(
                                shadows: <Shadow>[
      Shadow(
       
        blurRadius:1.r,
        offset: Offset(0, 5),
        color: Color.fromARGB(255, 92, 92, 92),
      ),
    
    ],
                              decoration: TextDecoration.underline,
                              fontSize: 18.sp,
                              color: Theme.of(context).primaryColor
                            ),
                          ).tr(),
                        ),
                      ]),
                ]),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}