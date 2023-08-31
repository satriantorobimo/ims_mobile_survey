import 'dart:convert';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/url_util.dart';
import 'package:http/http.dart' as http;

class QuestionListApi {
  QuestionListResponseModel questionListResponseModel =
      QuestionListResponseModel();
  SuccessUpdateResponseModel successUpdateResponseModel =
      SuccessUpdateResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<QuestionListResponseModel> attemptGetQuestionList(String code) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    mapData['p_task_code'] = code;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlQuestion()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        questionListResponseModel =
            QuestionListResponseModel.fromJson(jsonDecode(res.body));
        return questionListResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        questionListResponseModel =
            QuestionListResponseModel.fromJson(jsonDecode(res.body));
        throw questionListResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<SuccessUpdateResponseModel> attemptUpdateQuestion(
      AnswerResultsModel answerResultsModel) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    var datas = answerResultsModel.toJson();
    a.add(datas);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlUpdateQuestion()),
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
