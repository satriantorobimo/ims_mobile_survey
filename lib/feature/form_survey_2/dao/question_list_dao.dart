import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_data_model.dart';

@dao
abstract class QuestionListDao {
  @Query('SELECT * FROM QuestionList')
  Future<List<QuestionList?>> findAllQuestionList();

  @Query('SELECT * FROM QuestionList WHERE code = :code')
  Future<QuestionList?> findQuestionListById(String code);

  @Query('SELECT * FROM QuestionList WHERE task_code = :taskCode')
  Future<List<QuestionList?>> findQuestionListByTaskCode(String taskCode);

  @Query('DELETE FROM QuestionList WHERE code = :code')
  Future<void> deleteQuestionListById(String code);

  @Query('DELETE FROM QuestionList WHERE task_code = :taskCode')
  Future<void> deleteQuestionListByCode(String taskCode);

  @Query(
      'UPDATE QuestionList SET answer = :answer IS NOT NULL AND answerChoiceId = :answerChoiceId WHERE code = :code')
  Future<void> updateQuestionListById(
      String code, String answer, int answerChoiceId);

  @insert
  Future<void> insertQuestionList(QuestionList questionList);

  @insert
  Future<void> insertAllQuestionList(List<QuestionList> questionList);

  @delete
  Future<void> deleteQuestionList(QuestionList questionList);

  @update
  Future<void> updateQuestionList(QuestionList questionList);
}
