import 'dart:async';

import 'dart:isolate';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/nav.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/screens/fav_screen.dart';
import 'package:newsapp/screens/internet.dart';
import 'package:newsapp/screens/overview.dart';
import 'package:newsapp/widgets/main_theme.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';
import '../widgets/main_drewer.dart';
import 'Your_screen.dart';

class Nav_Screen extends StatefulWidget {
 

  @override
  State<Nav_Screen> createState() => _Nav_ScreenState();
}

class _Nav_ScreenState extends State<Nav_Screen> {
  bool?  hasinternet;
  @override
  void didChangeDependencies() {
 
  }
  @override
  void initState() {
  Provider.of<Main_provider>(context,listen: false).getdocs();
 
    FirebaseMessaging.onMessage.listen((event) {
       print(event.notification!.body);
        print(event.notification!.title);

    });
    
Provider.of<Auth_provider>(context,listen: false).curruntuser();
    super.initState();
  }
  int curruntindex = 0;
  Map<int,dynamic> screens ={
     0: ["News" ,OverView_screen()],
    1:  [ "Favoraites", Fav_screen(),],
     2  :["My Posts" , Yours_Screen(),]
  };
  @override
  Widget build(BuildContext context) {
     Provider.of<Main_provider>(context);
   
    return 
    
    
    
    
    
    Scaffold(
   drawer: main_drwer(),
     appBar: AppBar(
     
      actions: [
        IconButton(onPressed: (() {
          Provider.of<Auth_provider>(context,listen: false).logOut();
        }), icon: Icon(Icons.logout))
      ],
      centerTitle: true,
     title: Text(screens[curruntindex][0],style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30.sp,
color: Provider.of<Theme_Provider>(context)  .Themedata== Main_Theme.main_theme?Colors.amber:Colors.white,
                              


     ),),
     ),
     body:   Provider.of<Main_provider>(context).hasinternet==false?internet()
      :screens[curruntindex][1],

     bottomNavigationBar: BottomNavigationBar(
      currentIndex: curruntindex,
      
      selectedIconTheme: IconThemeData(size: 30.sp) ,
      elevation:Theme.of(context).bottomNavigationBarTheme.elevation ,
      type: Theme.of(context).bottomNavigationBarTheme.type,
       selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
       unselectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.unselectedLabelStyle,
       selectedLabelStyle: Theme.of(context).bottomNavigationBarTheme.selectedLabelStyle,
       backgroundColor:Theme.of(context).bottomNavigationBarTheme.backgroundColor ,
      onTap: (value) {
      setState(() {
          curruntindex = value;
      });
      },
      
      items: [
     BottomNavigationBarItem(
      
      icon: Icon(Icons.home_outlined,),label:EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Posts':'المنشورات'),
 BottomNavigationBarItem(icon: Icon(Icons.favorite_border,),label:EasyLocalization.of(context)!.currentLocale==Locale('en','')?'favorite':'المفضله'),
 BottomNavigationBarItem(icon: Icon(Icons.person_outline_outlined,),label:EasyLocalization.of(context)!.currentLocale==Locale('en','')?'Your posts':'منشوراتي'),
     ]),




    );
    
  }
}