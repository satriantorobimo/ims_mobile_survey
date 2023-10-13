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

class DataWithoutAnswer {
  String? code;
  String? taskCode;
  String? questionCode;
  String? questionDesc;
  String? type;
  String? answer;
  int? answerChoiceId;

  DataWithoutAnswer(
      {this.code,
      this.taskCode,
      this.questionCode,
      this.questionDesc,
      this.type,
      this.answer,
      this.answerChoiceId});

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'task_code': taskCode,
      'question_code': questionCode,
      'question_desc': questionDesc,
      'type': type,
      'answer': answer,
      'answer_choice_id': answerChoiceId
    };
  }

  factory DataWithoutAnswer.fromMap(Map<String, dynamic> map) {
    return DataWithoutAnswer(
        code: map['code'],
        taskCode: map['task_code'],
        questionCode: map['question_code'],
        questionDesc: map['question_desc'],
        type: map['type'],
        answer: map['answer'],
        answerChoiceId: map['answer_choice_id']);
  }
}

class AnswerChoice {
  int? id;
  String? questionCode;
  String? questionOptionDesc;
  String? taskQuestionCode;

  AnswerChoice(
      {this.id,
      this.questionCode,
      this.questionOptionDesc,
      this.taskQuestionCode});

  AnswerChoice.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionCode = json['question_code'];
    questionOptionDesc = json['question_option_desc'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question_code'] = questionCode;
    data['question_option_desc'] = questionOptionDesc;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question_code': questionCode,
      'question_option_desc': questionOptionDesc,
      'task_question_code': taskQuestionCode
    };
  }

  factory AnswerChoice.fromMap(Map<String, dynamic> map) {
    return AnswerChoice(
        id: map['id'],
        questionCode: map['question_code'],
        questionOptionDesc: map['question_option_desc'],
        taskQuestionCode: map['task_question_code']);
  }
}
