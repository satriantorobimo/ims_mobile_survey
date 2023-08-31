import 'package:equatable/equatable.dart';

abstract class InboxEvent extends Equatable {
  const InboxEvent();
}

class InboxAttempt extends InboxEvent {
  const InboxAttempt();

  @override
  List<Object> get props => [];
}
