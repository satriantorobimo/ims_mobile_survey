import 'package:equatable/equatable.dart';

abstract class LogoutEvent extends Equatable {
  const LogoutEvent();
}

class LogoutAttempt extends LogoutEvent {
  const LogoutAttempt();

  @override
  List<Object> get props => [];
}
