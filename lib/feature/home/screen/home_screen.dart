import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_comp.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/assignment/bloc/task_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_2/bloc/question_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/repo/question_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart'
    as qst;
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart'
    as atc;
import 'package:mobile_survey/feature/form_survey_4/data/reference_list_model.dart';

import 'package:mobile_survey/feature/form_survey_4/data/reference_list_response_model.dart'
    as rfr;
import 'package:mobile_survey/feature/form_survey_3/bloc/attachment_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_4/bloc/reference_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/repo/reference_repo.dart';
import 'package:mobile_survey/feature/home/widget/header_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/main_content_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/user_info_home_widget.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/network_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  AnimationController? animationController;
  TaskListBloc taskListBloc = TaskListBloc(taskListRepo: TaskListRepo());
  AttachmentListBloc attachmentListBloc =
      AttachmentListBloc(attachmentListRepo: AttachmentListRepo());
  QuestionListBloc questionListBloc =
      QuestionListBloc(questionListRepo: QuestionListRepo());
  ReferenceListBloc referencelistBloc =
      ReferenceListBloc(referenceRepo: ReferenceRepo());

  List<Data> taskListData = [];
  List<Data> taskListDataWaiting = [];
  late User userData;
  bool isLoading = true,
      isLoadingListData = true,
      isExpired = false,
      isFirstTime = true;
  int ongoing = 0;
  int returned = 0;
  int done = 0;
  int countQuestion = 0, countAttachment = 0, countReference = 0;
  @override
  void initState() {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) async {
      if (value) {
        SharedPrefUtil.getSharedBool('first').then((val) {
          if (val == null) {
            isFirstTime = true;
          } else {
            isFirstTime = false;
          }

          getData();
        });
      } else {
        log('No Connection');

        _loadingData(context);
        await _sortingData();

        setState(() {
          isLoadingListData = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    });

    getUserData();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  Future<void> getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;
    await taskListDao.findAllTaskList().then((value) async {
      if (value.isEmpty) {
        taskListBloc.add(const TaskListAttempt());
      } else {
        _loadingData(context);
        await _sortingData();

        setState(() {
          isLoadingListData = false;
        });
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    });
    database.close();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      isFirstTime = false;
      isLoading = true;
      isLoadingListData = true;
      ongoing = 0;
      returned = 0;
      done = 0;
      taskListData = [];
      taskListDataWaiting = [];
    });
    taskListBloc.add(const TaskListAttempt());
    getUserData();
  }

  Future<void> getUserData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final personDao = database.userDao;
    final user = await personDao.findUserById(0);
    setState(() {
      userData = user!;
      isLoading = false;
    });
    database.close();
  }

  Future<void> _processDb(List<Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;

    await taskListDao.findAllTaskList().then((value) async {
      if (value.isEmpty) {
        List<TaskList> taskList = data
            .map((e) => TaskList(
                code: e.code!,
                date: e.date!,
                status: e.status!,
                remark: e.remark,
                result: e.result,
                picCode: e.picCode!,
                picName: e.picName!,
                branchName: e.branchName!,
                agreementNo: e.agreementNo!,
                clientName: e.clientName!,
                mobileNo: e.mobileNo!,
                location: e.location!,
                latitude: e.latitude!,
                longitude: e.longitude!,
                type: e.type!,
                appraisalAmount: e.appraisalAmount,
                reviewRemark: e.reviewRemark,
                modDate: e.modDate!))
            .toList();
        await taskListDao.insertAllTaskList(taskList);
      } else {
        // log('Task List di db Isi');
        await SharedPrefUtil.saveSharedBool('first', true);
        await taskListDao.findTaskListByStatus('PENDING').then((value) async {
          List<Data> taskListTemp = data;
          if (value.isNotEmpty) {
            for (int i = 0; i < value.length; i++) {
              String? code = value[i]!.code;
              taskListTemp.removeWhere((element) => element.code == code);
              if (i == value.length - 1) {
                List<TaskList> taskList = taskListTemp
                    .map((e) => TaskList(
                        code: e.code!,
                        date: e.date!,
                        status: e.status!,
                        remark: e.remark,
                        result: e.result,
                        picCode: e.picCode!,
                        picName: e.picName!,
                        branchName: e.branchName!,
                        agreementNo: e.agreementNo!,
                        clientName: e.clientName!,
                        mobileNo: e.mobileNo!,
                        location: e.location!,
                        latitude: e.latitude!,
                        longitude: e.longitude!,
                        type: e.type!,
                        appraisalAmount: e.appraisalAmount,
                        reviewRemark: e.reviewRemark,
                        modDate: e.modDate!))
                    .toList();
                await taskListDao.deleteTaskListByStatus('ASSIGN');
                await taskListDao.deleteTaskListByStatus('RETURN');
                await taskListDao.deleteTaskListByStatus('DONE');
                await taskListDao.deleteTaskListByStatus('WAITING');
                await taskListDao.insertAllTaskList(taskList);
              }
            }
          } else {
            List<TaskList> taskList = data
                .map((e) => TaskList(
                    code: e.code!,
                    date: e.date!,
                    status: e.status!,
                    remark: e.remark,
                    result: e.result,
                    picCode: e.picCode!,
                    picName: e.picName!,
                    branchName: e.branchName!,
                    agreementNo: e.agreementNo!,
                    clientName: e.clientName!,
                    mobileNo: e.mobileNo!,
                    location: e.location!,
                    latitude: e.latitude!,
                    longitude: e.longitude!,
                    type: e.type!,
                    appraisalAmount: e.appraisalAmount,
                    reviewRemark: e.reviewRemark,
                    modDate: e.modDate!))
                .toList();
            await taskListDao.deleteTaskListByStatus('ASSIGN');
            await taskListDao.deleteTaskListByStatus('RETURN');
            await taskListDao.deleteTaskListByStatus('DONE');
            await taskListDao.deleteTaskListByStatus('WAITING');
            await taskListDao.insertAllTaskList(taskList);
          }
        });
      }
    });

    await _sortingData();
    setState(() {
      isLoadingListData = false;
    });
    database.close();
  }

  Future<void> _processDbQuestion(List<qst.Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final questionListDao = database.questionListDao;
    final answerListDao = database.answerListDao;
    if (data.isNotEmpty) {
      List<QuestionList> questionList = data
          .map((e) => QuestionList(
              code: e.code!,
              taskCode: e.taskCode!,
              questionCode: e.questionCode!,
              questionDesc: e.questionDesc!,
              type: e.type!,
              answer: e.answer,
              answerChoiceId: e.answerChoiceId))
          .toList();

      await questionListDao.insertAllQuestionList(questionList);

      for (int i = 0; i < data.length; i++) {
        if (data[i].answerChoice!.isNotEmpty) {
          List<AnswerList> answerList = data[i]
              .answerChoice!
              .map((e) => AnswerList(
                  id: e.id!,
                  questionOptionDesc: e.questionOptionDesc!,
                  taskQuestionCode: data[i].code!))
              .toList();

          await answerListDao.insertAllAnswerList(answerList);
        }
      }
      database.close();
    }
  }

  Future<void> _processDeleteDbQuestion(List<Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final questionListDao = database.questionListDao;
    final answerListDao = database.answerListDao;
    if (data.isNotEmpty) {
      for (int i = 0; i < data.length; i++) {
        await questionListDao.deleteQuestionListByCode(data[i].code!);
      }
      await answerListDao.deleteAnswerList();
      await questionListDao
          .findAllQuestionList()
          .then((value) => log('${value.length}'));
      await answerListDao
          .findAllAnswerList()
          .then((value) => log('${value.length}'));
      database.close();
    }
  }

  Future<void> _sortingData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;

    await taskListDao.findAllTaskList().then((value) async {
      for (int i = 0; i < value.length; i++) {
        if (value[i]!.status == 'ASSIGN') {
          setState(() {
            ongoing++;
          });
        } else if (value[i]!.status == 'DONE') {
          setState(() {
            done++;
          });
        } else if (value[i]!.status == 'RETURN') {
          setState(() {
            returned++;
          });
        }
      }
    });
    database.close();
  }

  void _sessionExpired() {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actionsPadding:
              const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Container(),
          titlePadding: const EdgeInsets.only(top: 20, left: 20),
          contentPadding: const EdgeInsets.only(
            top: 0,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Text(
                'Sesi anda telah habis',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Silahkan Login ulang',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF575551)),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(
                        context, StringRouterUtil.reloginScreenRoute)
                    .then((value) => _pullRefresh());
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text('Ok',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        );
      },
    );
  }

  void _loadingData(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          actionsPadding:
              const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          insetPadding: const EdgeInsets.symmetric(horizontal: 20),
          title: Container(),
          titlePadding: const EdgeInsets.only(top: 20, left: 20),
          contentPadding: const EdgeInsets.only(
            top: 0,
            bottom: 24,
            left: 24,
            right: 24,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: SizedBox(
                  height: 60,
                  width: 60,
                  child: CircularProgressIndicator(
                    valueColor: animationController!.drive(
                        ColorTween(begin: fourthColor, end: secondaryColor)),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Sedang mengambil data',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mohon menunggu sebentar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF575551)),
              ),
            ],
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text('Batalkan',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processDbAttachment(List<atc.Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final attachmentListDao = database.attachmentListDao;

    List<AttachmentList> attachmentList = data
        .map((e) => AttachmentList(
            id: e.id!,
            taskCode: e.taskCode!,
            documentCode: e.documentCode!,
            documentName: e.documentName!,
            type: e.type!,
            fileName: e.fileName!,
            filePath: e.filePath!))
        .toList();

    await attachmentListDao.insertAllAttachmentList(attachmentList);

    database.close();
  }

  Future<void> _processDeleteDbAttachment(List<Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final attachmentListDao = database.attachmentListDao;

    for (int i = 0; i < data.length; i++) {
      await attachmentListDao.deleteAttachmentListByCode(data[i].code!);
    }

    database.close();
  }

  Future<void> _processDbReference(List<rfr.Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final referenceListDao = database.referenceListDao;

    List<ReferenceList> referenceList = data
        .map((e) => ReferenceList(
            id: e.id!,
            taskCode: e.taskCode!,
            name: e.name!,
            phoneArea: e.areaPhoneNo!,
            phoneNumber: e.phoneNo!,
            remark: e.remark!,
            value: e.value!))
        .toList();

    await referenceListDao.insertAllRefrence(referenceList);

    database.close();
  }

  Future<void> _processDeleteDbReference(List<Data> data) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final referenceListDao = database.referenceListDao;

    for (int i = 0; i < data.length; i++) {
      await referenceListDao.deleteRefrenceById(data[i].code!);
    }
    database.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const HeaderHomeWidget(),
                  const SizedBox(height: 32),
                  isLoading
                      ? const LoadingComp(
                          height: 80,
                          padding: 58,
                        )
                      : UserInfoHomeWidget(user: userData),
                  MultiBlocListener(
                      listeners: [
                        BlocListener(
                          bloc: taskListBloc,
                          listener: (_, TaskListState state) async {
                            if (state is TaskListLoading) {
                              setState(() {
                                isLoadingListData = true;
                              });
                              _loadingData(context);
                            }
                            if (state is TaskListLoaded) {
                              await _processDb(
                                  state.taskListResponseModel.data!);
                              if (state
                                  .taskListResponseModel.data!.isNotEmpty) {
                                if (isFirstTime) {
                                  taskListData.addAll(
                                      state.taskListResponseModel.data!);
                                  questionListBloc.add(QuestionListAttempt(
                                      taskListData[countQuestion].code!));
                                } else {
                                  taskListData = state
                                      .taskListResponseModel.data!
                                      .where((element) =>
                                          element.status != 'WAITING')
                                      .toList();
                                  await _processDeleteDbQuestion(taskListData);
                                  questionListBloc.add(QuestionListAttempt(
                                      taskListData[countQuestion].code!));
                                }
                              } else {
                                setState(() {
                                  isLoadingListData = false;
                                });
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            }
                            if (state is TaskListError) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is TaskListException) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              if (state.error == 'expired') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: questionListBloc,
                          listener: (_, QuestionListState state) async {
                            if (state is QuestionListLoaded) {
                              countQuestion++;
                              if (state
                                  .questionListResponseModel.data!.isNotEmpty) {
                                await _processDbQuestion(
                                    state.questionListResponseModel.data!);
                                if (countQuestion < taskListData.length) {
                                  questionListBloc.add(QuestionListAttempt(
                                      taskListData[countQuestion].code!));
                                } else {
                                  if (!isFirstTime) {
                                    await _processDeleteDbAttachment(
                                        taskListData);
                                  }
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                }
                              } else {
                                if (countQuestion < taskListData.length) {
                                  questionListBloc.add(QuestionListAttempt(
                                      taskListData[countQuestion].code!));
                                } else {
                                  if (!isFirstTime) {
                                    _processDeleteDbAttachment(taskListData);
                                  }
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                }
                              }
                            }
                            if (state is QuestionListError) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is QuestionListException) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              if (state.error == 'expired') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: attachmentListBloc,
                          listener: (_, AttachmentListState state) async {
                            if (state is AttachmentListLoaded) {
                              countAttachment++;
                              if (state.attachmentListResponseModel.data!
                                  .isNotEmpty) {
                                await _processDbAttachment(
                                    state.attachmentListResponseModel.data!);
                                if (countAttachment < taskListData.length) {
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                } else {
                                  if (!isFirstTime) {
                                    await _processDeleteDbReference(
                                        taskListData);
                                  }

                                  referencelistBloc.add(ReferenceListAttempt(
                                      taskListData[countReference].code!));
                                }
                              } else {
                                if (countAttachment < taskListData.length) {
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                } else {
                                  if (!isFirstTime) {
                                    _processDeleteDbReference(taskListData);
                                  }
                                  referencelistBloc.add(ReferenceListAttempt(
                                      taskListData[countReference].code!));
                                }
                              }
                            }
                            if (state is AttachmentListError) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is AttachmentListException) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              if (state.error == 'expired') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: referencelistBloc,
                          listener: (_, ReferenceListState state) async {
                            if (state is ReferenceListLoaded) {
                              countReference++;
                              if (state.referenceListResponseModel.data!
                                  .isNotEmpty) {
                                await _processDbReference(
                                    state.referenceListResponseModel.data!);
                                if (countReference < taskListData.length) {
                                  referencelistBloc.add(ReferenceListAttempt(
                                      taskListData[countReference].code!));
                                } else {
                                  setState(() {
                                    isLoadingListData = false;
                                    isFirstTime = false;
                                  });
                                  Navigator.pop(context);
                                }
                              } else {
                                if (countReference < taskListData.length) {
                                  referencelistBloc.add(ReferenceListAttempt(
                                      taskListData[countReference].code!));
                                } else {
                                  setState(() {
                                    isLoadingListData = false;
                                    isFirstTime = false;
                                  });
                                  Navigator.pop(context);
                                }
                              }
                            }
                            if (state is ReferenceListError) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is ReferenceListException) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              if (state.error == 'expired') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                _sessionExpired();
                              }
                            }
                          },
                        ),
                      ],
                      child: isLoadingListData
                          ? const LoadingGridComp(
                              height: 110,
                              length: 3,
                            )
                          : isExpired
                              ? Container()
                              : MainContentHomeWidget(
                                  done: done,
                                  ongoing: ongoing,
                                  returned: returned,
                                )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorSystem() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(children: [
        const Icon(
          Icons.warning_amber_outlined,
          size: 60,
          color: fourthColor,
        ),
        const Text(
          'Terjadi Kesalahan System',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        const Text(
          'Silahkan coba beberapa saat lagi',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            taskListBloc.add(const TaskListAttempt());
          },
          child: Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
                child: Text('Coba Lagi',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))),
          ),
        ),
      ]),
    );
  }
}
