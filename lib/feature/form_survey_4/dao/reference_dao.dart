import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_4/data/reference_list_model.dart';

@dao
abstract class ReferenceListDao {
  @Query('SELECT * FROM ReferenceList')
  Future<List<ReferenceList>> findAllRefrence();

  @Query('SELECT * FROM ReferenceList WHERE taskCode = :taskCode')
  Future<ReferenceList?> findRefrenceById(String taskCode);

  @Query('SELECT * FROM ReferenceList WHERE taskCode = :taskCode')
  Future<List<ReferenceList>> findRefrenceByCode(String taskCode);

  @Query('DELETE FROM ReferenceList WHERE taskCode = :taskCode')
  Future<void> deleteRefrenceById(String taskCode);

  @insert
  Future<void> insertRefrence(ReferenceList reference);

  @insert
  Future<void> insertAllRefrence(List<ReferenceList> reference);

  @delete
  Future<void> deleteRefrence(ReferenceList reference);

  @update
  Future<void> updateRefrence(ReferenceList reference);
}
