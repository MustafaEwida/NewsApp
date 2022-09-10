
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class State_Provider extends ChangeNotifier {
bool isload = false;


changeIsLoad(){
  isload = !isload;
  notifyListeners();
}
File  changeImg(File? b,XFile img){
   b = File(img.path);
   notifyListeners();
   return b;

  
}
DateTime?  changeDate(DateTime? birth , DateTime? choosen){
 birth = choosen;
  notifyListeners();
  return birth;
}

  
}