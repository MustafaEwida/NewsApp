import 'package:flutter/cupertino.dart';

class BottomBar_Provider extends ChangeNotifier {
int curruntIndex = 0;

changeIndex(int x){
curruntIndex = x;
notifyListeners();

}

  
}