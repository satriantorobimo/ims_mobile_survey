import 'package:floor/floor.dart';

@entity
class TaskList {
  @primaryKey
  final String code;

  final String date;
  final String status;
  final String? remark;
  final String? result;
  final String picCode;
  final String picName;
  final String branchName;
  final String agreementNo;
  final String clientName;
  final String mobileNo;
  final String location;
  final String latitude;
  final String longitude;
  final String type;
  final double? appraisalAmount;
  final String? reviewRemark;
  final String modDate;

  TaskList(
      {required this.code,
      required this.date,
      required this.status,
      required this.remark,
      required this.result,
      required this.picCode,
      required this.picName,
      required this.branchName,
      required this.agreementNo,
      required this.clientName,
      required this.mobileNo,
      required this.location,
      required this.latitude,
      required this.longitude,
      required this.type,
      required this.appraisalAmount,
      required this.reviewRemark,
      required this.modDate});

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
