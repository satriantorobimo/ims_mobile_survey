import 'package:mobile_survey/feature/login/data/login_request_model.dart';
import 'package:mobile_survey/feature/login/data/login_response_model.dart';
import 'package:mobile_survey/feature/login/domain/api/login_api.dart';

class LoginRepo {
  final LoginApi loginApi = LoginApi();

  Future<LoginResponseModel?>? attemptLogin(
          LoginRequestModel loginRequestModel) =>
      loginApi.attemptLogin(loginRequestModel);
}
