import 'dart:convert';
import 'package:mobile_survey/feature/form_survey_2/data/get_question_request_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/preview_attachment_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/url_util.dart';
import 'package:http/http.dart' as http;

class AttachmentListApi {
  AttachmentListResponseModel attachmentListResponseModel =
      AttachmentListResponseModel();
  PreviewAttachmentResponseModel previewAttachmentResponseModel =
      PreviewAttachmentResponseModel();
  SuccessUpdateResponseModel successUpdateResponseModel =
      SuccessUpdateResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<SuccessUpdateResponseModel> attemptUploadAttachment(
      UploadAttachmentModel uploadAttachmentModel) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    var data = uploadAttachmentModel.toJson();
    a.add(data);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlUploadAttachment()),
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

  Future<AttachmentListResponseModel> attemptGetAttachmentList(
      String code) async {
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
      final res = await http.post(Uri.parse(urlUtil.getUrlAttachment()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        attachmentListResponseModel =
            AttachmentListResponseModel.fromJson(jsonDecode(res.body));
        return attachmentListResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        attachmentListResponseModel =
            AttachmentListResponseModel.fromJson(jsonDecode(res.body));
        throw attachmentListResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<AttachmentListResponseModel> attemptGetAttachmentBulk(
      List<GetQuestionReqModel> listData) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    var jeson = jsonEncode(listData);
    mapData['p_list_task_code'] = jeson;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlAttachmentBulk()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        attachmentListResponseModel =
            AttachmentListResponseModel.fromJson(jsonDecode(res.body));
        return attachmentListResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        attachmentListResponseModel =
            AttachmentListResponseModel.fromJson(jsonDecode(res.body));
        throw attachmentListResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }

  Future<PreviewAttachmentResponseModel> attemptPreviewAttachment(
      String fileName, String filePath) async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    mapData['p_file_name'] = fileName;
    mapData['p_file_paths'] = filePath;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlPreviewAttachment()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        previewAttachmentResponseModel =
            PreviewAttachmentResponseModel.fromJson(jsonDecode(res.body));
        return previewAttachmentResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        previewAttachmentResponseModel =
            PreviewAttachmentResponseModel.fromJson(jsonDecode(res.body));
        throw previewAttachmentResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
