import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_2/data/get_question_request_model.dart';

abstract class AttachmentListEvent extends Equatable {
  const AttachmentListEvent();
}

class AttachmentListAttempt extends AttachmentListEvent {
  const AttachmentListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class AttachmentBulkAttempt extends AttachmentListEvent {
  const AttachmentBulkAttempt(this.listData);
  final List<GetQuestionReqModel> listData;

  @override
  List<Object> get props => [listData];
}
