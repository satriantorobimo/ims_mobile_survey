import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/login/domain/repo/login_repo.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginState get initialState => LoginInitial();
  LoginRepo loginRepo = LoginRepo();
  LoginBloc({required this.loginRepo}) : super(LoginInitial()) {
    on<LoginEvent>((event, emit) async {
      if (event is LoginAttempt) {
        try {
          emit(LoginLoading());
          final loginResponseModel =
              await loginRepo.attemptLogin(event.loginRequestModel);
          if (loginResponseModel!.status == 1) {
            emit(LoginLoaded(loginResponseModel: loginResponseModel));
          } else if (loginResponseModel.status == 0) {
            emit(LoginError(loginResponseModel.message));
          } else {
            emit(const LoginException('error'));
          }
        } catch (e) {
          emit(LoginException(e.toString()));
        }
      }
    });
  }
}
