import 'package:flutter/material.dart';

class Form2Provider with ChangeNotifier {
  int _idAlamat = -1;
  int _idStatus = -1;
  int _idLamaTinggal = -1;
  int _idStatusPernikahan = -1;
  int _idUnit = -1;
  int _idSurveyUlang = -1;
  String? _selectLokasi;
  List<String>? _lokasi;

  int get idAlamat => _idAlamat;
  int get idStatus => _idStatus;
  int get idLamaTinggal => _idLamaTinggal;
  int get idStatusPernikahan => _idStatusPernikahan;
  int get idUnit => _idUnit;
  int get idSurveyUlang => _idSurveyUlang;
  String? get selectLokasi => _selectLokasi;
  List<String> get lokasi => _lokasi!;

  void setLokasi(List<String> value) {
    _lokasi = value;
    notifyListeners();
  }

  void setSelectLokasi(String value) {
    _selectLokasi = value;
    notifyListeners();
  }

  void setIdSurveyUlang(int value) {
    _idSurveyUlang = value;
    notifyListeners();
  }

  void setIdStatusPernikahan(int value) {
    _idStatusPernikahan = value;
    notifyListeners();
  }

  void setIdUnit(int value) {
    _idUnit = value;
    notifyListeners();
  }

  void setIdLamaTinggal(int value) {
    _idLamaTinggal = value;
    notifyListeners();
  }

  void setIdAlamat(int value) {
    _idAlamat = value;
    notifyListeners();
  }

  void setIdStatus(int value) {
    _idStatus = value;
    notifyListeners();
  }
}
