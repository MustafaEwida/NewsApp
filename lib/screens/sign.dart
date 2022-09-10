import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/helper/nav.dart';


import '../widgets/Signform.dart';
class Sign extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
        final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
 
 body:  Stack(
        children: <Widget>[
           Positioned(
            top: 50.h,
            right: 0.1.sw,
            left:  0.1.sw,
             child: Container(
                          margin: EdgeInsets.only(bottom: 5.h,top: 40.h),
                          padding:
                              EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 20.0.w),

                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
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
                            "cna",
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: 30.sp,
                              fontFamily: 'Anton',
                              fontWeight: FontWeight.normal,
                            ),
                          ).tr(),
                        ),
           ),
               Positioned(
    top: 210.h,
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
            Icons.person_add_sharp,color: Colors.white,),),
       ),
    ) , Container(
      padding: EdgeInsets.only(
        top: 0.4.sh
      ),
      child: SingleChildScrollView(child: Signform()))
          
        ],
      ),

    );
    







    
  }
}