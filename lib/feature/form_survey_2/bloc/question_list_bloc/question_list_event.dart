import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_2/data/get_question_request_model.dart';

import '../../../assignment/data/task_list_response_model.dart';

abstract class QuestionListEvent extends Equatable {
  const QuestionListEvent();
}

class QuestionListAttempt extends QuestionListEvent {
  const QuestionListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}

class QuestionBulkAttempt extends QuestionListEvent {
  const QuestionBulkAttempt(this.listData);
  final List<GetQuestionReqModel> listData;

  @override
  List<Object> get props => [listData];
}

class QuestionListLoopAttempt extends QuestionListEvent {
  const QuestionListLoopAttempt(this.data);
  final List<Data> data;

  @override
  List<Object> get props => [data];
}
