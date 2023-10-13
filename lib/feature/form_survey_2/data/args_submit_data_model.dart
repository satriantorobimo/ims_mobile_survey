import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';

import '../../assignment/data/task_list_response_model.dart';

class ArgsSubmitDataModel {
  final List<AnswerResultsModel> answerResults;
  final Data taskList;
  final List<UploadAttachmentModel> uploadAttachment;
  final List<HubunganModel> refrence;

  ArgsSubmitDataModel(
      {required this.answerResults,
      required this.taskList,
      required this.uploadAttachment,
      required this.refrence});
}
