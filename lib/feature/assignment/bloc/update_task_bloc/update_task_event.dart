import 'package:equatable/equatable.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();
}

class UpdateTaskAttempt extends UpdateTaskEvent {
  const UpdateTaskAttempt(this.code, this.type, this.remark, this.appraisal,
      this.result, this.date);

  final String code;
  final String type;
  final String remark;
  final double appraisal;
  final String result;
  final String date;

  @override
  List<Object> get props => [code, type, remark, appraisal, result];
}
