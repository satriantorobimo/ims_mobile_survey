import 'package:floor/floor.dart';

@entity
class ReferenceList {
  @PrimaryKey()
  int id;

  String taskCode;
  String name;
  String phoneArea;
  String phoneNumber;
  String remark;
  double value;

  ReferenceList(
      {required this.id,
      required this.taskCode,
      required this.name,
      required this.phoneArea,
      required this.phoneNumber,
      required this.remark,
      required this.value});

  ReferenceList copyWith(
      {int? id,
      String? taskCode,
      String? name,
      String? phoneArea,
      String? phoneNumber,
      String? remark,
      double? value}) {
    return ReferenceList(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneArea: phoneArea ?? this.phoneArea,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      remark: remark ?? this.remark,
      taskCode: taskCode ?? this.taskCode,
      value: value ?? this.value,
    );
  }
}
