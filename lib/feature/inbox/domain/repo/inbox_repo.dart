import 'package:mobile_survey/feature/inbox/data/inbox_response_model.dart';
import 'package:mobile_survey/feature/inbox/domain/api/inbox_api.dart';

class InboxRepo {
  final InboxApi inboxApi = InboxApi();

  Future<InboxResponseModel?>? attemptGetInbox() => inboxApi.attemptGetInbox();
}
