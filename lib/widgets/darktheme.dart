import 'package:flutter/material.dart';

class Dark_Theme {
  static ThemeData main_theme= ThemeData(
appBarTheme: AppBarTheme(backgroundColor:Colors.grey),
              accentColor: Colors.blueGrey,
              primaryColor: Colors.blueGrey,
              primaryColorDark: Colors.blueGrey,
              switchTheme: SwitchThemeData(
                thumbColor: MaterialStateProperty.all<Color>(Colors.white),
                trackColor:
                    MaterialStateProperty.all<Color>(Colors.black12),
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  onPrimary: Colors.white,
                  primary: Colors.blueGrey,
                ),
              ),
              outlinedButtonTheme: OutlinedButtonThemeData(
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                ),
              ),
              textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                primary: Colors.white,
              )),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Colors.blueGrey,
              ));
       






  
  
}