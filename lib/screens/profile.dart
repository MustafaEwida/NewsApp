import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:provider/provider.dart';

class profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<Auth_provider>(context).userMdoel;
    return Scaffold(
        appBar: AppBar(
          title: Text("pa").tr(),
        ),
        body: Column(children: [
          Container(
            width: double.infinity,
            height: 1.sh / 3.3.h,
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
                    right: constraints.maxWidth / 2 - 50,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user!.imgurl!),
                      radius: 55.r,
                      
                    ),
                  ),
                ]);
              },
            ),
          ),
          Expanded(
              child: Padding(
                padding:  EdgeInsets.all(20.sp),
                child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
                TextFormField(
                  readOnly: true,
                    initialValue: user!.name,
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.perm_identity_rounded),
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
                        label: Text("name").tr())),
                       
                           TextFormField(
                  readOnly: true,
                    initialValue: user.email,
                    decoration: InputDecoration(
                       suffixIcon: Icon(Icons.email),
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
                        label: Text("E").tr()))
                        ,   TextFormField(
                  readOnly: true,
                    initialValue: EasyLocalization.of(context)!.currentLocale==Locale('en','')? 
                    user.gender:user.gender=='male'?'ذكر':'انثى',
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.person),
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
                        label: Text("gender").tr()))
                          , TextFormField(
                            
                  readOnly: true,
                    initialValue: DateFormat.yMMMd().format(user.birth!),
                    decoration: InputDecoration(
                      
                      suffixIcon: Icon(Icons.date_range),
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
                        label: Text("bd").tr())),

 

            ],
          )),
              ))
        ]));
  }
}