import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';

@dao
abstract class TaskListDao {
  @Query('SELECT * FROM TaskList')
  Future<List<TaskList?>> findAllTaskList();

  @Query('SELECT * FROM TaskList WHERE code = :code')
  Future<TaskList?> findTaskListById(String code);

  @Query('SELECT * FROM TaskList WHERE status = :status')
  Future<List<TaskList?>> findTaskListByStatus(String status);

  @Query('DELETE FROM TaskList WHERE code = :code')
  Future<void> deleteTaskListById(String code);

  @Query('DELETE FROM TaskList WHERE status = :status')
  Future<void> deleteTaskListByStatus(String status);

  @Query('UPDATE TaskList SET status = :status WHERE code = :code')
  Future<void> updateTaskStatusById(String status, String code);

  @Query(
      'UPDATE TaskList SET status = :status AND remark = :remark AND result = :result AND appraisalAmount = :appraisal WHERE code = :code')
  Future<void> updateTaskData(String status, String remark, String result,
      double appraisal, String code);

  @insert
  Future<void> insertTaskList(TaskList user);

  @insert
  Future<void> insertAllTaskList(List<TaskList> user);

  @update
  Future<void> updateTask(TaskList user);
}
