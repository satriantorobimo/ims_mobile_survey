import 'package:floor/floor.dart';

@entity
class QuestionList {
  @primaryKey
  String code;

  @ColumnInfo(name: 'task_code')
  String taskCode;
  String questionCode;
  String questionDesc;
  String type;
  String? answer;
  int? answerChoiceId;

  QuestionList(
      {required this.code,
      required this.taskCode,
      required this.questionCode,
      required this.questionDesc,
      required this.type,
      required this.answer,
      required this.answerChoiceId});
}
