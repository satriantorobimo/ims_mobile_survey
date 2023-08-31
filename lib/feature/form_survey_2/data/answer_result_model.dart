class AnswerResultsModel {
  String? pCode;
  String? pAnswer;
  int? pAnswerChoiceId;

  AnswerResultsModel({this.pCode, this.pAnswer, this.pAnswerChoiceId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['p_code'] = pCode;
    data['p_answer'] = pAnswer;
    data['p_answer_choice_id'] = pAnswerChoiceId;
    return data;
  }
}
