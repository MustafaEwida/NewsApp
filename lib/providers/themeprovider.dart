import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/widgets/darktheme.dart';
import 'package:newsapp/widgets/main_theme.dart';

class Theme_Provider extends ChangeNotifier {
bool dark = false;
var Themedata =Main_Theme.main_theme;

changeDark(bool? x){
dark = x!;

if(dark ){
 Themedata = ThemeData.dark();

  
}else{
 Themedata = Main_Theme.main_theme;
}
notifyListeners();
}


Changetheme(){
if(dark ){
 Themedata = ThemeData.dark();
 

  
}else{
 Themedata = Main_Theme.main_theme;
}
notifyListeners();
}

  
}