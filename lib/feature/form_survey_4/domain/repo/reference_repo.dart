import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/api/reference_api.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

class ReferenceRepo {
  final ReferenceApi referenceApi = ReferenceApi();

  Future<SuccessUpdateResponseModel?> attemptInsertReference(
          HubunganModel hubunganModel) =>
      referenceApi.attemptInsertReference(hubunganModel);
}
