class PendingAnswer {
  int? ids;

  String taskCode;
  String pCode;
  String? pAnswer;
  int? pAnswerChoiceId;

  PendingAnswer(
      {this.ids,
      required this.taskCode,
      required this.pCode,
      required this.pAnswer,
      required this.pAnswerChoiceId});

  PendingAnswer copyWith(
      {int? ids,
      String? pCode,
      String? pAnswer,
      int? pAnswerChoiceId,
      String? taskCode}) {
    return PendingAnswer(
        taskCode: taskCode ?? this.taskCode,
        ids: ids,
        pCode: pCode ?? this.pCode,
        pAnswer: pAnswer ?? this.pAnswer,
        pAnswerChoiceId: pAnswerChoiceId ?? this.pAnswerChoiceId);
  }
}
