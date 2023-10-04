import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/repo/reference_repo.dart';
import 'bloc.dart';

class ReferenceListBloc extends Bloc<ReferenceListEvent, ReferenceListState> {
  ReferenceListState get initialState => ReferenceListInitial();
  ReferenceRepo referenceRepo = ReferenceRepo();
  ReferenceListBloc({required this.referenceRepo})
      : super(ReferenceListInitial()) {
    on<ReferenceListEvent>((event, emit) async {
      if (event is ReferenceListAttempt) {
        try {
          emit(ReferenceListLoading());
          final referenceListResponseModel =
              await referenceRepo.attemptGetReference(event.code);
          if (referenceListResponseModel!.result == 1) {
            emit(ReferenceListLoaded(
                referenceListResponseModel: referenceListResponseModel));
          } else if (referenceListResponseModel.result == 0) {
            emit(ReferenceListError(referenceListResponseModel.message));
          } else {
            emit(const ReferenceListException('error'));
          }
        } catch (e) {
          emit(ReferenceListException(e.toString()));
        }
      }
    });
  }
}
