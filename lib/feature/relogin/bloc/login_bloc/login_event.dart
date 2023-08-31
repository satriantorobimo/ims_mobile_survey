import 'package:equatable/equatable.dart';
import 'package:mobile_survey/feature/login/data/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginAttempt extends LoginEvent {
  const LoginAttempt({required this.loginRequestModel});
  final LoginRequestModel loginRequestModel;

  @override
  List<Object> get props => [loginRequestModel];
}
