import 'package:floor/floor.dart';

@entity
class PendingAnswer {
  @PrimaryKey(autoGenerate: true)
  int? ids;

  String pCode;
  String? pAnswer;
  int? pAnswerChoiceId;

  PendingAnswer(
      {this.ids,
      required this.pCode,
      required this.pAnswer,
      required this.pAnswerChoiceId});

  PendingAnswer copyWith(
      {int? ids, String? pCode, String? pAnswer, int? pAnswerChoiceId}) {
    return PendingAnswer(
        ids: ids,
        pCode: pCode ?? this.pCode,
        pAnswer: pAnswer ?? this.pAnswer,
        pAnswerChoiceId: pAnswerChoiceId ?? this.pAnswerChoiceId);
  }
}
