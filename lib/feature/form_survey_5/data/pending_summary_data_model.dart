import 'package:floor/floor.dart';

@entity
class PendingSummary {
  @PrimaryKey(autoGenerate: true)
  int? ids;

  String taskCode;
  String remark;
  String? notes;
  double? value;

  PendingSummary(
      {this.ids,
      required this.taskCode,
      required this.remark,
      required this.notes,
      required this.value});

  PendingSummary copyWith(
      {int? ids,
      String? taskCode,
      String? remark,
      String? notes,
      double? value}) {
    return PendingSummary(
        ids: ids,
        notes: notes ?? this.notes,
        remark: remark ?? this.remark,
        taskCode: taskCode ?? this.taskCode,
        value: value ?? this.value);
  }
}
