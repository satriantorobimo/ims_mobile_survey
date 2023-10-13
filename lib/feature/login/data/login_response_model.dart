class LoginResponseModel {
  int? status;
  String? token;
  String? message;
  List<Datalist>? datalist;

  LoginResponseModel({this.status, this.token, this.message, this.datalist});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    token = json['token'];
    message = json['message'];
    if (json['datalist'] != null) {
      datalist = <Datalist>[];
      json['datalist'].forEach((v) {
        datalist!.add(Datalist.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['token'] = token;
    data['message'] = message;
    if (datalist != null) {
      data['datalist'] = datalist!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datalist {
  String? ucode;
  String? name;
  String? systemDate;
  String? branchCode;
  String? branchName;
  String? idpp;
  String? companyCode;
  String? companyName;
  String? deviceId;

  Datalist(
      {this.ucode,
      this.name,
      this.systemDate,
      this.branchCode,
      this.branchName,
      this.idpp,
      this.companyCode,
      this.companyName,
      this.deviceId});

  Datalist.fromJson(Map<String, dynamic> json) {
    ucode = json['ucode'];
    name = json['name'];
    systemDate = json['system_date'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    idpp = json['idpp'];
    companyCode = json['company_code'];
    companyName = json['company_name'];
    deviceId = json['device_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ucode'] = ucode;
    data['name'] = name;
    data['system_date'] = systemDate;
    data['branch_code'] = branchCode;
    data['branch_name'] = branchName;
    data['idpp'] = idpp;
    data['company_code'] = companyCode;
    data['company_name'] = companyName;
    data['device_id'] = deviceId;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'ucode': ucode,
      'name': name,
      'system_date': systemDate,
      'branch_code': branchCode,
      'branch_name': branchName,
      'idpp': idpp,
      'company_code': companyCode,
      'company_name': companyName,
      'device_id': deviceId
    };
  }

  factory Datalist.fromMap(Map<String, dynamic> map) {
    return Datalist(
        ucode: map['ucode'],
        name: map['name'],
        systemDate: map['system_date'],
        branchCode: map['branch_code'],
        branchName: map['branch_name'],
        idpp: map['idpp'],
        companyCode: map['company_code'],
        companyName: map['company_name'],
        deviceId: map['device_id']);
  }
}
