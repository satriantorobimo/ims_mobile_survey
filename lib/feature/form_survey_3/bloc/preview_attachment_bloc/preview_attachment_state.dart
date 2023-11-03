import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_3/data/preview_attachment_response_model.dart';

abstract class PreviewAttachmentState extends Equatable {
  const PreviewAttachmentState();

  @override
  List<Object> get props => [];
}

class PreviewAttachmentInitial extends PreviewAttachmentState {}

class PreviewAttachmentLoading extends PreviewAttachmentState {}

class PreviewAttachmentLoaded extends PreviewAttachmentState {
  const PreviewAttachmentLoaded({required this.previewAttachmentResponseModel});
  final PreviewAttachmentResponseModel previewAttachmentResponseModel;

  @override
  List<Object> get props => [previewAttachmentResponseModel];
}

class PreviewAttachmentError extends PreviewAttachmentState {
  const PreviewAttachmentError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class PreviewAttachmentException extends PreviewAttachmentState {
  const PreviewAttachmentException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
