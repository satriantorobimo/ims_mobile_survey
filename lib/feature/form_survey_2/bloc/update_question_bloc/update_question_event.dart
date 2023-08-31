import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';

abstract class UpdateQuestionEvent extends Equatable {
  const UpdateQuestionEvent();
}

class UpdateQuestionAttempt extends UpdateQuestionEvent {
  const UpdateQuestionAttempt(this.answerResultsModel);
  final AnswerResultsModel answerResultsModel;

  @override
  List<Object> get props => [answerResultsModel];
}
