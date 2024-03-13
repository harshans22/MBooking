import 'package:flutter/material.dart';

class Movie with ChangeNotifier {
  int _cinemaindex = -1;
  int get  cinemaindex => _cinemaindex; 
  void selectcinema(int index) {
    _cinemaindex = index;
    notifyListeners();
  }
}
