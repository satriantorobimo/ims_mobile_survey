import 'dart:convert';

import '../../flavor_config.dart';

class UrlUtil {
  static String baseUrl = FlavorConfig.instance.values.baseUrl!;
  static String userId = FlavorConfig.instance.values.userId!;
  static final Map<String, String> headerType = {
    'Content-Type': 'application/json',
    'Accept': 'application/json'
  };

  static Map<String, String> headerTypeBasicAuth(
          String username, String password) =>
      {
        "content-type": "application/json",
        "accept": "application/json",
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$username:$password'))}'
      };

  static Map<String, String> headerTypeWithToken(String token, String ip) => {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Ipaddress': ip,
        'Userid': userId
      };

  static Map<String, String> headerTypeForm() => {
        'Content-Type': 'application/x-www-form-urlencoded',
      };

  Map<String, String> getHeaderTypeWithToken(String token, String ip) {
    return headerTypeWithToken(token, ip);
  }

  Map<String, String> getHeaderTypeBasicAuth(String username, String password) {
    return headerTypeBasicAuth(username, password);
  }

  Map<String, String> getHeaderTypeForm() {
    return headerTypeForm();
  }

  static String urlLogin() => 'api/mobsvy_api/api/AuthenticateSys/Login';

  String getUrlLogin() {
    final String getUrlLogin2 = urlLogin();
    return baseUrl + getUrlLogin2;
  }

  static String urlLogout() => 'api/mobsvy_api/api/SysUserMain/Logout';

  String getUrlLogout() {
    final String getUrlLogout2 = urlLogout();
    return baseUrl + getUrlLogout2;
  }

  static String urlTaskList() => 'api/mobsvy_api/api/TaskMain/Getrows';

  String getUrlTaskList() {
    final String getUrlTaskList2 = urlTaskList();
    return baseUrl + getUrlTaskList2;
  }

  static String urlUpdateTask() => 'api/mobsvy_api/api/TaskMain/UpdateForType';

  String getUrlUpdateTask() {
    final String getUrlUpdateTask2 = urlUpdateTask();
    return baseUrl + getUrlUpdateTask2;
  }

  static String urlQuestion() => 'api/mobsvy_api/api/TaskQuestion/Getdetail';

  String getUrlQuestion() {
    final String getUrlQuestion2 = urlQuestion();
    return baseUrl + getUrlQuestion2;
  }

  static String urlUpdateQuestion() => 'api/mobsvy_api/api/TaskQuestion/Update';

  String getUrlUpdateQuestion() {
    final String getUrlUpdateQuestion2 = urlUpdateQuestion();
    return baseUrl + getUrlUpdateQuestion2;
  }

  static String urlAttachment() =>
      'api/mobsvy_api/api/TaskDocument/GetAttachments';

  String getUrlAttachment() {
    final String getUrlAttachment2 = urlAttachment();
    return baseUrl + getUrlAttachment2;
  }

  static String urlUploadAttachment() =>
      'api/mobsvy_api/api/TaskDocument/Upload';

  String getUrlUploadAttachment() {
    final String getUrlUploadAttachment2 = urlUploadAttachment();
    return baseUrl + getUrlUploadAttachment2;
  }

  static String urlPreviewAttachment() =>
      'api/mobsvy_api/api/TaskDocument/Preview';

  String getUrlPreviewAttachment() {
    final String getUrlPreviewAttachment2 = urlPreviewAttachment();
    return baseUrl + getUrlPreviewAttachment2;
  }

  static String urlInbox() => 'api/mobsvy_api/api/TaskNotification/GetRows';

  String getUrlInbox() {
    final String getUrlInbox2 = urlInbox();
    return baseUrl + getUrlInbox2;
  }

  static String urlInsertReference() =>
      'api/mobsvy_api/api/TaskReference/Insert';

  String getUrlInsertReference() {
    final String urlInsertReference2 = urlInsertReference();
    return baseUrl + urlInsertReference2;
  }

  static String urlListReference() =>
      'api/mobsvy_api/api/TaskReference/Getrows';

  String getUrlListReference() {
    final String urlInsertReference2 = urlListReference();
    return baseUrl + urlInsertReference2;
  }
}
