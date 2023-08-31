import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

abstract class UpdateTaskState extends Equatable {
  const UpdateTaskState();

  @override
  List<Object> get props => [];
}

class UpdateTaskInitial extends UpdateTaskState {}

class UpdateTaskLoading extends UpdateTaskState {}

class UpdateTaskLoaded extends UpdateTaskState {
  const UpdateTaskLoaded({required this.successUpdateResponseModel});
  final SuccessUpdateResponseModel successUpdateResponseModel;

  @override
  List<Object> get props => [successUpdateResponseModel];
}

class UpdateTaskError extends UpdateTaskState {
  const UpdateTaskError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class UpdateTaskException extends UpdateTaskState {
  const UpdateTaskException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
