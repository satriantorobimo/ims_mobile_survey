import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';

abstract class AttachmentListState extends Equatable {
  const AttachmentListState();

  @override
  List<Object> get props => [];
}

class AttachmentListInitial extends AttachmentListState {}

class AttachmentListLoading extends AttachmentListState {}

class AttachmentListLoaded extends AttachmentListState {
  const AttachmentListLoaded({required this.attachmentListResponseModel});
  final AttachmentListResponseModel attachmentListResponseModel;

  @override
  List<Object> get props => [attachmentListResponseModel];
}

class AttachmentListError extends AttachmentListState {
  const AttachmentListError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class AttachmentListException extends AttachmentListState {
  const AttachmentListException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
