import 'dart:convert';
import 'dart:developer';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/url_util.dart';
import 'package:http/http.dart' as http;

class TaskListApi {
  TaskListResponseModel taskListResponseModel = TaskListResponseModel();
  SuccessUpdateResponseModel successUpdateResponseModel =
      SuccessUpdateResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<SuccessUpdateResponseModel> attemptUpdateTask(
      String code, String type, String remark, double appraisal) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    mapData['p_code'] = code;
    mapData['p_type'] = type;
    mapData['p_remark'] = remark;
    mapData['p_appraisal_amount'] = appraisal;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlUpdateTask()),
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

  Future<TaskListResponseModel> attemptGetTaskList() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? username = await SharedPrefUtil.getSharedString('username');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    mapData['p_username'] = username;
    a.add(mapData);
    log(token);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlTaskList()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        taskListResponseModel =
            TaskListResponseModel.fromJson(jsonDecode(res.body));
        return taskListResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        taskListResponseModel =
            TaskListResponseModel.fromJson(jsonDecode(res.body));
        throw taskListResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
