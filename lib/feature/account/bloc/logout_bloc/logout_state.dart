import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

abstract class LogoutState extends Equatable {
  const LogoutState();

  @override
  List<Object> get props => [];
}

class LogoutInitial extends LogoutState {}

class LogoutLoading extends LogoutState {}

class LogoutLoaded extends LogoutState {
  const LogoutLoaded({required this.successUpdateResponseModel});
  final SuccessUpdateResponseModel successUpdateResponseModel;

  @override
  List<Object> get props => [successUpdateResponseModel];
}

class LogoutError extends LogoutState {
  const LogoutError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class LogoutException extends LogoutState {
  const LogoutException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
