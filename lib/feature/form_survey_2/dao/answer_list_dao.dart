import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_list_data_model.dart';

@dao
abstract class AnswerListDao {
  @Query('SELECT * FROM AnswerList')
  Future<List<AnswerList>> findAllAnswerList();

  @Query('SELECT * FROM AnswerList WHERE task_question_code = :questionCode')
  Future<AnswerList?> findAnswerListById(String questionCode);

  @Query('SELECT * FROM AnswerList WHERE task_question_code = :questionCode')
  Future<List<AnswerList>> findAnswerListByCode(String questionCode);

  @Query('DELETE FROM AnswerList WHERE task_question_code = :questionCode')
  Future<void> deleteAnswerListById(String questionCode);

  @insert
  Future<void> insertAnswerList(AnswerList answerList);

  @delete
  Future<void> deleteAnswerList(AnswerList answerList);

  @update
  Future<void> updateAnswerList(AnswerList answerList);
}
