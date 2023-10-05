import 'dart:async';
import 'package:floor/floor.dart';
import 'package:mobile_survey/feature/assignment/dao/task_list_dao.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/dao/answer_list_dao.dart';
import 'package:mobile_survey/feature/form_survey_2/dao/question_list_dao.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/dao/attachment_list_dao.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_4/dao/reference_dao.dart';
import 'package:mobile_survey/feature/form_survey_4/data/reference_list_model.dart';
import 'package:mobile_survey/feature/form_survey_5/dao/pending_answer_dao.dart';
import 'package:mobile_survey/feature/form_survey_5/dao/pending_attachment_dao.dart';
import 'package:mobile_survey/feature/form_survey_5/dao/pending_reference_dao.dart';
import 'package:mobile_survey/feature/form_survey_5/dao/pending_summary_dao.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_answer_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_attachment_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_reference_data_mode.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_summary_data_model.dart';
import 'package:mobile_survey/feature/login/dao/user_data_dao.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database_util.g.dart';

@Database(version: 31, entities: [
  User,
  TaskList,
  QuestionList,
  AnswerList,
  AttachmentList,
  ReferenceList,
  PendingAnswer,
  PendingAttachment,
  PendingSummary,
  PendingReference
])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;
  TaskListDao get taskListDao;
  QuestionListDao get questionListDao;
  AnswerListDao get answerListDao;
  AttachmentListDao get attachmentListDao;
  ReferenceListDao get referenceListDao;
  PendingAttachmentDao get pendingAttachmentDao;
  PendingAnswerDao get pendingAnswerDao;
  PendingReferenceDao get pendingReferenceDao;
  PendingSummaryDao get pendingSummaryDao;
}
