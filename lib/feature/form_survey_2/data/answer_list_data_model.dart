import 'package:floor/floor.dart';

@entity
class AnswerList {
  @PrimaryKey(autoGenerate: true)
  int? ids;

  int id;
  @ColumnInfo(name: 'task_question_code')
  String taskQuestionCode;
  String questionOptionDesc;

  AnswerList(
      {this.ids,
      required this.id,
      required this.questionOptionDesc,
      required this.taskQuestionCode});

  AnswerList copyWith(
      {int? ids,
      int? id,
      String? taskQuestionCode,
      String? questionOptionDesc}) {
    return AnswerList(
        ids: ids,
        id: id ?? this.id,
        questionOptionDesc: questionOptionDesc ?? this.questionOptionDesc,
        taskQuestionCode: taskQuestionCode ?? this.taskQuestionCode);
  }
}
