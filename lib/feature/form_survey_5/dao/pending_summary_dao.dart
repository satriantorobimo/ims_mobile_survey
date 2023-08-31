import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_summary_data_model.dart';

@dao
abstract class PendingSummaryDao {
  @Query('SELECT * FROM PendingSummary')
  Future<List<PendingSummary>> findAllPendingSummary();

  @Query('SELECT * FROM PendingSummary WHERE taskCode = :taskCode')
  Future<PendingSummary?> findPendingSummaryById(String taskCode);

  @Query('SELECT * FROM PendingSummary WHERE taskCode = :taskCode')
  Future<List<PendingSummary>> findPendingSummaryByCode(String taskCode);

  @Query('DELETE FROM PendingSummary WHERE taskCode = :taskCode')
  Future<void> deletePendingSummaryById(String taskCode);

  @insert
  Future<void> insertPendingSummary(PendingSummary pendingSummary);

  @delete
  Future<void> deletePendingSummary(PendingSummary pendingSummary);

  @update
  Future<void> updatePendingSummary(PendingSummary pendingSummary);
}
