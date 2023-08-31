import 'package:equatable/equatable.dart';

abstract class QuestionListEvent extends Equatable {
  const QuestionListEvent();
}

class QuestionListAttempt extends QuestionListEvent {
  const QuestionListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}
