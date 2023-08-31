import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

abstract class UpdateQuestionState extends Equatable {
  const UpdateQuestionState();

  @override
  List<Object> get props => [];
}

class UpdateQuestionInitial extends UpdateQuestionState {}

class UpdateQuestionLoading extends UpdateQuestionState {}

class UpdateQuestionLoaded extends UpdateQuestionState {
  const UpdateQuestionLoaded({required this.successUpdateResponseModel});
  final SuccessUpdateResponseModel successUpdateResponseModel;

  @override
  List<Object> get props => [successUpdateResponseModel];
}

class UpdateQuestionError extends UpdateQuestionState {
  const UpdateQuestionError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class UpdateQuestionException extends UpdateQuestionState {
  const UpdateQuestionException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
