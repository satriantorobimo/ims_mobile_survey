class HubunganModel {
  String? taskCode;
  String? name;
  String? phoneArea;
  String? phoneNumber;
  String? remark;
  double? value;

  HubunganModel(
      {this.taskCode,
      this.name,
      this.phoneArea,
      this.phoneNumber,
      this.remark,
      this.value});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_task_code'] = taskCode;
    data['p_name'] = name;
    data['p_area_phone_no'] = phoneArea;
    data['p_phone_no'] = phoneNumber;
    data['p_remark'] = remark;
    data['p_value'] = value;
    return data;
  }
}
