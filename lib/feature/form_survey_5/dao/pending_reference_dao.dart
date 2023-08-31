import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_reference_data_mode.dart';

@dao
abstract class PendingReferenceDao {
  @Query('SELECT * FROM PendingReference')
  Future<List<PendingReference>> findAllPendingRefrence();

  @Query('SELECT * FROM PendingReference WHERE taskCode = :taskCode')
  Future<PendingReference?> findPendingRefrenceById(String taskCode);

  @Query('SELECT * FROM PendingReference WHERE taskCode = :taskCode')
  Future<List<PendingReference>> findPendingRefrenceByCode(String taskCode);

  @Query('DELETE FROM PendingReference WHERE taskCode = :taskCode')
  Future<void> deletePendingRefrenceById(String taskCode);

  @insert
  Future<void> insertPendingRefrence(PendingReference pendingReference);

  @delete
  Future<void> deletePendingRefrence(PendingReference pendingReference);

  @update
  Future<void> updatePendingRefrence(PendingReference pendingReference);
}
