import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';

class ArgsSubmitDataModel {
  final List<AnswerResultsModel> answerResults;
  final TaskList taskList;
  final List<UploadAttachmentModel> uploadAttachment;
  final List<HubunganModel> refrence;

  ArgsSubmitDataModel(
      {required this.answerResults,
      required this.taskList,
      required this.uploadAttachment,
      required this.refrence});
}
