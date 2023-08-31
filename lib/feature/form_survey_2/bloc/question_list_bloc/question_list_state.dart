import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';

abstract class QuestionListState extends Equatable {
  const QuestionListState();

  @override
  List<Object> get props => [];
}

class QuestionListInitial extends QuestionListState {}

class QuestionListLoading extends QuestionListState {}

class QuestionListLoaded extends QuestionListState {
  const QuestionListLoaded({required this.questionListResponseModel});
  final QuestionListResponseModel questionListResponseModel;

  @override
  List<Object> get props => [questionListResponseModel];
}

class QuestionListError extends QuestionListState {
  const QuestionListError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class QuestionListException extends QuestionListState {
  const QuestionListException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
