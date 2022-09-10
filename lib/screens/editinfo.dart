import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/models/User.dart';
import 'package:provider/provider.dart';

import '../providers/StateProvider.dart';
import '../widgets/Signform.dart';

class Edit_Info extends StatefulWidget {
  

  @override
  _Edit_InfoState createState() => _Edit_InfoState();
}

class _Edit_InfoState extends State<Edit_Info> {
 UserMdoel? user;
  @override
  void initState() {
     user =Provider.of<Auth_provider>(context,listen: false).userMdoel;
     print(user);
    super.initState();
  }
 
  String?  imgurl;
  File? b ;
   GlobalKey<FormState> form = GlobalKey();
  onsave()async{
  if(form.currentState!.validate()){
   Provider.of<State_Provider>(context,listen:  false).changeIsLoad();
form.currentState!.save();
try {
  await Provider.of<Auth_provider>(context,listen: false).update(user, b, imgurl);
  
      showDialog(context: context, builder: (ctx){
return AlertDialog(

content: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Updating Done":"تم التحديث بنجاح"),
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
} catch (e) {
  showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? "update Faild":"فشل تحديث المعلومات"),
content: Text(EasyLocalization.of(context)!.currentLocale==Locale('en','')? 
"Make sure you connected to Internet\n and try later":" تأكد من الانترنت و حاول لاحفا"),
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

}
  Provider.of<State_Provider>(context,listen:  false).changeIsLoad();
 /*final imgpath  =  FirebaseStorage.instance.ref().child("imgs").child(FirebaseAuth.instance.currentUser!.uid+'.jpg');

if(b!=null){
  
  await imgpath.putFile(b!).whenComplete(() {
   
   });
 
}
  imgurl =  await  imgpath.getDownloadURL();
 await FirebaseFirestore.instance.collection('use').doc(FirebaseAuth.instance.currentUser!.uid).update({

 'email':user!.email,
 'gender':user!.gender,
 'birth': user!.birth.toString(),
 'name': user!.name,
 'img': imgurl,
    });*/


  }
    
   
     
 // Navigator.of(context).pushReplacementNamed('splach');
  }
  pickimg(){
final imgpicker =  ImagePicker();
showDialog(context: context, builder: (ctx){
   return AlertDialog(
   title: Text("Pick Image From:"),
   actions: [
    ElevatedButton.icon(onPressed: (() async{
  final img= await imgpicker.pickImage(source: ImageSource.camera,imageQuality: 99,maxWidth: 200);
  if(img!=null){
   b= Provider.of<State_Provider>(context,listen:  false).changeImg(b, img);
  }
 
  Navigator.of(ctx).pop();
 
    }), icon: Icon(Icons.camera), label:Text("Camera")),
     ElevatedButton.icon(onPressed: (() async{
     final img= await imgpicker.pickImage(source: ImageSource.gallery,imageQuality: 99,maxWidth: 200);
  if(img!=null){
  b=  Provider.of<State_Provider>(context,listen:  false).changeImg(b, img);
  }
    Navigator.of(ctx).pop();
    }), icon: Icon(Icons.image), label:Text("gallry")),
   ],



   );

});



 }

 
showdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1980),
            lastDate: DateTime.now())
        .then((value) {
        user!.birth =    Provider.of<State_Provider>(context,listen:  false).changeDate( user!.birth, value);
    });
  }
  @override
  Widget build(BuildContext context) {
   final prov=  Provider.of<Auth_provider>(context);
    return Scaffold(
 appBar: AppBar(
  title: Text("ed").tr(),
 ),
 body:  ListView(children: [
          Container(
           
            width: double.infinity,
            height: 1.sh/3.3,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Stack(children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                  ),
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight / 1.3,
                    color: Theme.of(context).primaryColor,
                  ),
                  Positioned(
                    top: constraints.maxHeight / 1.9,
                    right: constraints.maxWidth / 2 - 50.w,
                    child: Consumer<State_Provider>(builder: ((context, provider, child) {
                      return CircleAvatar(
                      backgroundImage: b!=null?FileImage(b!):NetworkImage(user!.imgurl!)as ImageProvider ,
                      radius: 55.r,
                      
                    );
                    })),
                  ),
                  Positioned(
                    
                     top: constraints.maxHeight / 1.3,
                    right: constraints.maxWidth / 2 - 70.w,
                    
                    child: IconButton(
                      
                      icon: Icon(Icons.image,color: Colors.amber,size: 40.sp,),onPressed: (){

                     pickimg();

                      },))
                ]);
              },
            ),
          ),
          Expanded(
              child: Padding(
                padding:  EdgeInsets.all(20.sp),
                child: Form(
                  key: form,
                    child: Column(
                      
            children: [
                TextFormField(
                   validator: (val){
                if(val!.isEmpty){
                  return EasyLocalization.of(context)!.currentLocale==Locale('en','')?"Enter Name" :"ادخل اسم";
                }
              return null;
               },
                onSaved: (val) {
                user!.name=val;
                },
                    initialValue: user!.name,
                    decoration: InputDecoration(
                      labelText: EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Your Name":"اسمك",
                     contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.w,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.r))),
                     )),
                       SizedBox(height: 30.h,),
                           TextFormField(
                     validator: (val) {
                  if (val!.isEmpty) {
                     return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Email":"ادخل ايميل";
                  }
                  if (!val.contains('@') || !val.contains('@')) {
                    return EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Enter Valid Email":"ايميل غير صالح";
                  }
                  return null;
                },
                onSaved: (val) {
                 user!.email=val;
                },
                    initialValue: user!.email,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.0.w,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.r))),
                       labelText: EasyLocalization.of(context)!.currentLocale==Locale('en','')? "Email":"الايميل")),
                         SizedBox(height: 30.h,)
                        ,   TextFormField(
                     validator: (val) {
                  if (val!.isEmpty) {
                    return EasyLocalization.of(context)!.currentLocale==Locale('en','')?"Enter Gender" :" ادخل جنسك";
                  }
                /*  if (val!='male' || val!='female') {
                    return "Enter Valid gender";
                  }*/
                  return null;
                },
                onSaved: (val) {
                if(EasyLocalization.of(context)!.currentLocale==Locale('en','')){
                  user!.gender=val;
                }else{
              if(val=='ذكر'){
                    user!.gender = 'male';
                
              }else if(val=='انثى'){

 user!.gender = 'female';

              }



                }
                 
                },
                    initialValue:EasyLocalization.of(context)!.currentLocale==Locale('en','')? user!.gender
                    
                    :user!.gender== 'male'?'ذكر': 'انثى',
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.r),
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: 1.0.w,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30.r))),
                        label: Text("gender").tr())),
                         SizedBox(height: 20.h,),
                        Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
        Consumer<State_Provider>(builder: ((context, provider, child) {
          return  Text(DateFormat.yMMMMd().format(user!.birth!));
        })),
                  TextButton(
                      onPressed: () async{
                     await   showdate();
                    
                      },
                      child: Text("Choose").tr())
                ],
              ),
               SizedBox(height: 70.h,)        ,

  InkWell(
    onTap: () {
      onsave();
    },
                    child: Container(
                    
                      padding: EdgeInsets.all(10.sp),
                    
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Theme.of(context).primaryColor,width: 1.h),
                          borderRadius: BorderRadius.all(Radius.circular(50.r)),
                         ),
                      child:Consumer<State_Provider>(builder: ((context, provider, child) {
                        return provider. isload? CircularProgressIndicator() :Text(
                        "Upadte Profile",
                        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 30.sp),
                      ).tr();
                      })),
                    ),
                  )

            ],
          )),
              ))
        ]));
     
       
      


    
  }
}