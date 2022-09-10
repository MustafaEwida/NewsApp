import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:newsapp/widgets/darktheme.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';


import '../models/news_model.dart';
import '../providers/themeprovider.dart';
import 'main_theme.dart';

class News_Widget extends StatefulWidget {
  News_model news_model;
  News_Widget(this.news_model);

  @override
  State<News_Widget> createState() => _News_WidgetState();
}

class _News_WidgetState extends State<News_Widget> {
  
  @override
  Widget build(BuildContext context) {
var tag = Localizations.maybeLocaleOf(context)?.toLanguageTag();
    return Consumer<Main_provider>(builder: ((context, value, child) {
     return Container(

      height: 310.h,

       decoration:  BoxDecoration(
        color: Provider.of<Theme_Provider>(context)  .Themedata== Dark_Theme.main_theme?Color.fromARGB(255, 124, 124, 124):Colors.white,
         boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15.0.r,
                          offset: Offset(0.0, 0.75)
                      )
                    ],

  borderRadius: BorderRadius.all(Radius.circular(20.r)),

  ),



        margin: EdgeInsets.symmetric(horizontal: 10.w,vertical: 10.h),
 child: Column(
  crossAxisAlignment: CrossAxisAlignment.start,
children: [
 Container(

  margin: EdgeInsets.only(bottom: 10.h),
  width: double.infinity,
  height: 200.h,
  child: ClipRRect(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),topRight: Radius.circular(20.r)),
      child: Image.network(widget.news_model.imgurl,fit: BoxFit.cover,)),
 ),
Padding(
  padding:   EdgeInsets.symmetric(horizontal: 5.w),
  child:   FittedBox(child: Text(widget.news_model.title,style: TextStyle(fontSize: 20.sp,color: Theme.of(context).primaryColor),)),
)
,
 Padding(
   padding: const EdgeInsets.symmetric(horizontal: 5),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconButton(onPressed: (){
      Provider.of<Main_provider>(context,listen: false).changefavo(widget.news_model);
   // FireStoreHelper.fireStoreHelper.changefavo(widget.news_model);
    setState(() {

    });

    }, icon: widget.news_model.isfavo? Icon(Icons.favorite,size: 35.sp,color: Colors.amber,):Icon(Icons.favorite_border_outlined,size: 35.sp,color: Colors.amber,)),
    Text(DateFormat.yMMMd(tag).format(widget.news_model.dateTime!).tr(),style: TextStyle(fontSize: 20.sp,color: Theme.of(context).primaryColor),)
   ],),
 )







],



 ),





    );
    }));
  }
}