import 'dart:convert';
import 'package:mobile_survey/feature/inbox/data/inbox_response_model.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/url_util.dart';
import 'package:http/http.dart' as http;

class InboxApi {
  InboxResponseModel inboxResponseModel = InboxResponseModel();

  UrlUtil urlUtil = UrlUtil();

  Future<InboxResponseModel> attemptGetInbox() async {
    List a = [];
    final String? token = await SharedPrefUtil.getSharedString('token');
    final String? username = await SharedPrefUtil.getSharedString('username');
    final dynamic ip = await GeneralUtil.getIpAddress();
    final Map<String, String> header =
        urlUtil.getHeaderTypeWithToken(token!, ip['ip']!);
    final Map mapData = {};
    mapData['p_username'] = username;
    a.add(mapData);

    final json = jsonEncode(a);

    try {
      final res = await http.post(Uri.parse(urlUtil.getUrlInbox()),
          body: json, headers: header);
      if (res.statusCode == 200) {
        inboxResponseModel = InboxResponseModel.fromJson(jsonDecode(res.body));
        return inboxResponseModel;
      } else if (res.statusCode == 401) {
        throw 'expired';
      } else {
        inboxResponseModel = InboxResponseModel.fromJson(jsonDecode(res.body));
        throw inboxResponseModel.message!;
      }
    } catch (ex) {
      throw ex.toString();
    }
  }
}
