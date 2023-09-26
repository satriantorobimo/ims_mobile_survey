import 'package:flutter/material.dart';

class AssignmentProvider with ChangeNotifier {
  int _length = 3;
  int _index = 0;
  String _filter = '';

  int get length => _length;
  int get index => _index;
  String get filter => _filter;

  void setLength(int value) {
    _length = value;
    notifyListeners();
  }

  void setIndex(int value) {
    _index = value;
    notifyListeners();
  }

  void setFilter(String value) {
    _filter = value;
    notifyListeners();
  }
}
