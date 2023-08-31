import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/api/question_list_api.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

class QuestionListRepo {
  final QuestionListApi questionListApi = QuestionListApi();

  Future<QuestionListResponseModel?> attemptGetQuestionList(String code) =>
      questionListApi.attemptGetQuestionList(code);

  Future<SuccessUpdateResponseModel?> attemptUpdateQuestion(
          AnswerResultsModel answerResultsModel) =>
      questionListApi.attemptUpdateQuestion(answerResultsModel);
}
