import 'dart:convert';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/url_util.dart';
import 'package:http/http.dart' as http;

class ReferenceApi {
  SuccessUpdateResponseModel successUpdateResponseModel =
      SuccessUpdateResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<SuccessUpdateResponseModel> attemptInsertReference(
      HubunganModel hubunganModel) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    var data = hubunganModel.toJson();
    a.add(data);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlInsertReference()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        successUpdateResponseModel =
            SuccessUpdateResponseModel.fromJson(jsonDecode(res.body));
        return successUpdateResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        successUpdateResponseModel =
            SuccessUpdateResponseModel.fromJson(jsonDecode(res.body));
        throw successUpdateResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
