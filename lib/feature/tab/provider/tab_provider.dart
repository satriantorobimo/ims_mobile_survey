import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int _page = 0;

  int get page => _page;

  void setPage(int value) {
    _page = value;
    notifyListeners();
  }
}
