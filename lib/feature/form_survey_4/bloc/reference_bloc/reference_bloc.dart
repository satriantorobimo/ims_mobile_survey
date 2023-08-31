import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/repo/reference_repo.dart';
import 'bloc.dart';

class ReferenceBloc extends Bloc<ReferenceEvent, ReferenceState> {
  ReferenceState get initialState => ReferenceInitial();
  ReferenceRepo referenceRepo = ReferenceRepo();
  ReferenceBloc({required this.referenceRepo}) : super(ReferenceInitial()) {
    on<ReferenceEvent>((event, emit) async {
      if (event is InsertReferenceAttempt) {
        try {
          emit(ReferenceLoading());
          final successUpdateResponseModel =
              await referenceRepo.attemptInsertReference(event.hubunganModel);
          if (successUpdateResponseModel!.result == 1) {
            emit(ReferenceLoaded(
                successUpdateResponseModel: successUpdateResponseModel));
          } else if (successUpdateResponseModel.result == 0) {
            emit(ReferenceError(successUpdateResponseModel.message));
          } else {
            emit(const ReferenceException('error'));
          }
        } catch (e) {
          emit(ReferenceException(e.toString()));
        }
      }
    });
  }
}
