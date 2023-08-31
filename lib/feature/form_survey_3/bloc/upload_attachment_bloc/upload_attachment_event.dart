import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';

abstract class UploadAttachmentEvent extends Equatable {
  const UploadAttachmentEvent();
}

class UploadAttachmentAttempt extends UploadAttachmentEvent {
  const UploadAttachmentAttempt(this.uploadAttachmentModel);
  final UploadAttachmentModel uploadAttachmentModel;

  @override
  List<Object> get props => [uploadAttachmentModel];
}
