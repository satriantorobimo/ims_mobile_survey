import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_attachment_data_model.dart';

@dao
abstract class PendingAttachmentDao {
  @Query('SELECT * FROM PendingAttachment')
  Future<List<PendingAttachment>> findAllPendingAttachment();

  @Query('SELECT * FROM PendingAttachment WHERE pChild = :taskCode')
  Future<PendingAttachment?> findPendingAttachmentById(String taskCode);

  @Query('SELECT * FROM PendingAttachment WHERE pChild = :taskCode')
  Future<List<PendingAttachment>> findPendingAttachmentByCode(String taskCode);

  @Query('DELETE FROM PendingAttachment WHERE pChild = :taskCode')
  Future<void> deletePendingAttachmentById(String taskCode);

  @insert
  Future<void> insertPendingAttachment(PendingAttachment pendingAttachment);

  @delete
  Future<void> deletePendingAttachment(PendingAttachment pendingAttachment);

  @update
  Future<void> updatePendingAttachment(PendingAttachment pendingAttachment);
}
