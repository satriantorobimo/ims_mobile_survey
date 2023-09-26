import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/assignment/domain/api/task_list_api.dart';
import 'package:mobile_survey/feature/form_survey_5/data/success_update_response_model.dart';

class TaskListRepo {
  final TaskListApi taskListApi = TaskListApi();

  Future<TaskListResponseModel?> attemptGetTaskList() =>
      taskListApi.attemptGetTaskList();

  Future<SuccessUpdateResponseModel?> attemptUpdateTask(String code,
          String type, String remark, double appraisal, String result) =>
      taskListApi.attemptUpdateTask(code, type, remark, appraisal, result);
}
