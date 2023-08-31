import 'package:flutter/material.dart';

import '../data/hubungan_model.dart';

class FormSurvey4Provider with ChangeNotifier {
  final List<HubunganModel> _listHubunganModel = [];

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
}
