import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/repo/question_list_repo.dart';

import 'bloc.dart';

class UpdateQuestionBloc
    extends Bloc<UpdateQuestionEvent, UpdateQuestionState> {
  UpdateQuestionState get initialState => UpdateQuestionInitial();
  QuestionListRepo questionListRepo = QuestionListRepo();
  UpdateQuestionBloc({required this.questionListRepo})
      : super(UpdateQuestionInitial()) {
    on<UpdateQuestionEvent>((event, emit) async {
      if (event is UpdateQuestionAttempt) {
        try {
          emit(UpdateQuestionLoading());
          final successUpdateResponseModel = await questionListRepo
              .attemptUpdateQuestion(event.answerResultsModel);
          if (successUpdateResponseModel!.result == 1) {
            emit(UpdateQuestionLoaded(
                successUpdateResponseModel: successUpdateResponseModel));
          } else if (successUpdateResponseModel.result == 0) {
            emit(UpdateQuestionError(successUpdateResponseModel.message));
          } else {
            emit(const UpdateQuestionException('error'));
          }
        } catch (e) {
          emit(UpdateQuestionException(e.toString()));
        }
      }
    });
  }
}
