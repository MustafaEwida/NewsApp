import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../providers/Main_provider.dart';

class internet  extends StatelessWidget {
 

  @override
  Widget build(BuildContext context) {
    return Center(
            child:Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/dis.png'),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h),
                  
                  child:
                 Text("No Internet").tr()),
               
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
            Provider.of<Main_provider>(context,listen: false).checkinternet();
          }, child: Text("Check Again",style: TextStyle(fontSize: 20.sp),).tr()),)


              ],
            ) ,
          ) ;
  }
}