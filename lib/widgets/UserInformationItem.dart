import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/models/User.dart';
import 'package:provider/provider.dart';

import '../helper/auth.dart';
import '../models/ex.dart';
import '../nav.dart';
import '../providers/logInProvider.dart';

class UserInfoItem extends StatefulWidget {
  UserMdoel user;
  UserInfoItem(this. user);


  @override
  _UserInfoItemState createState() => _UserInfoItemState();
}

class _UserInfoItemState extends State<UserInfoItem> {
   File? b ;
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
  showdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1980),
            lastDate: DateTime.now())
        .then((value) {
      setState(() {
       widget. user.birth = value;
      });
    });
  }
 void onSvaed() async{
  /*  if(b==null){
 Scaffold.of(context).showSnackBar(SnackBar(content: Text("pleace pick image")));

return;
    }*/
 if(b==null){
Scaffold.of(context).showSnackBar(SnackBar(content: Text("pleace pick image")));
return;
 }

      Provider.of<LogIn_Provider>(context,listen:  false).changeIsLoad();

  try {
    final user = Provider.of<Auth_provider>(context,listen: false).user;
  await FireStoreHelper.fireStoreHelper.adduser( user! ,widget. user , b!);
  Nav.NavigatorKey.currentState!.pushReplacementNamed("verify");
    //  await FireStoreHelper.fireStoreHelper.adduser(widget. user, userMdoel, img);
    
        
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
 
   
  

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
                          margin: EdgeInsets.only(top: 40.h),
                          padding:
                              EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 20.0.w),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.r),
                            color: Theme.of(context).primaryColor,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 8.r,
                                color: Colors.black26,
                                offset: Offset(0, 2),
                              )
                            ],
                          ),
                          child: Text(
                            "Personal Information",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 20.sp,
                           
                              fontWeight: FontWeight.normal,
                            ),
                          ).tr(),
                        )
,
SizedBox(height: 50.h,)
,
        Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
CircleAvatar(backgroundImage:b==null?null: FileImage(b!),radius: 70.r,),
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
  child:   ElevatedButton.icon(
  style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0.r),
      
    )
  )
),
    
  
     
  
    onPressed:pickimg, icon: Icon(Icons.image,color: Theme.of(context).accentColor,),
    
     label: Text("pickimg",style: TextStyle(color: Theme.of(context).accentColor),).tr()),
)





],



                )
                ,SizedBox(height: 30.h,),
                Divider( color: Theme.of(context).primaryColor)
             , Column(
               crossAxisAlignment:CrossAxisAlignment.start,
              children: [

         Padding(
           padding: EdgeInsets.all(20.sp),
           child: Text("chb" ,style: TextStyle(
            fontSize: 20.sp,
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600

//"chb"
                          )).tr(),
         ) ,    
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  widget. user.birth == null
                      ? Text(
                        style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600

//"chb"
                        ),
                        //  DateFormat.yMMMd().format(DateTime.now()
                       DateFormat.yMMMd().format(DateTime.now())).tr()
                      : Text(DateFormat.yMMMd().format( widget.user.birth!)),
                  ElevatedButton(
                    style: ButtonStyle(
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0.r),
      
    )
  )
),
                      onPressed: () {
                        showdate();
                      },
                      child: Text("choose").tr())
                ],
              ),SizedBox(height: 20.h,)
             ],),
             Divider( color: Theme.of(context).primaryColor),
             Column(
            crossAxisAlignment:CrossAxisAlignment.start,
              children: [
Padding(
  padding:  EdgeInsets.all(20.sp),
  child:   Text("Choose Your Gender",style: TextStyle(fontSize: 20.sp,color: Theme.of(context).primaryColor,fontWeight: FontWeight.bold),).tr(),
),

               Row(children: [
                Flexible(
                  flex: 1,
                  child: RadioListTile<String>(
                      title: Text("male",  style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
        fontSize: 20.sp
        


                        ),).tr(),
                      value: 'male',
                      groupValue: widget. user.gender,
                      onChanged: (value) {
                        setState(() {
                         widget.  user.gender = value;
                        });
                      }),
                ),
                Flexible(
                  flex: 1,
                  child: RadioListTile<String>(
                      title: Text("female",  style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontWeight: FontWeight.w600,
  fontSize: 20.sp

                        ),).tr(),
                      value: 'female',
                      groupValue: widget. user.gender,
                      onChanged: (value) {
                        setState(() {
                          widget. user.gender = value;
                        });
                      }),
                ),
              ])
             ]),Divider(color: Theme.of(context).primaryColor,),  
             SizedBox(height: 40.h,)
             
             ,
              Consumer<LogIn_Provider>(builder: ((context, provider, child) {
            return   provider.isload? CircularProgressIndicator() :  InkWell(
                onTap: ()async{
                onSvaed();
                  
                },

                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
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
              );}))
      ],
      
    );
  }
}