import 'dart:developer' as dev;
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart'
    as qst;
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart'
    as atc;
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';
import 'package:mobile_survey/feature/form_survey_4/data/reference_list_response_model.dart'
    as ref;
import 'package:mobile_survey/feature/login/data/login_response_model.dart'
    as login;
import 'package:mobile_survey/feature/relogin/data/login_response_model.dart'
    as relogin;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Future<void> createTables(sql.Database database) async {
    await database.execute("""CREATE TABLE task(
        code TEXT PRIMARY KEY,
        date TEXT,
        status TEXT,
        remark TEXT,
        result TEXT,
        pic_code TEXT,
        pic_name TEXT,
        branch_name TEXT,
        agreement_no TEXT,
        client_name TEXT,
        mobile_no TEXT,
        location TEXT,
        latitude TEXT,
        longitude TEXT,
        type TEXT,
        appraisal_amount DOUBLE,
        review_remark TEXT,
        mod_date TEXT
      )
      """);

    await database.execute("""CREATE TABLE question(
        code TEXT PRIMARY KEY,
        task_code TEXT,
        question_code TEXT,
        question_desc TEXT,
        type TEXT,
        answer TEXT,
        answer_choice_id INTEGER
      )
      """);

    await database.execute("""CREATE TABLE answer(
        id INTEGER PRIMARY KEY,
        question_code TEXT,
        question_option_desc TEXT,
        task_question_code TEXT
      )
      """);

    await database.execute("""CREATE TABLE attachment(
        id INTEGER PRIMARY KEY,
        task_code TEXT,
        document_code TEXT,
        document_name TEXT,
        file_name TEXT,
        file_path TEXT,
        type TEXT,
        is_required TEXT
      )
      """);

    await database.execute("""CREATE TABLE reference(
        id INTEGER PRIMARY KEY,
        task_code TEXT,
        area_phone_no TEXT,
        phone_no TEXT,
        remark TEXT,
        name TEXT,
        value DOUBLE
      )
      """);

    await database.execute("""CREATE TABLE user(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        ucode TEXT,
        name TEXT,
        system_date TEXT,
        branch_code TEXT,
        branch_name TEXT,
        idpp TEXT,
        company_code TEXT,
        company_name TEXT,
        device_id TEXT
      )
      """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'movilesurvey2.db',
      version: 3,
      onCreate: (sql.Database database, int version) async {
        await createTables(database);
      },
    );
  }

  // Insert task
  static Future<void> insertTask(List<Data> data) async {
    try {
      final db = await DatabaseHelper.db();
      Batch batch = db.batch();
      for (var val in data) {
        batch.insert('task', val.toMap(),
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Insert question
  static Future<void> insertQuestion(List<qst.Data> data) async {
    try {
      final db = await DatabaseHelper.db();

      Batch batch = db.batch();
      for (int i = 0; i < data.length; i++) {
        qst.DataWithoutAnswer datas = qst.DataWithoutAnswer(
            answer: data[i].answer,
            answerChoiceId: data[i].answerChoiceId,
            code: data[i].code,
            questionCode: data[i].questionCode,
            questionDesc: data[i].questionDesc,
            taskCode: data[i].taskCode,
            type: data[i].type);
        batch.insert('question', datas.toMap(),
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
        if (data[i].answerChoice!.isNotEmpty) {
          for (int j = 0; j < data[i].answerChoice!.length; j++) {
            qst.AnswerChoice datas = qst.AnswerChoice(
                id: data[i].answerChoice![j].id,
                questionCode: data[i].answerChoice![j].questionCode,
                questionOptionDesc: data[i].answerChoice![j].questionOptionDesc,
                taskQuestionCode: data[i].code);
            batch.insert('answer', datas.toMap(),
                conflictAlgorithm: sql.ConflictAlgorithm.replace);
          }
        }
        if (i == data.length - 1) {
          batch.commit();
          await db.close();
        }
      }
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Insert attachment
  static Future<void> insertAttachment(List<atc.Data> data) async {
    try {
      final db = await DatabaseHelper.db();

      Batch batch = db.batch();
      for (var val in data) {
        batch.insert('attachment', val.toMap(),
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Insert reference
  static Future<void> insertReference(List<ref.Data> data) async {
    try {
      final db = await DatabaseHelper.db();

      Batch batch = db.batch();
      for (var val in data) {
        batch.insert('reference', val.toMap(),
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Insert user
  static Future<void> insertUser(login.Datalist datalist) async {
    try {
      final db = await DatabaseHelper.db();

      await db.insert('user', datalist.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Insert user
  static Future<void> insertUserRelog(relogin.Datalist datalist) async {
    try {
      final db = await DatabaseHelper.db();

      await db.insert('user', datalist.toMap(),
          conflictAlgorithm: sql.ConflictAlgorithm.replace);
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // User Data by ID
  static Future<List<Map<String, dynamic>>> getUserData(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('user', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Read all tasks
  static Future<List<Data>> getTask() async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps = await db.query('task');
    await db.close();
    return List.generate(maps.length, (i) {
      return Data.fromMap(maps[i]);
    });
  }

  // Read single tasks
  static Future<List<Map<String, dynamic>>> getSingleTask(String code) async {
    final db = await DatabaseHelper.db();
    return db.query('task', where: "code = ?", whereArgs: [code]);
  }

  // Read all tasks
  static Future<List<Data>> getTaskPending() async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps =
        await db.query('task', where: "status = ?", whereArgs: ['PENDING']);
    await db.close();
    return List.generate(maps.length, (i) {
      return Data.fromMap(maps[i]);
    });
  }

  // User Data by ID
  static Future<List<Map<String, dynamic>>> getTaskPendingSingle(
      String taskcode) async {
    final db = await DatabaseHelper.db();
    return db.query('task', where: "code = ?", whereArgs: ['taskcode']);
  }

  // Read all tasks
  static Future<List<qst.DataWithoutAnswer>> getQuestion(
      String taskCode) async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps = await db
        .query('question', where: "task_code = ?", whereArgs: [taskCode]);
    await db.close();
    return List.generate(maps.length, (i) {
      return qst.DataWithoutAnswer.fromMap(maps[i]);
    });
  }

  // Read all tasks
  static Future<List<qst.AnswerChoice>> getAnswer(
      String taskQuestionCode) async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps = await db.query('answer',
        where: "question_code = ?", whereArgs: [taskQuestionCode]);
    await db.close();
    return List.generate(maps.length, (i) {
      return qst.AnswerChoice.fromMap(maps[i]);
    });
  }

  // Read all attachment
  static Future<List<atc.Data>> getAttachment(String taskCode) async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps = await db
        .query('attachment', where: "task_code = ?", whereArgs: [taskCode]);
    await db.close();
    return List.generate(maps.length, (i) {
      return atc.Data.fromMap(maps[i]);
    });
  }

  // Read all attachment
  static Future<List<ref.Data>> getReference(String taskCode) async {
    final db = await DatabaseHelper.db();
    List<Map<String, dynamic>> maps = await db
        .query('reference', where: "task_code = ?", whereArgs: [taskCode]);
    await db.close();
    return List.generate(maps.length, (i) {
      return ref.Data.fromMap(maps[i]);
    });
  }

  // Get a single item by id
  //We dont use this method, it is for you if you want it.
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await DatabaseHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  // Update an item by id
  static Future<int> updateItem(
      int id, String title, String? descrption) async {
    final db = await DatabaseHelper.db();

    final data = {
      'title': title,
      'description': descrption,
      'createdAt': DateTime.now().toString()
    };

    final result =
        await db.update('items', data, where: "id = ?", whereArgs: [id]);
    await db.close();
    return result;
  }

  // Update an task by id
  static Future<void> updateTask(
      {String? taskCode,
      String? remark,
      String? notes,
      double? value,
      String? status,
      String? date}) async {
    final db = await DatabaseHelper.db();

    await db.rawUpdate(
        'UPDATE task SET remark = ?, result = ?, appraisal_amount = ?, status = ?, date = ?   WHERE code = ?',
        [remark, notes, value, status, date, taskCode]);
    await db.close();
  }

  // Update an task by id
  static Future<void> updateTaskDone({String? taskCode, String? status}) async {
    final db = await DatabaseHelper.db();

    await db.rawUpdate(
        'UPDATE task SET status = ?   WHERE code = ?', [status, taskCode]);
    await db.close();
  }

  // Update an task by id
  static Future<void> updateQuestion(List<AnswerResultsModel> results) async {
    try {
      final db = await DatabaseHelper.db();

      Batch batch = db.batch();
      for (var val in results) {
        batch.rawUpdate(
            'UPDATE question SET answer = ?, answer_choice_id = ?  WHERE code = ?',
            [val.pAnswer, val.pAnswerChoiceId, val.pCode]);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Update an attachment by id
  static Future<void> updateAttachment(
      List<UploadAttachmentModel> results) async {
    try {
      final db = await DatabaseHelper.db();

      Batch batch = db.batch();
      for (var val in results) {
        batch.rawUpdate(
            'UPDATE attachment SET file_path = ?, file_name = ?  WHERE task_code = ? AND id = ?',
            [val.imagePath, val.pFileName, val.pChild, val.pId]);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Update an reference by id
  static Future<void> updateRefrence(List<HubunganModel> results) async {
    try {
      final db = await DatabaseHelper.db();
      int max = 100;
      Batch batch = db.batch();
      for (var val in results) {
        ref.Data datas = ref.Data(
            areaPhoneNo: val.phoneArea,
            name: val.name,
            phoneNo: val.phoneNumber,
            remark: val.remark,
            taskCode: val.taskCode,
            value: val.value,
            id: Random().nextInt(max));
        batch.insert('reference', datas.toMap(),
            conflictAlgorithm: sql.ConflictAlgorithm.replace);
      }
      batch.commit();
      await db.close();
    } catch (e) {
      dev.log('Error $e');
    }
  }

  // Delete
  static Future<void> deleteItem(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("items", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete
  static Future<void> deleteUser(int id) async {
    final db = await DatabaseHelper.db();
    try {
      await db.delete("user", where: "id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }

  // Delete
  static Future<void> deleteDataHome() async {
    final db = await DatabaseHelper.db();
    Batch batch = db.batch();
    String status = "PENDING";
    try {
      List<Map<String, dynamic>> maps =
          await db.query('task', where: "status != ?", whereArgs: [status]);
      for (var element in maps) {
        List<Map<String, dynamic>> mapsQuestion = await db.query('question',
            where: "task_code = ?", whereArgs: [element['code']]);

        for (var elementQuestion in mapsQuestion) {
          batch.delete('answer',
              where: "question_code = ?",
              whereArgs: [elementQuestion['question_code']]);
        }
        batch.delete('question',
            where: "task_code = ?", whereArgs: [element['code']]);
        batch.delete('attachment',
            where: "task_code = ?", whereArgs: [element['code']]);
        batch.delete('reference',
            where: "task_code = ?", whereArgs: [element['code']]);
      }

      batch.commit();
      await db.close();
    } catch (err) {
      debugPrint("Something went wrong when deleting an item: $err");
    }
  }
}
