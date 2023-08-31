import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

abstract class ReferenceState extends Equatable {
  const ReferenceState();

  @override
  List<Object> get props => [];
}

class ReferenceInitial extends ReferenceState {}

class ReferenceLoading extends ReferenceState {}

class ReferenceLoaded extends ReferenceState {
  const ReferenceLoaded({required this.successUpdateResponseModel});
  final SuccessUpdateResponseModel successUpdateResponseModel;

  @override
  List<Object> get props => [successUpdateResponseModel];
}

class ReferenceError extends ReferenceState {
  const ReferenceError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ReferenceException extends ReferenceState {
  const ReferenceException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
