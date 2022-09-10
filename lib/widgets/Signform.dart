


import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/nav.dart';
import '../helper/auth.dart';
import '../helper/helper.dart';
import '../models/User.dart';
import '../models/ex.dart';
import '../providers/Main_provider.dart';
import 'package:provider/provider.dart';

import '../providers/logInProvider.dart';

class Signform extends StatefulWidget {
  @override
  State<Signform> createState() => _SignformState();
}

class _SignformState extends State<Signform> {
  File? b ;

 GlobalKey<FormState> form = GlobalKey();
 TextEditingController passcontrol = TextEditingController();
  UserMdoel user = UserMdoel(
   
      password: null,
      birth: null,
      email: null,
      gender: null,
      id: null,
      name: null,
    );
 pickimg(){
final imgpicker =  ImagePicker();
showDialog(context: context, builder: (ctx){
   return AlertDialog(
   title: Text("Pick Image From:").tr(),
   actions: [
    ElevatedButton.icon(onPressed: (() async{
  final img= await imgpicker.pickImage(source: ImageSource.camera,imageQuality: 99,maxWidth: 200);
setState(() {
    b = File(img!.path);
});
  Navigator.of(ctx).pop();
 
    }), icon: Icon(Icons.camera), label:Text("Camera").tr()),
     ElevatedButton.icon(onPressed: (() async{
     final img= await imgpicker.pickImage(source: ImageSource.gallery,imageQuality: 99,maxWidth: 200);
  setState(() {
      b = File(img!.path);
  });
     Navigator.of(ctx).pop();
    }), icon: Icon(Icons.image), label:Text("gallry").tr()),
   ],



   );

});



 }
  void onSvaed() async{
  /*  if(b==null){
 Scaffold.of(context).showSnackBar(SnackBar(content: Text("pleace pick image")));

return;
    }*/
    if (form.currentState!.validate()) {
      form.currentState!.save();

      Provider.of<LogIn_Provider>(context,listen:  false).changeIsLoad();

  try {

    //  await Provider.of<Auth_provider>(context,listen: false).sign_up(user,b!);
    await Provider.of<Auth_provider>(context,listen: false).sign_up(user);
    Nav.NavigatorKey.currentState!.pushReplacementNamed("userInfo",arguments: user);
        
   }on MyEx catch (e) {
     String txt = '';
    if(e.msg.contains("exists")){
EasyLocalization.of(context)!.currentLocale==Locale('en','')?txt=e.msg:txt="الايميل موجود مسبقا\n حاول بإيميل أخر";
    }
     showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong").tr(),
content: Text("Something Wrong,Try agian later").tr(),
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
   }catch(e){
     showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Something Went wrong").tr(),
content: Text(e.toString()),
actions:<Widget>[
              FlatButton(
                child: Text("Ok").tr(),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],

);});
   }
  Provider.of<LogIn_Provider>(context,listen:  false).changeIsLoad();
   
    }
 
   
  }

  showdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1980),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
        user.birth = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: form,
        child: Container(
           padding: EdgeInsets.all(20.sp),
          width: double.infinity - 70.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.r),
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1.r,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ]
                   ),
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.w,
                        ),
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1.w,color:Theme.of(context).primaryColor ),borderRadius: BorderRadius.circular(50.r)),
                      label: Text("EE").tr()),
                  keyboardType: TextInputType.text,
                  
                  textInputAction: TextInputAction.next,
                 validator: (val){
                  if(val!.isEmpty){
                    return EasyLocalization.of(context)!.currentLocale==Locale('en','')?"Enter Name" :"ادخل اسم";
                  }
                return null;
                 },
                  onSaved: (val) {
                  user.name=val;
                  },
                ),
              ),SizedBox(height: 10.h,),
              
               //.........................................................................................................                    
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.h),
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
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                    filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.r),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 1.w,
                        ),
                      ),
                      border: OutlineInputBorder(borderSide: BorderSide(width: 1.w,color:Theme.of(context).primaryColor ),borderRadius: BorderRadius.circular(50.r)),
                      label: Text("E").tr()),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (val) {
                    if (val!.isEmpty) {
                      return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Email":"ادخل ايميل";
                    }
                    if (!val.contains('@') || !val.contains('.com')) {
                      return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Valid Email":"ايميل غير صالح";
                    }
                    return null;
                  },
                  onSaved: (val) {
                   user.email=val;
                  },
                ),
              ),
              
              
              
                SizedBox(height: 10.h,),
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
                      controller: passcontrol,
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                    filled: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                            borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 1.w,
                            ),
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 1.w,color:Theme.of(context).primaryColor ),borderRadius: BorderRadius.circular(50.r)),
                          label: Text("P").tr()),
                      obscureText: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      textInputAction: TextInputAction.done,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Password":"ادخل كلمة مرور";
                        }
                        if(val.length<6){
   return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Strong password":" ادخل كلمة قويه";
                        }

                        return null;
                      },
                      onSaved: (val) {
                      user.password=val;
                      },
                    ),
                  ),
                
              SizedBox(height: 10.h,),
             Container(
              margin: EdgeInsets.symmetric(vertical: 10.h),
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
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                    filled: true,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.w,
                          ),
                        ),
                        border: OutlineInputBorder(borderSide: BorderSide(width: 1.w,color:Theme.of(context).primaryColor ),borderRadius: BorderRadius.circular(50.r)),
                        label: Text("cp").tr()),
                    obscureText: true,
                   onFieldSubmitted: (val){
       FocusManager.instance.primaryFocus?.unfocus();
                   },
                    textInputAction: TextInputAction.done,
                    validator: (val) {
                       //  hintText:EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Email' :"الايميل",
                      if (val!.isEmpty) {
                        return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Conform password":"اكد كلمة المرور";
                      }if(val!=passcontrol.text){
                        return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "password didnt match":"كلمة المرور لا تتطابق";
                      }

                      return null;
                    },
                  
                  ),
             ),SizedBox(height: 10.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("I already have account",style: TextStyle(fontWeight: FontWeight.w600),).tr(),
                      SizedBox(width: 10.w,),
                      TextButton(onPressed: (){
                        Nav.NavigatorKey.currentState!.pushReplacementNamed('log');
                      }, child: Text("s").tr())
                    ],
                  )  
                
     ,
          Consumer<LogIn_Provider>(builder: ((context, provider, child) {
            return   provider.isload? CircularProgressIndicator() : InkWell(
                onTap: ()async{
                onSvaed();
                  
                },

                child: Container(
                  
                  padding: EdgeInsets.all(5.sp),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                            
                    boxShadow: [
                      BoxShadow(
                           spreadRadius: 0.1,
        blurRadius: 7.r,
                        color: Color.fromARGB(255, 92, 92, 92),
                        offset: Offset(0, 10)
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(50.r)),
                  ),
                  child: Text(
                    "ca",
                    style: TextStyle(
                        color: Theme.of(context).accentColor, fontSize: 20.sp),
                  ).tr(),
                ),
              );
          }))

            ],
          ),
        ));
  }
}
