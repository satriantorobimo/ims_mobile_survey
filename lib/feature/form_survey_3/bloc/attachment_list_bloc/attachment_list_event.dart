import 'package:equatable/equatable.dart';

abstract class AttachmentListEvent extends Equatable {
  const AttachmentListEvent();
}

class AttachmentListAttempt extends AttachmentListEvent {
  const AttachmentListAttempt(this.code);
  final String code;

  @override
  List<Object> get props => [code];
}
