class PendingReference {
  int? ids;

  String taskCode;
  String name;
  String phoneArea;
  String phoneNumber;
  String remark;
  double value;

  PendingReference(
      {this.ids,
      required this.taskCode,
      required this.name,
      required this.phoneArea,
      required this.phoneNumber,
      required this.remark,
      required this.value});

  PendingReference copyWith(
      {int? ids,
      String? taskCode,
      String? name,
      String? phoneArea,
      String? phoneNumber,
      String? remark,
      double? value}) {
    return PendingReference(
      ids: ids,
      name: name ?? this.name,
      phoneArea: phoneArea ?? this.phoneArea,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      remark: remark ?? this.remark,
      taskCode: taskCode ?? this.taskCode,
      value: value ?? this.value,
    );
  }
}
