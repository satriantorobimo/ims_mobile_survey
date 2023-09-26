import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';

import 'bloc.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskState get initialState => UpdateTaskInitial();
  TaskListRepo taskListRepo = TaskListRepo();
  UpdateTaskBloc({required this.taskListRepo}) : super(UpdateTaskInitial()) {
    on<UpdateTaskEvent>((event, emit) async {
      if (event is UpdateTaskAttempt) {
        try {
          emit(UpdateTaskLoading());
          final successUpdateResponseModel =
              await taskListRepo.attemptUpdateTask(event.code, event.type,
                  event.remark, event.appraisal, event.result);
          if (successUpdateResponseModel!.result == 1) {
            emit(UpdateTaskLoaded(
                successUpdateResponseModel: successUpdateResponseModel));
          } else if (successUpdateResponseModel.result == 0) {
            emit(UpdateTaskError(successUpdateResponseModel.message));
          } else {
            emit(const UpdateTaskException('error'));
          }
        } catch (e) {
          emit(UpdateTaskException(e.toString()));
        }
      }
    });
  }
}
