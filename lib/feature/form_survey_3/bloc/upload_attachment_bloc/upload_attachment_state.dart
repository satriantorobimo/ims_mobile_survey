import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

abstract class UploadAttachmentState extends Equatable {
  const UploadAttachmentState();

  @override
  List<Object> get props => [];
}

class UploadAttachmentInitial extends UploadAttachmentState {}

class UploadAttachmentLoading extends UploadAttachmentState {}

class UploadAttachmentLoaded extends UploadAttachmentState {
  const UploadAttachmentLoaded({required this.successUpdateResponseModel});
  final SuccessUpdateResponseModel successUpdateResponseModel;

  @override
  List<Object> get props => [successUpdateResponseModel];
}

class UploadAttachmentError extends UploadAttachmentState {
  const UploadAttachmentError(this.error);
  final String? error;

  @override
  List<Object> get props => [error!];
}

class UploadAttachmentException extends UploadAttachmentState {
  const UploadAttachmentException(this.error);
  final String error;

  @override
  List<Object> get props => [error];
}
