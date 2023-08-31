import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_data_model.dart';

@dao
abstract class AttachmentListDao {
  @Query('SELECT * FROM AttachmentList')
  Future<List<AttachmentList>> findAllAttachmentList();

  @Query(
      'SELECT * FROM AttachmentList WHERE documentCode = :documentCode and taskCode = :taskCode')
  Future<AttachmentList?> findAttachmentListById(
      String documentCode, String taskCode);

  @Query('SELECT * FROM AttachmentList WHERE taskCode = :taskCode')
  Future<List<AttachmentList>> findAttachmentListByCode(String taskCode);

  @Query(
      'DELETE FROM AttachmentList WHERE documentCode = :documentCode and taskCode = :taskCode')
  Future<void> deleteAttachmentListById(String documentCode, String taskCode);

  @insert
  Future<void> insertAttachmentList(AttachmentList answerList);

  @delete
  Future<void> deleteAttachmentList(AttachmentList answerList);

  @update
  Future<void> updateAttachmentList(AttachmentList answerList);
}
