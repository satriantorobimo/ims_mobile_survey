import 'package:equatable/equatable.dart';

abstract class UpdateTaskEvent extends Equatable {
  const UpdateTaskEvent();
}

class UpdateTaskAttempt extends UpdateTaskEvent {
  const UpdateTaskAttempt(this.code, this.type, this.remark, this.appraisal);

  final String code;
  final String type;
  final String remark;
  final double appraisal;

  @override
  List<Object> get props => [code, type, remark, appraisal];
}
