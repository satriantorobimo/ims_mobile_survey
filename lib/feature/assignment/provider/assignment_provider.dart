import 'package:flutter/material.dart';

class AssignmentProvider with ChangeNotifier {
  int _length = 3;
  int _index = 0;

  int get length => _length;
  int get index => _index;

  void setLength(int value) {
    _length = value;
    notifyListeners();
  }

  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }
}
