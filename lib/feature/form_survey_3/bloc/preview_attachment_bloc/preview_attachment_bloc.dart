import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'bloc.dart';

class PreviewAttachmentBloc
    extends Bloc<PreviewAttachmentEvent, PreviewAttachmentState> {
  PreviewAttachmentState get initialState => PreviewAttachmentInitial();
  AttachmentListRepo attachmentListRepo = AttachmentListRepo();
  PreviewAttachmentBloc({required this.attachmentListRepo})
      : super(PreviewAttachmentInitial()) {
    on<PreviewAttachmentEvent>((event, emit) async {
      if (event is PreviewAttachmentAttempt) {
        try {
          emit(PreviewAttachmentLoading());
          final previewAttachmentResponseModel = await attachmentListRepo
              .attemptPreviewAttachment(event.fileName, event.filePath);
          if (previewAttachmentResponseModel!.statusCode == 200) {
            emit(PreviewAttachmentLoaded(
                previewAttachmentResponseModel:
                    previewAttachmentResponseModel));
          } else if (previewAttachmentResponseModel.statusCode == 401) {
            emit(
                PreviewAttachmentError(previewAttachmentResponseModel.message));
          } else {
            emit(const PreviewAttachmentException('error'));
          }
        } catch (e) {
          emit(PreviewAttachmentException(e.toString()));
        }
      }
    });
  }
}
