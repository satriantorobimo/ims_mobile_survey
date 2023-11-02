import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'bloc.dart';

class AttachmentListBloc
    extends Bloc<AttachmentListEvent, AttachmentListState> {
  AttachmentListState get initialState => AttachmentListInitial();
  AttachmentListRepo attachmentListRepo = AttachmentListRepo();
  AttachmentListBloc({required this.attachmentListRepo})
      : super(AttachmentListInitial()) {
    on<AttachmentListEvent>((event, emit) async {
      if (event is AttachmentListAttempt) {
        try {
          emit(AttachmentListLoading());
          final attachmentListResponseModel =
              await attachmentListRepo.attemptGetAttachmentList(event.code);
          if (attachmentListResponseModel!.result == 1) {
            emit(AttachmentListLoaded(
                attachmentListResponseModel: attachmentListResponseModel));
          } else if (attachmentListResponseModel.result == 0) {
            emit(AttachmentListError(attachmentListResponseModel.message));
          } else {
            emit(const AttachmentListException('error'));
          }
        } catch (e) {
          emit(AttachmentListException(e.toString()));
        }
      }

      if (event is AttachmentBulkAttempt) {
        try {
          emit(AttachmentListLoading());
          final attachmentListResponseModel =
              await attachmentListRepo.attemptGetAttachmentBulk(event.listData);
          if (attachmentListResponseModel!.result == 1) {
            emit(AttachmentListLoaded(
                attachmentListResponseModel: attachmentListResponseModel));
          } else if (attachmentListResponseModel.result == 0) {
            emit(AttachmentListError(attachmentListResponseModel.message));
          } else {
            emit(const AttachmentListException('error'));
          }
        } catch (e) {
          emit(AttachmentListException(e.toString()));
        }
      }
    });
  }
}
