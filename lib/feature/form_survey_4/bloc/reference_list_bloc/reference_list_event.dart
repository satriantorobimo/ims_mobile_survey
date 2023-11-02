import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_2/data/get_question_request_model.dart';

abstract class ReferenceListEvent extends Equatable {
  const ReferenceListEvent();
}

class ReferenceListAttempt extends ReferenceListEvent {
  const ReferenceListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class ReferenceBulkAttempt extends ReferenceListEvent {
  const ReferenceBulkAttempt(this.listData);
  final List<GetQuestionReqModel> listData;

  @override
  List<Object> get props => [listData];
}
