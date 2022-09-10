import 'package:flutter/cupertino.dart';

class LogIn_Provider extends ChangeNotifier {
bool isload = false;


changeIsLoad(){
  isload = !isload;
  notifyListeners();
}

  
}