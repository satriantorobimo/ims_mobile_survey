// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database_util.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  TaskListDao? _taskListDaoInstance;

  QuestionListDao? _questionListDaoInstance;

  AnswerListDao? _answerListDaoInstance;

  AttachmentListDao? _attachmentListDaoInstance;

  ReferenceListDao? _referenceListDaoInstance;

  PendingAttachmentDao? _pendingAttachmentDaoInstance;

  PendingAnswerDao? _pendingAnswerDaoInstance;

  PendingReferenceDao? _pendingReferenceDaoInstance;

  PendingSummaryDao? _pendingSummaryDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 31,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`id` INTEGER NOT NULL, `idpp` TEXT NOT NULL, `ucode` TEXT NOT NULL, `name` TEXT NOT NULL, `systemDate` TEXT NOT NULL, `branchCode` TEXT NOT NULL, `branchName` TEXT NOT NULL, `companyCode` TEXT NOT NULL, `companyName` TEXT NOT NULL, `deviceId` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `TaskList` (`code` TEXT NOT NULL, `date` TEXT NOT NULL, `status` TEXT NOT NULL, `remark` TEXT, `result` TEXT, `picCode` TEXT NOT NULL, `picName` TEXT NOT NULL, `branchName` TEXT NOT NULL, `agreementNo` TEXT NOT NULL, `clientName` TEXT NOT NULL, `mobileNo` TEXT NOT NULL, `location` TEXT NOT NULL, `latitude` TEXT NOT NULL, `longitude` TEXT NOT NULL, `type` TEXT NOT NULL, `appraisalAmount` REAL, `reviewRemark` TEXT, `modDate` TEXT NOT NULL, PRIMARY KEY (`code`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `QuestionList` (`code` TEXT NOT NULL, `task_code` TEXT NOT NULL, `questionCode` TEXT NOT NULL, `questionDesc` TEXT NOT NULL, `type` TEXT NOT NULL, `answer` TEXT, `answerChoiceId` INTEGER, PRIMARY KEY (`code`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AnswerList` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER NOT NULL, `task_question_code` TEXT NOT NULL, `questionOptionDesc` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AttachmentList` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `id` INTEGER NOT NULL, `taskCode` TEXT NOT NULL, `documentCode` TEXT NOT NULL, `documentName` TEXT NOT NULL, `fileName` TEXT NOT NULL, `filePath` TEXT NOT NULL, `type` TEXT NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ReferenceList` (`id` INTEGER NOT NULL, `taskCode` TEXT NOT NULL, `name` TEXT NOT NULL, `phoneArea` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `remark` TEXT NOT NULL, `value` REAL NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PendingAnswer` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `taskCode` TEXT NOT NULL, `pCode` TEXT NOT NULL, `pAnswer` TEXT, `pAnswerChoiceId` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PendingAttachment` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `pModule` TEXT, `pHeader` TEXT, `pChild` TEXT, `pId` INTEGER, `pFilePaths` INTEGER, `pFileName` TEXT, `pBase64` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PendingSummary` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `taskCode` TEXT NOT NULL, `remark` TEXT NOT NULL, `notes` TEXT, `value` REAL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `PendingReference` (`ids` INTEGER PRIMARY KEY AUTOINCREMENT, `taskCode` TEXT NOT NULL, `name` TEXT NOT NULL, `phoneArea` TEXT NOT NULL, `phoneNumber` TEXT NOT NULL, `remark` TEXT NOT NULL, `value` REAL NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  TaskListDao get taskListDao {
    return _taskListDaoInstance ??= _$TaskListDao(database, changeListener);
  }

  @override
  QuestionListDao get questionListDao {
    return _questionListDaoInstance ??=
        _$QuestionListDao(database, changeListener);
  }

  @override
  AnswerListDao get answerListDao {
    return _answerListDaoInstance ??= _$AnswerListDao(database, changeListener);
  }

  @override
  AttachmentListDao get attachmentListDao {
    return _attachmentListDaoInstance ??=
        _$AttachmentListDao(database, changeListener);
  }

  @override
  ReferenceListDao get referenceListDao {
    return _referenceListDaoInstance ??=
        _$ReferenceListDao(database, changeListener);
  }

  @override
  PendingAttachmentDao get pendingAttachmentDao {
    return _pendingAttachmentDaoInstance ??=
        _$PendingAttachmentDao(database, changeListener);
  }

  @override
  PendingAnswerDao get pendingAnswerDao {
    return _pendingAnswerDaoInstance ??=
        _$PendingAnswerDao(database, changeListener);
  }

  @override
  PendingReferenceDao get pendingReferenceDao {
    return _pendingReferenceDaoInstance ??=
        _$PendingReferenceDao(database, changeListener);
  }

  @override
  PendingSummaryDao get pendingSummaryDao {
    return _pendingSummaryDaoInstance ??=
        _$PendingSummaryDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'id': item.id,
                  'idpp': item.idpp,
                  'ucode': item.ucode,
                  'name': item.name,
                  'systemDate': item.systemDate,
                  'branchCode': item.branchCode,
                  'branchName': item.branchName,
                  'companyCode': item.companyCode,
                  'companyName': item.companyName,
                  'deviceId': item.deviceId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList('SELECT * FROM User',
        mapper: (Map<String, Object?> row) => User(
            ucode: row['ucode'] as String,
            id: row['id'] as int,
            name: row['name'] as String,
            systemDate: row['systemDate'] as String,
            branchCode: row['branchCode'] as String,
            branchName: row['branchName'] as String,
            idpp: row['idpp'] as String,
            companyCode: row['companyCode'] as String,
            companyName: row['companyName'] as String,
            deviceId: row['deviceId'] as String));
  }

  @override
  Future<User?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            ucode: row['ucode'] as String,
            id: row['id'] as int,
            name: row['name'] as String,
            systemDate: row['systemDate'] as String,
            branchCode: row['branchCode'] as String,
            branchName: row['branchName'] as String,
            idpp: row['idpp'] as String,
            companyCode: row['companyCode'] as String,
            companyName: row['companyName'] as String,
            deviceId: row['deviceId'] as String),
        arguments: [id]);
  }

  @override
  Future<void> deleteUserById(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM User WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertUser(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$TaskListDao extends TaskListDao {
  _$TaskListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _taskListInsertionAdapter = InsertionAdapter(
            database,
            'TaskList',
            (TaskList item) => <String, Object?>{
                  'code': item.code,
                  'date': item.date,
                  'status': item.status,
                  'remark': item.remark,
                  'result': item.result,
                  'picCode': item.picCode,
                  'picName': item.picName,
                  'branchName': item.branchName,
                  'agreementNo': item.agreementNo,
                  'clientName': item.clientName,
                  'mobileNo': item.mobileNo,
                  'location': item.location,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'type': item.type,
                  'appraisalAmount': item.appraisalAmount,
                  'reviewRemark': item.reviewRemark,
                  'modDate': item.modDate
                }),
        _taskListUpdateAdapter = UpdateAdapter(
            database,
            'TaskList',
            ['code'],
            (TaskList item) => <String, Object?>{
                  'code': item.code,
                  'date': item.date,
                  'status': item.status,
                  'remark': item.remark,
                  'result': item.result,
                  'picCode': item.picCode,
                  'picName': item.picName,
                  'branchName': item.branchName,
                  'agreementNo': item.agreementNo,
                  'clientName': item.clientName,
                  'mobileNo': item.mobileNo,
                  'location': item.location,
                  'latitude': item.latitude,
                  'longitude': item.longitude,
                  'type': item.type,
                  'appraisalAmount': item.appraisalAmount,
                  'reviewRemark': item.reviewRemark,
                  'modDate': item.modDate
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TaskList> _taskListInsertionAdapter;

  final UpdateAdapter<TaskList> _taskListUpdateAdapter;

  @override
  Future<List<TaskList?>> findAllTaskList() async {
    return _queryAdapter.queryList('SELECT * FROM TaskList',
        mapper: (Map<String, Object?> row) => TaskList(
            code: row['code'] as String,
            date: row['date'] as String,
            status: row['status'] as String,
            remark: row['remark'] as String?,
            result: row['result'] as String?,
            picCode: row['picCode'] as String,
            picName: row['picName'] as String,
            branchName: row['branchName'] as String,
            agreementNo: row['agreementNo'] as String,
            clientName: row['clientName'] as String,
            mobileNo: row['mobileNo'] as String,
            location: row['location'] as String,
            latitude: row['latitude'] as String,
            longitude: row['longitude'] as String,
            type: row['type'] as String,
            appraisalAmount: row['appraisalAmount'] as double?,
            reviewRemark: row['reviewRemark'] as String?,
            modDate: row['modDate'] as String));
  }

  @override
  Future<TaskList?> findTaskListById(String code) async {
    return _queryAdapter.query('SELECT * FROM TaskList WHERE code = ?1',
        mapper: (Map<String, Object?> row) => TaskList(
            code: row['code'] as String,
            date: row['date'] as String,
            status: row['status'] as String,
            remark: row['remark'] as String?,
            result: row['result'] as String?,
            picCode: row['picCode'] as String,
            picName: row['picName'] as String,
            branchName: row['branchName'] as String,
            agreementNo: row['agreementNo'] as String,
            clientName: row['clientName'] as String,
            mobileNo: row['mobileNo'] as String,
            location: row['location'] as String,
            latitude: row['latitude'] as String,
            longitude: row['longitude'] as String,
            type: row['type'] as String,
            appraisalAmount: row['appraisalAmount'] as double?,
            reviewRemark: row['reviewRemark'] as String?,
            modDate: row['modDate'] as String),
        arguments: [code]);
  }

  @override
  Future<List<TaskList?>> findTaskListByStatus(String status) async {
    return _queryAdapter.queryList('SELECT * FROM TaskList WHERE status = ?1',
        mapper: (Map<String, Object?> row) => TaskList(
            code: row['code'] as String,
            date: row['date'] as String,
            status: row['status'] as String,
            remark: row['remark'] as String?,
            result: row['result'] as String?,
            picCode: row['picCode'] as String,
            picName: row['picName'] as String,
            branchName: row['branchName'] as String,
            agreementNo: row['agreementNo'] as String,
            clientName: row['clientName'] as String,
            mobileNo: row['mobileNo'] as String,
            location: row['location'] as String,
            latitude: row['latitude'] as String,
            longitude: row['longitude'] as String,
            type: row['type'] as String,
            appraisalAmount: row['appraisalAmount'] as double?,
            reviewRemark: row['reviewRemark'] as String?,
            modDate: row['modDate'] as String),
        arguments: [status]);
  }

  @override
  Future<void> deleteTaskListById(String code) async {
    await _queryAdapter.queryNoReturn('DELETE FROM TaskList WHERE code = ?1',
        arguments: [code]);
  }

  @override
  Future<void> deleteTaskListByStatus(String status) async {
    await _queryAdapter.queryNoReturn('DELETE FROM TaskList WHERE status = ?1',
        arguments: [status]);
  }

  @override
  Future<void> updateTaskStatusById(
    String status,
    String code,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE TaskList SET status = ?1 WHERE code = ?2',
        arguments: [status, code]);
  }

  @override
  Future<void> updateTaskData(
    String status,
    String remark,
    String result,
    double appraisal,
    String code,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE TaskList SET status = ?1 AND remark = ?2 AND result = ?3 AND appraisalAmount = ?4 WHERE code = ?5',
        arguments: [status, remark, result, appraisal, code]);
  }

  @override
  Future<void> insertTaskList(TaskList user) async {
    await _taskListInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllTaskList(List<TaskList> user) async {
    await _taskListInsertionAdapter.insertList(user, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTask(TaskList user) async {
    await _taskListUpdateAdapter.update(user, OnConflictStrategy.abort);
  }
}

class _$QuestionListDao extends QuestionListDao {
  _$QuestionListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionListInsertionAdapter = InsertionAdapter(
            database,
            'QuestionList',
            (QuestionList item) => <String, Object?>{
                  'code': item.code,
                  'task_code': item.taskCode,
                  'questionCode': item.questionCode,
                  'questionDesc': item.questionDesc,
                  'type': item.type,
                  'answer': item.answer,
                  'answerChoiceId': item.answerChoiceId
                }),
        _questionListUpdateAdapter = UpdateAdapter(
            database,
            'QuestionList',
            ['code'],
            (QuestionList item) => <String, Object?>{
                  'code': item.code,
                  'task_code': item.taskCode,
                  'questionCode': item.questionCode,
                  'questionDesc': item.questionDesc,
                  'type': item.type,
                  'answer': item.answer,
                  'answerChoiceId': item.answerChoiceId
                }),
        _questionListDeletionAdapter = DeletionAdapter(
            database,
            'QuestionList',
            ['code'],
            (QuestionList item) => <String, Object?>{
                  'code': item.code,
                  'task_code': item.taskCode,
                  'questionCode': item.questionCode,
                  'questionDesc': item.questionDesc,
                  'type': item.type,
                  'answer': item.answer,
                  'answerChoiceId': item.answerChoiceId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<QuestionList> _questionListInsertionAdapter;

  final UpdateAdapter<QuestionList> _questionListUpdateAdapter;

  final DeletionAdapter<QuestionList> _questionListDeletionAdapter;

  @override
  Future<List<QuestionList?>> findAllQuestionList() async {
    return _queryAdapter.queryList('SELECT * FROM QuestionList',
        mapper: (Map<String, Object?> row) => QuestionList(
            code: row['code'] as String,
            taskCode: row['task_code'] as String,
            questionCode: row['questionCode'] as String,
            questionDesc: row['questionDesc'] as String,
            type: row['type'] as String,
            answer: row['answer'] as String?,
            answerChoiceId: row['answerChoiceId'] as int?));
  }

  @override
  Future<QuestionList?> findQuestionListById(String code) async {
    return _queryAdapter.query('SELECT * FROM QuestionList WHERE code = ?1',
        mapper: (Map<String, Object?> row) => QuestionList(
            code: row['code'] as String,
            taskCode: row['task_code'] as String,
            questionCode: row['questionCode'] as String,
            questionDesc: row['questionDesc'] as String,
            type: row['type'] as String,
            answer: row['answer'] as String?,
            answerChoiceId: row['answerChoiceId'] as int?),
        arguments: [code]);
  }

  @override
  Future<List<QuestionList?>> findQuestionListByTaskCode(
      String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM QuestionList WHERE task_code = ?1',
        mapper: (Map<String, Object?> row) => QuestionList(
            code: row['code'] as String,
            taskCode: row['task_code'] as String,
            questionCode: row['questionCode'] as String,
            questionDesc: row['questionDesc'] as String,
            type: row['type'] as String,
            answer: row['answer'] as String?,
            answerChoiceId: row['answerChoiceId'] as int?),
        arguments: [taskCode]);
  }

  @override
  Future<void> deleteQuestionListById(String code) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM QuestionList WHERE code = ?1',
        arguments: [code]);
  }

  @override
  Future<void> deleteQuestionListByCode(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM QuestionList WHERE task_code = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> updateQuestionListById(
    String code,
    String answer,
    int answerChoiceId,
  ) async {
    await _queryAdapter.queryNoReturn(
        'UPDATE QuestionList SET answer = ?2 IS NOT NULL AND answerChoiceId = ?3 WHERE code = ?1',
        arguments: [code, answer, answerChoiceId]);
  }

  @override
  Future<void> insertQuestionList(QuestionList questionList) async {
    await _questionListInsertionAdapter.insert(
        questionList, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllQuestionList(List<QuestionList> questionList) async {
    await _questionListInsertionAdapter.insertList(
        questionList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateQuestionList(QuestionList questionList) async {
    await _questionListUpdateAdapter.update(
        questionList, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteQuestionList(QuestionList questionList) async {
    await _questionListDeletionAdapter.delete(questionList);
  }
}

class _$AnswerListDao extends AnswerListDao {
  _$AnswerListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _answerListInsertionAdapter = InsertionAdapter(
            database,
            'AnswerList',
            (AnswerList item) => <String, Object?>{
                  'ids': item.ids,
                  'id': item.id,
                  'task_question_code': item.taskQuestionCode,
                  'questionOptionDesc': item.questionOptionDesc
                }),
        _answerListUpdateAdapter = UpdateAdapter(
            database,
            'AnswerList',
            ['ids'],
            (AnswerList item) => <String, Object?>{
                  'ids': item.ids,
                  'id': item.id,
                  'task_question_code': item.taskQuestionCode,
                  'questionOptionDesc': item.questionOptionDesc
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AnswerList> _answerListInsertionAdapter;

  final UpdateAdapter<AnswerList> _answerListUpdateAdapter;

  @override
  Future<List<AnswerList>> findAllAnswerList() async {
    return _queryAdapter.queryList('SELECT * FROM AnswerList',
        mapper: (Map<String, Object?> row) => AnswerList(
            ids: row['ids'] as int?,
            id: row['id'] as int,
            questionOptionDesc: row['questionOptionDesc'] as String,
            taskQuestionCode: row['task_question_code'] as String));
  }

  @override
  Future<AnswerList?> findAnswerListById(String questionCode) async {
    return _queryAdapter.query(
        'SELECT * FROM AnswerList WHERE task_question_code = ?1',
        mapper: (Map<String, Object?> row) => AnswerList(
            ids: row['ids'] as int?,
            id: row['id'] as int,
            questionOptionDesc: row['questionOptionDesc'] as String,
            taskQuestionCode: row['task_question_code'] as String),
        arguments: [questionCode]);
  }

  @override
  Future<List<AnswerList>> findAnswerListByCode(String questionCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AnswerList WHERE task_question_code = ?1',
        mapper: (Map<String, Object?> row) => AnswerList(
            ids: row['ids'] as int?,
            id: row['id'] as int,
            questionOptionDesc: row['questionOptionDesc'] as String,
            taskQuestionCode: row['task_question_code'] as String),
        arguments: [questionCode]);
  }

  @override
  Future<void> deleteAnswerListById(String questionCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM AnswerList WHERE task_question_code = ?1',
        arguments: [questionCode]);
  }

  @override
  Future<void> deleteAnswerList() async {
    await _queryAdapter.queryNoReturn('DELETE FROM AnswerList');
  }

  @override
  Future<void> insertAnswerList(AnswerList answerList) async {
    await _answerListInsertionAdapter.insert(
        answerList, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllAnswerList(List<AnswerList> answerList) async {
    await _answerListInsertionAdapter.insertList(
        answerList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAnswerList(AnswerList answerList) async {
    await _answerListUpdateAdapter.update(answerList, OnConflictStrategy.abort);
  }
}

class _$AttachmentListDao extends AttachmentListDao {
  _$AttachmentListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _attachmentListInsertionAdapter = InsertionAdapter(
            database,
            'AttachmentList',
            (AttachmentList item) => <String, Object?>{
                  'ids': item.ids,
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'documentCode': item.documentCode,
                  'documentName': item.documentName,
                  'fileName': item.fileName,
                  'filePath': item.filePath,
                  'type': item.type
                }),
        _attachmentListUpdateAdapter = UpdateAdapter(
            database,
            'AttachmentList',
            ['ids'],
            (AttachmentList item) => <String, Object?>{
                  'ids': item.ids,
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'documentCode': item.documentCode,
                  'documentName': item.documentName,
                  'fileName': item.fileName,
                  'filePath': item.filePath,
                  'type': item.type
                }),
        _attachmentListDeletionAdapter = DeletionAdapter(
            database,
            'AttachmentList',
            ['ids'],
            (AttachmentList item) => <String, Object?>{
                  'ids': item.ids,
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'documentCode': item.documentCode,
                  'documentName': item.documentName,
                  'fileName': item.fileName,
                  'filePath': item.filePath,
                  'type': item.type
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AttachmentList> _attachmentListInsertionAdapter;

  final UpdateAdapter<AttachmentList> _attachmentListUpdateAdapter;

  final DeletionAdapter<AttachmentList> _attachmentListDeletionAdapter;

  @override
  Future<List<AttachmentList>> findAllAttachmentList() async {
    return _queryAdapter.queryList('SELECT * FROM AttachmentList',
        mapper: (Map<String, Object?> row) => AttachmentList(
            id: row['id'] as int,
            taskCode: row['taskCode'] as String,
            documentCode: row['documentCode'] as String,
            documentName: row['documentName'] as String,
            type: row['type'] as String,
            fileName: row['fileName'] as String,
            filePath: row['filePath'] as String));
  }

  @override
  Future<AttachmentList?> findAttachmentListById(
    String documentCode,
    String taskCode,
  ) async {
    return _queryAdapter.query(
        'SELECT * FROM AttachmentList WHERE documentCode = ?1 and taskCode = ?2',
        mapper: (Map<String, Object?> row) => AttachmentList(id: row['id'] as int, taskCode: row['taskCode'] as String, documentCode: row['documentCode'] as String, documentName: row['documentName'] as String, type: row['type'] as String, fileName: row['fileName'] as String, filePath: row['filePath'] as String),
        arguments: [documentCode, taskCode]);
  }

  @override
  Future<List<AttachmentList>> findAttachmentListByCode(String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM AttachmentList WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => AttachmentList(
            id: row['id'] as int,
            taskCode: row['taskCode'] as String,
            documentCode: row['documentCode'] as String,
            documentName: row['documentName'] as String,
            type: row['type'] as String,
            fileName: row['fileName'] as String,
            filePath: row['filePath'] as String),
        arguments: [taskCode]);
  }

  @override
  Future<void> deleteAttachmentListById(
    String documentCode,
    String taskCode,
  ) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM AttachmentList WHERE documentCode = ?1 and taskCode = ?2',
        arguments: [documentCode, taskCode]);
  }

  @override
  Future<void> deleteAttachmentListByCode(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM AttachmentList WHERE taskCode = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertAttachmentList(AttachmentList answerList) async {
    await _attachmentListInsertionAdapter.insert(
        answerList, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllAttachmentList(List<AttachmentList> answerList) async {
    await _attachmentListInsertionAdapter.insertList(
        answerList, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAttachmentList(AttachmentList answerList) async {
    await _attachmentListUpdateAdapter.update(
        answerList, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteAttachmentList(AttachmentList answerList) async {
    await _attachmentListDeletionAdapter.delete(answerList);
  }
}

class _$ReferenceListDao extends ReferenceListDao {
  _$ReferenceListDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _referenceListInsertionAdapter = InsertionAdapter(
            database,
            'ReferenceList',
            (ReferenceList item) => <String, Object?>{
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                }),
        _referenceListUpdateAdapter = UpdateAdapter(
            database,
            'ReferenceList',
            ['id'],
            (ReferenceList item) => <String, Object?>{
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                }),
        _referenceListDeletionAdapter = DeletionAdapter(
            database,
            'ReferenceList',
            ['id'],
            (ReferenceList item) => <String, Object?>{
                  'id': item.id,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ReferenceList> _referenceListInsertionAdapter;

  final UpdateAdapter<ReferenceList> _referenceListUpdateAdapter;

  final DeletionAdapter<ReferenceList> _referenceListDeletionAdapter;

  @override
  Future<List<ReferenceList>> findAllRefrence() async {
    return _queryAdapter.queryList('SELECT * FROM ReferenceList',
        mapper: (Map<String, Object?> row) => ReferenceList(
            id: row['id'] as int,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double));
  }

  @override
  Future<ReferenceList?> findRefrenceById(String taskCode) async {
    return _queryAdapter.query(
        'SELECT * FROM ReferenceList WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => ReferenceList(
            id: row['id'] as int,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double),
        arguments: [taskCode]);
  }

  @override
  Future<List<ReferenceList>> findRefrenceByCode(String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM ReferenceList WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => ReferenceList(
            id: row['id'] as int,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double),
        arguments: [taskCode]);
  }

  @override
  Future<void> deleteRefrenceById(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM ReferenceList WHERE taskCode = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertRefrence(ReferenceList reference) async {
    await _referenceListInsertionAdapter.insert(
        reference, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertAllRefrence(List<ReferenceList> reference) async {
    await _referenceListInsertionAdapter.insertList(
        reference, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRefrence(ReferenceList reference) async {
    await _referenceListUpdateAdapter.update(
        reference, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteRefrence(ReferenceList reference) async {
    await _referenceListDeletionAdapter.delete(reference);
  }
}

class _$PendingAttachmentDao extends PendingAttachmentDao {
  _$PendingAttachmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pendingAttachmentInsertionAdapter = InsertionAdapter(
            database,
            'PendingAttachment',
            (PendingAttachment item) => <String, Object?>{
                  'ids': item.ids,
                  'pModule': item.pModule,
                  'pHeader': item.pHeader,
                  'pChild': item.pChild,
                  'pId': item.pId,
                  'pFilePaths': item.pFilePaths,
                  'pFileName': item.pFileName,
                  'pBase64': item.pBase64
                }),
        _pendingAttachmentUpdateAdapter = UpdateAdapter(
            database,
            'PendingAttachment',
            ['ids'],
            (PendingAttachment item) => <String, Object?>{
                  'ids': item.ids,
                  'pModule': item.pModule,
                  'pHeader': item.pHeader,
                  'pChild': item.pChild,
                  'pId': item.pId,
                  'pFilePaths': item.pFilePaths,
                  'pFileName': item.pFileName,
                  'pBase64': item.pBase64
                }),
        _pendingAttachmentDeletionAdapter = DeletionAdapter(
            database,
            'PendingAttachment',
            ['ids'],
            (PendingAttachment item) => <String, Object?>{
                  'ids': item.ids,
                  'pModule': item.pModule,
                  'pHeader': item.pHeader,
                  'pChild': item.pChild,
                  'pId': item.pId,
                  'pFilePaths': item.pFilePaths,
                  'pFileName': item.pFileName,
                  'pBase64': item.pBase64
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PendingAttachment> _pendingAttachmentInsertionAdapter;

  final UpdateAdapter<PendingAttachment> _pendingAttachmentUpdateAdapter;

  final DeletionAdapter<PendingAttachment> _pendingAttachmentDeletionAdapter;

  @override
  Future<List<PendingAttachment>> findAllPendingAttachment() async {
    return _queryAdapter.queryList('SELECT * FROM PendingAttachment',
        mapper: (Map<String, Object?> row) => PendingAttachment(
            ids: row['ids'] as int?,
            pModule: row['pModule'] as String?,
            pHeader: row['pHeader'] as String?,
            pChild: row['pChild'] as String?,
            pId: row['pId'] as int?,
            pFilePaths: row['pFilePaths'] as int?,
            pFileName: row['pFileName'] as String?,
            pBase64: row['pBase64'] as String?));
  }

  @override
  Future<PendingAttachment?> findPendingAttachmentById(String taskCode) async {
    return _queryAdapter.query(
        'SELECT * FROM PendingAttachment WHERE pChild = ?1',
        mapper: (Map<String, Object?> row) => PendingAttachment(
            ids: row['ids'] as int?,
            pModule: row['pModule'] as String?,
            pHeader: row['pHeader'] as String?,
            pChild: row['pChild'] as String?,
            pId: row['pId'] as int?,
            pFilePaths: row['pFilePaths'] as int?,
            pFileName: row['pFileName'] as String?,
            pBase64: row['pBase64'] as String?),
        arguments: [taskCode]);
  }

  @override
  Future<List<PendingAttachment>> findPendingAttachmentByCode(
      String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PendingAttachment WHERE pChild = ?1',
        mapper: (Map<String, Object?> row) => PendingAttachment(
            ids: row['ids'] as int?,
            pModule: row['pModule'] as String?,
            pHeader: row['pHeader'] as String?,
            pChild: row['pChild'] as String?,
            pId: row['pId'] as int?,
            pFilePaths: row['pFilePaths'] as int?,
            pFileName: row['pFileName'] as String?,
            pBase64: row['pBase64'] as String?),
        arguments: [taskCode]);
  }

  @override
  Future<void> deletePendingAttachmentById(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PendingAttachment WHERE pChild = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertPendingAttachment(
      PendingAttachment pendingAttachment) async {
    await _pendingAttachmentInsertionAdapter.insert(
        pendingAttachment, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePendingAttachment(
      PendingAttachment pendingAttachment) async {
    await _pendingAttachmentUpdateAdapter.update(
        pendingAttachment, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePendingAttachment(
      PendingAttachment pendingAttachment) async {
    await _pendingAttachmentDeletionAdapter.delete(pendingAttachment);
  }
}

class _$PendingAnswerDao extends PendingAnswerDao {
  _$PendingAnswerDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pendingAnswerInsertionAdapter = InsertionAdapter(
            database,
            'PendingAnswer',
            (PendingAnswer item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'pCode': item.pCode,
                  'pAnswer': item.pAnswer,
                  'pAnswerChoiceId': item.pAnswerChoiceId
                }),
        _pendingAnswerUpdateAdapter = UpdateAdapter(
            database,
            'PendingAnswer',
            ['ids'],
            (PendingAnswer item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'pCode': item.pCode,
                  'pAnswer': item.pAnswer,
                  'pAnswerChoiceId': item.pAnswerChoiceId
                }),
        _pendingAnswerDeletionAdapter = DeletionAdapter(
            database,
            'PendingAnswer',
            ['ids'],
            (PendingAnswer item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'pCode': item.pCode,
                  'pAnswer': item.pAnswer,
                  'pAnswerChoiceId': item.pAnswerChoiceId
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PendingAnswer> _pendingAnswerInsertionAdapter;

  final UpdateAdapter<PendingAnswer> _pendingAnswerUpdateAdapter;

  final DeletionAdapter<PendingAnswer> _pendingAnswerDeletionAdapter;

  @override
  Future<List<PendingAnswer>> findAllPendingAnswer() async {
    return _queryAdapter.queryList('SELECT * FROM PendingAnswer',
        mapper: (Map<String, Object?> row) => PendingAnswer(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            pCode: row['pCode'] as String,
            pAnswer: row['pAnswer'] as String?,
            pAnswerChoiceId: row['pAnswerChoiceId'] as int?));
  }

  @override
  Future<PendingAnswer?> findPendingAnswerById(String taskCode) async {
    return _queryAdapter.query('SELECT * FROM PendingAnswer WHERE pCode = ?1',
        mapper: (Map<String, Object?> row) => PendingAnswer(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            pCode: row['pCode'] as String,
            pAnswer: row['pAnswer'] as String?,
            pAnswerChoiceId: row['pAnswerChoiceId'] as int?),
        arguments: [taskCode]);
  }

  @override
  Future<List<PendingAnswer>> findPendingAnswerByCode(String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PendingAnswer WHERE pCode = ?1',
        mapper: (Map<String, Object?> row) => PendingAnswer(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            pCode: row['pCode'] as String,
            pAnswer: row['pAnswer'] as String?,
            pAnswerChoiceId: row['pAnswerChoiceId'] as int?),
        arguments: [taskCode]);
  }

  @override
  Future<List<PendingAnswer>> findPendingAnswerByTaskCode(
      String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PendingAnswer WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => PendingAnswer(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            pCode: row['pCode'] as String,
            pAnswer: row['pAnswer'] as String?,
            pAnswerChoiceId: row['pAnswerChoiceId'] as int?),
        arguments: [taskCode]);
  }

  @override
  Future<void> deletePendingAnswerById(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PendingAnswer WHERE pCode = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertPendingAnswer(PendingAnswer pendingAnswer) async {
    await _pendingAnswerInsertionAdapter.insert(
        pendingAnswer, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePendingAnswer(PendingAnswer pendingAnswer) async {
    await _pendingAnswerUpdateAdapter.update(
        pendingAnswer, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePendingAnswer(PendingAnswer pendingAnswer) async {
    await _pendingAnswerDeletionAdapter.delete(pendingAnswer);
  }
}

class _$PendingReferenceDao extends PendingReferenceDao {
  _$PendingReferenceDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pendingReferenceInsertionAdapter = InsertionAdapter(
            database,
            'PendingReference',
            (PendingReference item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                }),
        _pendingReferenceUpdateAdapter = UpdateAdapter(
            database,
            'PendingReference',
            ['ids'],
            (PendingReference item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                }),
        _pendingReferenceDeletionAdapter = DeletionAdapter(
            database,
            'PendingReference',
            ['ids'],
            (PendingReference item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'name': item.name,
                  'phoneArea': item.phoneArea,
                  'phoneNumber': item.phoneNumber,
                  'remark': item.remark,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PendingReference> _pendingReferenceInsertionAdapter;

  final UpdateAdapter<PendingReference> _pendingReferenceUpdateAdapter;

  final DeletionAdapter<PendingReference> _pendingReferenceDeletionAdapter;

  @override
  Future<List<PendingReference>> findAllPendingRefrence() async {
    return _queryAdapter.queryList('SELECT * FROM PendingReference',
        mapper: (Map<String, Object?> row) => PendingReference(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double));
  }

  @override
  Future<PendingReference?> findPendingRefrenceById(String taskCode) async {
    return _queryAdapter.query(
        'SELECT * FROM PendingReference WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => PendingReference(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double),
        arguments: [taskCode]);
  }

  @override
  Future<List<PendingReference>> findPendingRefrenceByCode(
      String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PendingReference WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => PendingReference(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            name: row['name'] as String,
            phoneArea: row['phoneArea'] as String,
            phoneNumber: row['phoneNumber'] as String,
            remark: row['remark'] as String,
            value: row['value'] as double),
        arguments: [taskCode]);
  }

  @override
  Future<void> deletePendingRefrenceById(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PendingReference WHERE taskCode = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertPendingRefrence(PendingReference pendingReference) async {
    await _pendingReferenceInsertionAdapter.insert(
        pendingReference, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePendingRefrence(PendingReference pendingReference) async {
    await _pendingReferenceUpdateAdapter.update(
        pendingReference, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePendingRefrence(PendingReference pendingReference) async {
    await _pendingReferenceDeletionAdapter.delete(pendingReference);
  }
}

class _$PendingSummaryDao extends PendingSummaryDao {
  _$PendingSummaryDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _pendingSummaryInsertionAdapter = InsertionAdapter(
            database,
            'PendingSummary',
            (PendingSummary item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'remark': item.remark,
                  'notes': item.notes,
                  'value': item.value
                }),
        _pendingSummaryUpdateAdapter = UpdateAdapter(
            database,
            'PendingSummary',
            ['ids'],
            (PendingSummary item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'remark': item.remark,
                  'notes': item.notes,
                  'value': item.value
                }),
        _pendingSummaryDeletionAdapter = DeletionAdapter(
            database,
            'PendingSummary',
            ['ids'],
            (PendingSummary item) => <String, Object?>{
                  'ids': item.ids,
                  'taskCode': item.taskCode,
                  'remark': item.remark,
                  'notes': item.notes,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PendingSummary> _pendingSummaryInsertionAdapter;

  final UpdateAdapter<PendingSummary> _pendingSummaryUpdateAdapter;

  final DeletionAdapter<PendingSummary> _pendingSummaryDeletionAdapter;

  @override
  Future<List<PendingSummary>> findAllPendingSummary() async {
    return _queryAdapter.queryList('SELECT * FROM PendingSummary',
        mapper: (Map<String, Object?> row) => PendingSummary(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            remark: row['remark'] as String,
            notes: row['notes'] as String?,
            value: row['value'] as double?));
  }

  @override
  Future<PendingSummary?> findPendingSummaryById(String taskCode) async {
    return _queryAdapter.query(
        'SELECT * FROM PendingSummary WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => PendingSummary(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            remark: row['remark'] as String,
            notes: row['notes'] as String?,
            value: row['value'] as double?),
        arguments: [taskCode]);
  }

  @override
  Future<List<PendingSummary>> findPendingSummaryByCode(String taskCode) async {
    return _queryAdapter.queryList(
        'SELECT * FROM PendingSummary WHERE taskCode = ?1',
        mapper: (Map<String, Object?> row) => PendingSummary(
            ids: row['ids'] as int?,
            taskCode: row['taskCode'] as String,
            remark: row['remark'] as String,
            notes: row['notes'] as String?,
            value: row['value'] as double?),
        arguments: [taskCode]);
  }

  @override
  Future<void> deletePendingSummaryById(String taskCode) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM PendingSummary WHERE taskCode = ?1',
        arguments: [taskCode]);
  }

  @override
  Future<void> insertPendingSummary(PendingSummary pendingSummary) async {
    await _pendingSummaryInsertionAdapter.insert(
        pendingSummary, OnConflictStrategy.abort);
  }

  @override
  Future<void> updatePendingSummary(PendingSummary pendingSummary) async {
    await _pendingSummaryUpdateAdapter.update(
        pendingSummary, OnConflictStrategy.abort);
  }

  @override
  Future<void> deletePendingSummary(PendingSummary pendingSummary) async {
    await _pendingSummaryDeletionAdapter.delete(pendingSummary);
  }
}
