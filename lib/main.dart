
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/providers/BottomBarProvider.dart';
import 'package:newsapp/providers/StateProvider.dart';

import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/screens/Apppass.dart';
import 'package:newsapp/screens/Home.dart';
import 'package:newsapp/screens/Resrt.dart';
import 'package:newsapp/screens/UserInformation.dart';
import 'package:newsapp/screens/editinfo.dart';
import 'package:newsapp/screens/fingerprint.dart';
import 'package:newsapp/screens/lock.dart';
import 'package:newsapp/screens/nav_screen.dart';
import 'package:newsapp/screens/profile.dart';
import 'package:newsapp/screens/settings.dart';
import 'package:newsapp/screens/splach.dart';
import 'package:newsapp/screens/verfiy.dart';
import 'package:theme_provider/theme_provider.dart';
import 'helper/nav.dart';
import './providers/Main_provider.dart';
import './screens/add.dart';
import './screens/loginscreen.dart';


import './screens/sign.dart';
import './widgets/main_theme.dart';
import 'package:provider/provider.dart';

import 'screens/suppurt.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      supportedLocales: [Locale('en', ''), Locale('ar', '')],
      path: 'assets/lang', // <-- change the path of the translation files
      fallbackLocale: Locale('en', 'US'),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: ((context) =>Auth_provider())),
          ChangeNotifierProvider(create: ((context) => Main_provider())),
          ChangeNotifierProvider(create: ((context) => Theme_Provider())),
          ChangeNotifierProvider(create: ((context) => State_Provider())),
          ChangeNotifierProvider(create: ((context) => BottomBar_Provider())),
        ],
        child: MyApp(),
      )));

  /* MultiProvider(providers: [
   
    
    ChangeNotifierProvider(create: ((context) => Main_provider()))
  ],
  child: MyApp(),
  
  ));*/
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    
    return ScreenUtilInit(
      
       designSize: const Size(392.72, 803.63),
        minTextAdapt: true,
      builder: ((context, child) {
     
     return 
      
      
      
         MaterialApp(

                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: context.locale,
                debugShowCheckedModeBanner: false,
                navigatorKey: Nav.NavigatorKey,
                title: 'Flutter Demo',
              theme: Provider.of<Theme_Provider>(context).Themedata,
                routes: {
                  'splach': (context) => Splach(),
                  'nav': (context) => Nav_Screen(),
                  'add': (context) => EditProductScreen(),
                  'sign': (context) => Sign(),
                  'apppass': (context) => App_Pass(),
                  'log': (context) => MyLogin(),
                  'settings': (context) => Settings_screen(),
                  'profile': (context) => profile(),
                  'edit': (context) => Edit_Info(),
                  'lock': (context) => lock(),
                  'verify': (context) => verify(),
                  'contect':(context) => Contact_screen(),
                  'reset':(context) => Rest_screen(),
                  'finger':(context) => finger(),
                  'userInfo':(context) => UserInformation(),
                  "home":(context) => Home()
                },
                home: StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return snapshot.hasError ? Splach() : Splach();

                    // snapshot.hasData?verify():MyLogin();
                  },
                  //  ),
                )); 
       


    } 
       
    
    //  ),
    ));
  }
}
