

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/screens/splach.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';

import '../nav.dart';
import '../providers/themeprovider.dart';
import 'darktheme.dart';

class main_drwer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return 
    
     
     
       Drawer(
      child: Column(
        children: [
          Consumer<Auth_provider>(builder: ((context, value, child) {
            return Container(
            
            alignment: Alignment.center,
            color:Provider.of<Theme_Provider>(context)  .Themedata== Dark_Theme.main_theme? Color.fromARGB(255, 100, 99, 99):Theme.of(context).primaryColor,
            width: double.infinity,
            height: 200.h,
            child:ListTile(
              leading:  CircleAvatar(


                backgroundImage: NetworkImage(Provider.of<Auth_provider>(context,listen: false).userMdoel!.imgurl!),
                radius: 34.r,
               
              ),
            title: Text(Provider.of<Auth_provider>(context,listen: false).userMdoel!.name!,style: TextStyle(color: Colors.white),),
              subtitle:FittedBox(child: Text(Provider.of<Auth_provider>(context,listen: false).userMdoel!.email!,style: TextStyle(color: Colors.white)),) ,
            ),
          );
          })),
          ListTile(leading: Icon(Icons.person_outlined),title: Text("Profile").tr(),onTap: (){
         Nav.NavigatorKey.currentState!.pushNamed('profile');
          },),
             ListTile(leading: Icon(Icons.add_box_sharp),title: Text("Add Post").tr(),onTap: (){
          
         Nav.NavigatorKey.currentState!.pushNamed('add',arguments: '');
          },),
          
          
            ListTile(leading: Icon(Icons.settings),title: Text("Settings").tr(),onTap: (){
        Nav.NavigatorKey.currentState!.pushNamed('settings');
          },),
        /*  ListTile(leading:
          ThemeProvider.controllerOf(context).currentThemeId== ('custom_theme')? Icon(Icons.dark_mode):Icon(Icons.sunny),
            title: ThemeProvider.controllerOf(context).currentThemeId== ('custom_theme')?Text("Dark Mode"):Text("Light Mode"),onTap: (){
//ThemeProvider.controllerOf(context).hasTheme("");
// Add theme
              if (ThemeProvider.controllerOf(context).currentThemeId== ('default_dark_theme')){
                ThemeProvider.controllerOf(context).setTheme('custom_theme');
              }else{
                ThemeProvider.controllerOf(context).setTheme('default_dark_theme');
              }



            },),*/
          ListTile(leading: Icon(Icons.logout),title: Text("LogOut").tr(),onTap: (){
           Provider.of<Auth_provider>(context ,listen: false).logOut();
           Nav.NavigatorKey.currentState!.pushReplacementNamed('home');
          },)













        ],






      ),




    );
      
    
    
  }
}
