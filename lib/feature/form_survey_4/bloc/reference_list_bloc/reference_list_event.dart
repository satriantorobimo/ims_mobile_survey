import 'package:equatable/equatable.dart';

abstract class ReferenceListEvent extends Equatable {
  const ReferenceListEvent();
}

class ReferenceListAttempt extends ReferenceListEvent {
  const ReferenceListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}
