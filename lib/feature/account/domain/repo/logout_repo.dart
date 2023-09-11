import 'package:mobile_survey/feature/account/domain/api/logout_api.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

class LogoutRepo {
  final LogoutApi logoutApi = LogoutApi();

  Future<SuccessUpdateResponseModel?>? attemptLogout() =>
      logoutApi.attemptLogout();
}
