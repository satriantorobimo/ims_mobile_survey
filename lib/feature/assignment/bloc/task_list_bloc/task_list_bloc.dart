import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';

import 'bloc.dart';

class TaskListBloc extends Bloc<TaskListEvent, TaskListState> {
  TaskListState get initialState => TaskListInitial();
  TaskListRepo taskListRepo = TaskListRepo();
  TaskListBloc({required this.taskListRepo}) : super(TaskListInitial()) {
    on<TaskListEvent>((event, emit) async {
      if (event is TaskListAttempt) {
        try {
          emit(TaskListLoading());
          final taskListResponseModel = await taskListRepo.attemptGetTaskList();
          if (taskListResponseModel!.result == 1) {
            emit(TaskListLoaded(taskListResponseModel: taskListResponseModel));
          } else if (taskListResponseModel.result == 0) {
            emit(TaskListError(taskListResponseModel.message));
          } else {
            emit(const TaskListException('error'));
          }
        } catch (e) {
          emit(TaskListException(e.toString()));
        }
      }
    });
  }
}
