import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_4/data/reference_list_response_model.dart';

abstract class ReferenceListState extends Equatable {
  const ReferenceListState();

  @override
  List<Object> get props => [];
}

class ReferenceListInitial extends ReferenceListState {}

class ReferenceListLoading extends ReferenceListState {}

class ReferenceListLoaded extends ReferenceListState {
  const ReferenceListLoaded({required this.referenceListResponseModel});
  final ReferenceListResponseModel referenceListResponseModel;

  @override
  List<Object> get props => [referenceListResponseModel];
}

class ReferenceListError extends ReferenceListState {
  const ReferenceListError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class ReferenceListException extends ReferenceListState {
  const ReferenceListException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
