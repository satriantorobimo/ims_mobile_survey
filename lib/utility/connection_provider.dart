import 'package:flutter/material.dart';

class ConnectionProvider with ChangeNotifier {
  bool _isConnect = true;

  bool get isConnect => _isConnect;

  void setConnection(bool value) {
    _isConnect = value;
    notifyListeners();
  }
}
