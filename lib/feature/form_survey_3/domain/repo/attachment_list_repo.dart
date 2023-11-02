import 'package:mobile_survey/feature/form_survey_2/data/get_question_request_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/preview_attachment_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/api/attachment_list_api.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

class AttachmentListRepo {
  final AttachmentListApi attachmentListApi = AttachmentListApi();

  Future<SuccessUpdateResponseModel?> attemptUploadAttachment(
          UploadAttachmentModel uploadAttachmentModel) =>
      attachmentListApi.attemptUploadAttachment(uploadAttachmentModel);

  Future<AttachmentListResponseModel?> attemptGetAttachmentList(String code) =>
      attachmentListApi.attemptGetAttachmentList(code);

  Future<AttachmentListResponseModel?> attemptGetAttachmentBulk(
          List<GetQuestionReqModel> listData) =>
      attachmentListApi.attemptGetAttachmentBulk(listData);

  Future<PreviewAttachmentResponseModel?> attemptPreviewAttachment(
          String fileName, String filePath) =>
      attachmentListApi.attemptPreviewAttachment(fileName, filePath);
}
