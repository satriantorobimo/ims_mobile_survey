import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'bloc.dart';

class UploadAttachmentBloc
    extends Bloc<UploadAttachmentEvent, UploadAttachmentState> {
  UploadAttachmentState get initialState => UploadAttachmentInitial();
  AttachmentListRepo attachmentListRepo = AttachmentListRepo();
  UploadAttachmentBloc({required this.attachmentListRepo})
      : super(UploadAttachmentInitial()) {
    on<UploadAttachmentEvent>((event, emit) async {
      if (event is UploadAttachmentAttempt) {
        try {
          emit(UploadAttachmentLoading());
          final successUpdateResponseModel = await attachmentListRepo
              .attemptUploadAttachment(event.uploadAttachmentModel);
          if (successUpdateResponseModel!.result == 1) {
            emit(UploadAttachmentLoaded(
                successUpdateResponseModel: successUpdateResponseModel));
          } else if (successUpdateResponseModel.result == 0) {
            emit(UploadAttachmentError(successUpdateResponseModel.message));
          } else {
            emit(const UploadAttachmentException('error'));
          }
        } catch (e) {
          emit(UploadAttachmentException(e.toString()));
        }
      }
    });
  }
}
