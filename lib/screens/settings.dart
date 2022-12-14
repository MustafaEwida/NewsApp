import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:local_auth/local_auth.dart';
import 'package:newsapp/helper/auth.dart';
import 'package:newsapp/helper/helper.dart';
import 'package:newsapp/providers/Main_provider.dart';
import 'package:newsapp/providers/themeprovider.dart';
import 'package:newsapp/screens/internet.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:theme_provider/theme_provider.dart';

import '../helper/nav.dart';
import '../widgets/settings_item.dart';
import '../widgets/sttengs_groub.dart';

class Settings_screen extends StatefulWidget {
  @override
  _Settings_screenState createState() => _Settings_screenState();
}

class _Settings_screenState extends State<Settings_screen> {
  bool dark = false;
  bool? can;
  bool hasprint = false;

  checkcan() async {
    can = await LocalAuthentication().canCheckBiometrics;
  }

      @override
  void initState() {
Provider.of<Main_provider>(context,listen: false).checkinternet();


   /* checkcan().then((value) {
      print('sssss$value');
      can=value;});
    print(can);

    */
   
    super.initState();
  }
  show() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text("Confirmation").tr(),
            content: Text("you sure you want to delete account").tr(),
            actions: [
              ElevatedButton(
                  onPressed: () {
                  Provider.of<Auth_provider>(context,listen: false).deletacount();
                    Nav.NavigatorKey.currentState!
                        .pushReplacementNamed('splach');
                  },
                  child: Text("Ok").tr()),
              TextButton(
                  onPressed: () {
                    Nav.NavigatorKey.currentState!.pop();
                  },
                  child: Text("Cancel").tr())
            ],
          );
        });
  }

  Future<bool> getdark() async {
    final p = await SharedPreferences.getInstance();
    return p.getBool('dark') == null ? false : p.getBool('dark')!;
  }

  @override
  Widget build(BuildContext context) {
     Provider.of<Main_provider>(context);
    /*getdark().then((value){
    print(value);
    dark=value;
    print(dark);
   } 
   
   );*/

    return FutureBuilder(
      future: getdark(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        dark = snapshot.data;
        print(dark);
        return Scaffold(
          appBar: AppBar(
            title: Text("Settings"),
          ),
          body: Provider.of<Main_provider>(context).hasinternet==false?internet() :Padding(
            padding: EdgeInsets.all(20.sp),
            child: ListView(
              children: [
                SettingsGroup(
                  settingsGroupTitle:
                      EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Common"
                          : '?????????????????? ????????????',
                  items: [
                    SettingsItem(
                        onTap: () {},
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.arrow_forward_ios_sharp),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                  onTap: () {
                                    EasyLocalization.of(context)!
                                        .setLocale(Locale('ar', ''));
                                  },
                                  child: Text('??????????????')),
                              PopupMenuItem(
                                  onTap: () {
                                    EasyLocalization.of(context)!
                                        .setLocale(Locale('en', ''));
                                  },
                                  child: Text('English')),
                            ];
                          },
                        ),
                        icons: Icons.language,
                        title: EasyLocalization.of(context)!.currentLocale ==
                                Locale('en', '')
                            ? "Language"
                            : "?????? ??????????????",
                        subtitle: EasyLocalization.of(context)!.currentLocale ==
                                Locale('en', '')
                            ? 'English'
                            : "??????????????"),
                    SettingsItem(
                      onTap: () {},
                      icons: Icons.dark_mode,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? 'Dark mode'
                          : "?????????? ????????????",
                      subtitle: dark
                          ? EasyLocalization.of(context)!.currentLocale ==
                                  Locale('en', '')
                              ? "Active"
                              : "????????"
                          : EasyLocalization.of(context)!.currentLocale ==
                                  Locale('en', '')
                              ? "off"
                              : "????????",
                      trailing:Consumer<Theme_Provider>(builder: ((context, provider, child) {
                        return  Switch(
                        activeColor: Theme.of(context).primaryColor,
                        value:  provider.dark,
                        onChanged: (bool value) async {  
                          Nav.NavigatorKey.currentState!
                              .pushReplacementNamed('nav');                       
                          provider.changeDark(value) ;
                         /* if (dark == true) {
                            ThemeProvider.controllerOf(context)
                                .setTheme('default_dark_theme');
                          }*//* else {
                            ThemeProvider.controllerOf(context)
                                .setTheme('custem');
                          }*/
                          print(dark);

                          final p = await SharedPreferences.getInstance();
                          p.setBool('dark',  provider.dark);
                        },
                      );
                      })),
                    )
                  ],
                ),
                SettingsGroup(
                  settingsGroupTitle:
                      EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Privecy"
                          : "??????????????",
                  items: [
                    /*  SettingsItem(
              onTap: () async{
            can = await  LocalAuthentication().canCheckBiometrics;
            print('xxxxx$can');
             if(can!){
            hasprint = true;
        final x=    await SharedPreferences.getInstance();
        x.setBool('print', hasprint);
        print(x.getBool('print'));
             }else{
showDialog(context: context, builder: (ctx){
 return AlertDialog(
 title: Text("Error"),
 content: Text("Your device does not support fingerprint"),
actions: [
 
 TextButton(onPressed: (){
  Nav.NavigatorKey.currentState!.pop();
 
 }, child: Text("Ok"))


],

  );

});
             }

              },
             /* trailing: Switch.adaptive(
                
                value: true, onChanged:(v){}),*/
              icons: Icons.fingerprint,
              title: "Finger Print",
             
            ),*/
                    SettingsItem(
                      onTap: () {
                        Nav.NavigatorKey.currentState!.pushNamed('apppass');
                      },
                      icons: Icons.lock,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "PIN code"
                          : "?????????? ??????????",
                    ),
                  ],
                ),
                SettingsGroup(
                  settingsGroupTitle:
                      EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Account"
                          : "?????????????? ????????????",
                  items: [
                    SettingsItem(
                      onTap: () {
                        Nav.NavigatorKey.currentState!.pushNamed('edit');
                      },
                      icons: Icons.edit,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Edit Profile"
                          : "?????????? ?????????? ????????????",
                    ),
                    SettingsItem(
                      onTap: () {
                        Nav.NavigatorKey.currentState!.pushNamed('reset');
                      },
                      icons: Icons.password,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Reset Password"
                          : "?????????? ?????????? ???????? ????????",
                    ),
                    SettingsItem(
                      onTap: () {
                        show();
                      },
                      icons: Icons.delete,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Delete Account"
                          : "?????? ????????????",
                    )
                  ],
                ),
                SettingsGroup(
                  settingsGroupTitle:
                      EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Support"
                          : "??????????",
                  items: [
                    SettingsItem(
                      onTap: () {
                        Nav.NavigatorKey.currentState!.pushNamed('contect');
                      },
                      icons: Icons.contact_phone_rounded,
                      title: EasyLocalization.of(context)!.currentLocale ==
                              Locale('en', '')
                          ? "Contact us"
                          : "?????????? ????????",
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
