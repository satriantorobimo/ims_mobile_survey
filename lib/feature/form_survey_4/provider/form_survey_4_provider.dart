import 'package:flutter/material.dart';

import '../data/hubungan_model.dart';

class FormSurvey4Provider with ChangeNotifier {
  List<HubunganModel> _listHubunganModel = [];

  List<HubunganModel> get listHubunganModel => _listHubunganModel;

  void setHubunganModel(HubunganModel value) {
    _listHubunganModel.add(HubunganModel(
        name: value.name,
        phoneArea: value.phoneArea,
        phoneNumber: value.phoneNumber,
        remark: value.remark,
        taskCode: value.taskCode,
        value: value.value));
    notifyListeners();
  }

  void removeHubunganModel(int i) {
    _listHubunganModel.removeAt(i);
    notifyListeners();
  }

  void clearHubungan() {
    _listHubunganModel = [];
    notifyListeners();
  }

  void updateHubunganModel(int i, HubunganModel value) {
    _listHubunganModel[i].name = value.name;
    _listHubunganModel[i].phoneArea = value.phoneArea;
    _listHubunganModel[i].phoneNumber = value.phoneNumber;
    _listHubunganModel[i].remark = value.remark;
    _listHubunganModel[i].value = value.value;
    notifyListeners();
  }
}
