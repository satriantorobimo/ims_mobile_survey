import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/repo/question_list_repo.dart';

import 'bloc.dart';

class QuestionListBloc extends Bloc<QuestionListEvent, QuestionListState> {
  QuestionListState get initialState => QuestionListInitial();
  QuestionListRepo questionListRepo = QuestionListRepo();
  QuestionListBloc({required this.questionListRepo})
      : super(QuestionListInitial()) {
    on<QuestionListEvent>((event, emit) async {
      if (event is QuestionListAttempt) {
        try {
          emit(QuestionListLoading());
          final questionListResponseModel =
              await questionListRepo.attemptGetQuestionList(event.code);
          if (questionListResponseModel!.result == 1) {
            emit(QuestionListLoaded(
                questionListResponseModel: questionListResponseModel));
          } else if (questionListResponseModel.result == 0) {
            emit(QuestionListError(questionListResponseModel.message));
          } else {
            emit(const QuestionListException('error'));
          }
        } catch (e) {
          emit(QuestionListException(e.toString()));
        }
      }
    });
  }
}
