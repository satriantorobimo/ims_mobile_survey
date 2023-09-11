import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/account/domain/repo/logout_repo.dart';
import 'bloc.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  LogoutState get initialState => LogoutInitial();
  LogoutRepo logoutRepo = LogoutRepo();
  LogoutBloc({required this.logoutRepo}) : super(LogoutInitial()) {
    on<LogoutEvent>((event, emit) async {
      if (event is LogoutAttempt) {
        try {
          emit(LogoutLoading());
          final successUpdateResponseModel = await logoutRepo.attemptLogout();
          if (successUpdateResponseModel!.result == 1) {
            emit(LogoutLoaded(
                successUpdateResponseModel: successUpdateResponseModel));
          } else if (successUpdateResponseModel.result == 0) {
            emit(LogoutError(successUpdateResponseModel.message));
          } else {
            emit(const LogoutException('error'));
          }
        } catch (e) {
          emit(LogoutException(e.toString()));
        }
      }
    });
  }
}
