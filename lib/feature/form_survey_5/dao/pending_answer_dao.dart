import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_answer_data_model.dart';

@dao
abstract class PendingAnswerDao {
  @Query('SELECT * FROM PendingAnswer')
  Future<List<PendingAnswer>> findAllPendingAnswer();

  @Query('SELECT * FROM PendingAnswer WHERE pCode = :taskCode')
  Future<PendingAnswer?> findPendingAnswerById(String taskCode);

  @Query('SELECT * FROM PendingAnswer WHERE pCode = :taskCode')
  Future<List<PendingAnswer>> findPendingAnswerByCode(String taskCode);

  @Query('SELECT * FROM PendingAnswer WHERE taskCode = :taskCode')
  Future<List<PendingAnswer>> findPendingAnswerByTaskCode(String taskCode);

  @Query('DELETE FROM PendingAnswer WHERE pCode = :taskCode')
  Future<void> deletePendingAnswerById(String taskCode);

  @insert
  Future<void> insertPendingAnswer(PendingAnswer pendingAnswer);

  @delete
  Future<void> deletePendingAnswer(PendingAnswer pendingAnswer);

  @update
  Future<void> updatePendingAnswer(PendingAnswer pendingAnswer);
}
