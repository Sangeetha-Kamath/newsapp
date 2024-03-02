import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier{
  int _selectedIndex = 0;

   int get  selectedIndex{
    return _selectedIndex;
  }
  set selectedIndex(int val){
    _selectedIndex = val;
    notifyListeners();
  }
}