class QuestionListResponseModel {
  int? result;
  int? statusCode;
  String? message;
  List<Data>? data;
  String? code;
  int? id;

  QuestionListResponseModel(
      {this.result,
      this.statusCode,
      this.message,
      this.data,
      this.code,
      this.id});

  QuestionListResponseModel.fromJson(Map<String, dynamic> json) {
    result = json['result'];
    statusCode = json['StatusCode'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    code = json['code'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['result'] = result;
    data['StatusCode'] = statusCode;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['code'] = code;
    data['id'] = id;
    return data;
  }
}

class Data {
  String? code;
  String? taskCode;
  String? questionCode;
  String? questionDesc;
  String? type;
  String? answer;
  int? answerChoiceId;
  List<AnswerChoice>? answerChoice;

  Data(
      {this.code,
      this.taskCode,
      this.questionCode,
      this.questionDesc,
      this.type,
      this.answer,
      this.answerChoiceId,
      this.answerChoice});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    taskCode = json['task_code'];
    questionCode = json['question_code'];
    questionDesc = json['question_desc'];
    type = json['type'];
    answer = json['answer'];
    answerChoiceId = json['answer_choice_id'];
    if (json['answer_choice'] != null) {
      answerChoice = <AnswerChoice>[];
      json['answer_choice'].forEach((v) {
        answerChoice!.add(AnswerChoice.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['task_code'] = taskCode;
    data['question_code'] = questionCode;
    data['question_desc'] = questionDesc;
    data['type'] = type;
    data['answer'] = answer;
    data['answer_choice_id'] = answerChoiceId;
    if (answerChoice != null) {
      data['answer_choice'] = answerChoice!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnswerChoice {
  int? id;
  String? taskQuestionCode;
  String? questionOptionDesc;

  AnswerChoice({this.id, this.taskQuestionCode, this.questionOptionDesc});

  AnswerChoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    taskQuestionCode = json['task_question_code'];
    questionOptionDesc = json['question_option_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['task_question_code'] = taskQuestionCode;
    data['question_option_desc'] = questionOptionDesc;
    return data;
  }
}
