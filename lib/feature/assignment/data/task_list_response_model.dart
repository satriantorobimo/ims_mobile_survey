class TaskListResponseModel {
  int? result;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  TaskListResponseModel(
      {this.result,
      this.statusCode,
      this.message,
      this.data,
      this.code,
      this.id});

  TaskListResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? code;
  String? date;
  String? status;
  String? remark;
  String? result;
  String? picCode;
  String? picName;
  String? branchName;
  String? agreementNo;
  String? clientName;
  String? mobileNo;
  String? location;
  String? latitude;
  String? longitude;
  String? type;
  double? appraisalAmount;
  String? reviewRemark;
  String? modDate;

  Data(
      {this.code,
      this.date,
      this.status,
      this.remark,
      this.result,
      this.picCode,
      this.picName,
      this.branchName,
      this.agreementNo,
      this.clientName,
      this.mobileNo,
      this.location,
      this.latitude,
      this.longitude,
      this.type,
      this.appraisalAmount,
      this.reviewRemark,
      this.modDate});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    date = json['date'];
    status = json['status'];
    remark = json['remark'];
    result = json['result'];
    picCode = json['pic_code'];
    picName = json['pic_name'];
    branchName = json['branch_name'];
    agreementNo = json['agreement_no'];
    clientName = json['client_name'];
    mobileNo = json['mobile_no'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    type = json['type'];
    appraisalAmount = json['appraisal_amount'];
    reviewRemark = json['review_remark'];
    modDate = json['mod_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['date'] = date;
    data['status'] = status;
    data['remark'] = remark;
    data['result'] = result;
    data['pic_code'] = picCode;
    data['pic_name'] = picName;
    data['branch_name'] = branchName;
    data['agreement_no'] = agreementNo;
    data['client_name'] = clientName;
    data['mobile_no'] = mobileNo;
    data['location'] = location;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['type'] = type;
    data['appraisal_amount'] = appraisalAmount;
    data['review_remark'] = reviewRemark;
    data['mod_date'] = modDate;
    return data;
  }
}
