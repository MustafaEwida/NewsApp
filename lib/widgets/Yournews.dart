import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/helper/nav.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';


import '../models/news_model.dart';

class ProNews extends StatefulWidget {
  News_model news_model;
  ProNews(this.news_model);

  @override
  State<ProNews> createState() => _News_WidgetState();
}

class _News_WidgetState extends State<ProNews> {
  @override
  Widget build(BuildContext context) {
print(widget.news_model.imgurl);
    return Consumer<Main_provider>(builder: ((context, value, child) {
     return Container(

      height: 310,

       decoration:  BoxDecoration(
         color: Provider.of<Theme_Provider>(context).Themedata==ThemeData.dark()?Color.fromARGB(255, 124, 124, 124):Colors.white,
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
  padding:  EdgeInsets.symmetric(horizontal: 5.w),
  child:    FittedBox(child: Text(widget.news_model.title,style: TextStyle(fontSize: 20.sp,color: Theme.of(context).primaryColor),)),
)
,
 Padding(
   padding:  EdgeInsets.symmetric(horizontal: 5.h),
   child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    IconButton(onPressed: (){
       Provider.of<Main_provider>(context,listen: false).changefavo(widget.news_model);
    //FireStoreHelper.fireStoreHelper.changefavo(widget.news_model);
    setState(() {

    });

    }, icon: widget.news_model.isfavo? Icon(Icons.favorite,size: 35.sp,color: Colors.amber,):Icon(Icons.favorite_border_outlined,size: 35.sp,color: Colors.amber,)),
    Text(DateFormat.yMMMd().format(widget.news_model.dateTime!),style: TextStyle(fontSize: 20,color: Theme.of(context).primaryColor),),
    PopupMenuButton(
     
      icon: Icon(Icons.more_vert,color: Theme.of(context).primaryColor,),
onSelected: (value){
if(value=='edit'){
  Nav.NavigatorKey.currentState!.pushNamed("add",arguments: widget.news_model.id);
}else{
   showDialog(context: context, builder: (ctx){
return AlertDialog(
title: Text("Confirmation").tr(),
content: Text("Do you want to delete this post").tr(),
actions:<Widget>[
  TextButton( child: Text("Cancel").tr(),
                onPressed: () {
                  
                  Navigator.of(ctx).pop();
                },),
              FlatButton(
                child: Text("Ok").tr(),
                onPressed: () {
                  FireStoreHelper.fireStoreHelper.delete(widget.news_model.id!);
                  Navigator.of(ctx).pop();
                },
              )
            ],

);});
}
}

,
      itemBuilder: (context){

      return  [
   PopupMenuItem(
    value: 'edit',
    child: ListTile(title: Text("Edit"),trailing: Icon(Icons.edit),)),
  
    PopupMenuItem(
       value: 'delete',
      child: ListTile(title: Text("Delete"),trailing: Icon(Icons.delete),)),
        ];
      })
   ],),
 )







],



 ),





    );
    }));
  }
}