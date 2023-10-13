class ReferenceListResponseModel {
  int? result;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  ReferenceListResponseModel(
      {this.result,
      this.statusCode,
      this.message,
      this.data,
      this.code,
      this.id});

  ReferenceListResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    statusCode = json['StatusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['StatusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['id'] = id;
    return data;
  }
}

class Data {
  int? id;
  String? taskCode;
  String? areaPhoneNo;
  String? phoneNo;
  String? remark;
  String? name;
  double? value;

  Data(
      {this.id,
      this.taskCode,
      this.areaPhoneNo,
      this.phoneNo,
      this.remark,
      this.name,
      this.value});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskCode = json['task_code'];
    areaPhoneNo = json['area_phone_no'];
    phoneNo = json['phone_no'];
    remark = json['remark'];
    name = json['name'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_code'] = taskCode;
    data['area_phone_no'] = areaPhoneNo;
    data['phone_no'] = phoneNo;
    data['remark'] = remark;
    data['name'] = name;
    data['value'] = value;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'task_code': taskCode,
      'area_phone_no': areaPhoneNo,
      'phone_no': phoneNo,
      'remark': remark,
      'name': name,
      'value': value
    };
  }

  factory Data.fromMap(Map<String, dynamic> map) {
    return Data(
        id: map['id'],
        taskCode: map['task_code'],
        areaPhoneNo: map['area_phone_no'],
        phoneNo: map['phone_no'],
        remark: map['remark'],
        name: map['name'],
        value: map['value']);
  }
}
