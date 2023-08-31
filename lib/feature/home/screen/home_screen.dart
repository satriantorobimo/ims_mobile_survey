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
import 'package:mobile_survey/feature/form_survey_3/bloc/attachment_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:mobile_survey/feature/home/widget/header_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/main_content_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/user_info_home_widget.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/network_util.dart';
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
  List<Data> taskListData = [];
  late User userData;
  bool isLoading = true, isLoadingListData = true, isExpired = false;
  int ongoing = 0;
  int returned = 0;
  int done = 0;
  int countQuestion = 0, countAttachment = 0;
  @override
  void initState() {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) async {
      if (value) {
        taskListBloc.add(const TaskListAttempt());
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

  Future<void> _pullRefresh() async {
    setState(() {
      isLoading = true;
      isLoadingListData = true;
      ongoing = 0;
      returned = 0;
      done = 0;
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
        // log('Task List di db Kosong');
        for (int i = 0; i < data.length; i++) {
          final taskList = TaskList(
              code: data[i].code!,
              date: data[i].date!,
              status: data[i].status!,
              remark: data[i].remark,
              result: data[i].result,
              picCode: data[i].picCode!,
              picName: data[i].picName!,
              branchName: data[i].branchName!,
              agreementNo: data[i].agreementNo!,
              clientName: data[i].clientName!,
              mobileNo: data[i].mobileNo!,
              location: data[i].location!,
              latitude: data[i].latitude!,
              longitude: data[i].longitude!,
              type: data[i].type!,
              appraisalAmount: data[i].appraisalAmount);
          await taskListDao.insertTaskList(taskList);
          // log('Task List di db Kosong : berhasil tambah $i');
        }
      } else {
        // log('Task List di db Isi');
        for (int i = 0; i < data.length; i++) {
          await taskListDao.findTaskListById(data[i].code!).then((value) async {
            final taskList = TaskList(
                code: data[i].code!,
                date: data[i].date!,
                status: data[i].status!,
                remark: data[i].remark,
                result: data[i].result,
                picCode: data[i].picCode!,
                picName: data[i].picName!,
                branchName: data[i].branchName!,
                agreementNo: data[i].agreementNo!,
                clientName: data[i].clientName!,
                mobileNo: data[i].mobileNo!,
                location: data[i].location!,
                latitude: data[i].latitude!,
                longitude: data[i].longitude!,
                type: data[i].type!,
                appraisalAmount: data[i].appraisalAmount);
            if (value == null) {
              // log('Task List di db Isi : data ke $i tidak ada');
              await taskListDao.insertTaskList(taskList);
              // log('Task List di db Isi : data ke $i tidak ada dan berhasil isi');
            } else {
              if (value.status != 'PENDING') {
                if (value.toJson().toString() != taskList.toJson().toString()) {
                  await taskListDao.deleteTaskListById(taskList.code);
                  await taskListDao.insertTaskList(taskList);
                  // log('Task List di db Isi : data ke $i ada namun ada data ke update dan berhasil isi');
                } else {
                  // log('Task List di db Isi : data ke $i ada dan isi sama');
                }
              }
            }
          });
        }
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

    await questionListDao.findAllQuestionList().then((value) async {
      if (value.isEmpty) {
        // log('Question di db Kosong');
        for (int i = 0; i < data.length; i++) {
          final question = QuestionList(
              code: data[i].code!,
              taskCode: data[i].taskCode!,
              questionCode: data[i].questionCode!,
              questionDesc: data[i].questionDesc!,
              type: data[i].type!,
              answer: data[i].answer,
              answerChoiceId: data[i].answerChoiceId);
          await questionListDao.insertQuestionList(question);
          // log('Question List di db Kosong : berhasil tambah');
          if (data[i].answerChoice!.isNotEmpty) {
            for (int x = 0; x < data[i].answerChoice!.length; x++) {
              // log('Answer List length ${data[i].answerChoice!.length}');
              final answer = AnswerList(
                  id: data[i].answerChoice![x].id!,
                  questionOptionDesc:
                      data[i].answerChoice![x].questionOptionDesc!,
                  taskQuestionCode: data[i].answerChoice![x].taskQuestionCode!);
              // log('Answer Code ${answer.taskQuestionCode}');
              await answerListDao.insertAnswerList(answer);
              // log('Answer List di db Kosong : berhasil tambah $i');
            }
          }
        }
      } else {
        for (int i = 0; i < data.length; i++) {
          await questionListDao
              .findQuestionListById(data[i].code!)
              .then((value) async {
            if (value == null) {
              final question = QuestionList(
                  code: data[i].code!,
                  taskCode: data[i].taskCode!,
                  questionCode: data[i].questionCode!,
                  questionDesc: data[i].questionDesc!,
                  type: data[i].type!,
                  answer: data[i].answer,
                  answerChoiceId: data[i].answerChoiceId);
              await questionListDao.insertQuestionList(question);
              // log('Question List di db Kosong : berhasil tambah');
              if (data[i].answerChoice!.isNotEmpty) {
                for (int x = 0; x < data[i].answerChoice!.length; x++) {
                  final answer = AnswerList(
                      id: data[i].answerChoice![x].id!,
                      questionOptionDesc:
                          data[i].answerChoice![x].questionOptionDesc!,
                      taskQuestionCode:
                          data[i].answerChoice![x].taskQuestionCode!);
                  await answerListDao.insertAnswerList(answer);
                  // log('Answer List di db Kosong : berhasil tambah $i');
                }
              }
            } else {
              // log('Question List di db Isi');
              final question = QuestionList(
                  code: data[i].code!,
                  taskCode: data[i].taskCode!,
                  questionCode: data[i].questionCode!,
                  questionDesc: data[i].questionDesc!,
                  type: data[i].type!,
                  answer: data[i].answer,
                  answerChoiceId: data[i].answerChoiceId);
              await questionListDao.deleteQuestionListById(data[i].code!);
              await questionListDao.insertQuestionList(question);
              if (data[i].answerChoice!.isNotEmpty) {
                await answerListDao.deleteAnswerListById(data[i].code!);
                for (int x = 0; x < data[i].answerChoice!.length; x++) {
                  final answer = AnswerList(
                      id: data[i].answerChoice![x].id!,
                      questionOptionDesc:
                          data[i].answerChoice![x].questionOptionDesc!,
                      taskQuestionCode:
                          data[i].answerChoice![x].taskQuestionCode!);

                  await answerListDao.insertAnswerList(answer);
                  await answerListDao
                      .findAnswerListByCode('TQS.2307.000001')
                      .then((value) {
                    log(value.length.toString());
                  });
                  // log('Answer Null Delete Tambah');
                }
              }
            }
          });
        }
      }
    });
    database.close();
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

    await attachmentListDao.findAllAttachmentList().then((value) async {
      if (value.isEmpty) {
        // log('Attachment di db Kosong');
        for (int i = 0; i < data.length; i++) {
          final attachment = AttachmentList(
              id: data[i].id!,
              taskCode: data[i].taskCode!,
              documentCode: data[i].documentCode!,
              documentName: data[i].documentName!,
              type: data[i].type!,
              fileName: data[i].fileName!,
              filePath: data[i].filePath!);
          await attachmentListDao.insertAttachmentList(attachment);
          // log('Attachment List di db Kosong : berhasil tambah');
        }
      } else {
        for (int i = 0; i < data.length; i++) {
          await attachmentListDao
              .findAttachmentListById(data[i].documentCode!, data[i].taskCode!)
              .then((value) async {
            final attachment = AttachmentList(
                id: data[i].id!,
                taskCode: data[i].taskCode!,
                documentCode: data[i].documentCode!,
                documentName: data[i].documentName!,
                type: data[i].type!,
                fileName: data[i].fileName!,
                filePath: data[i].filePath!);
            if (value == null) {
              await attachmentListDao.insertAttachmentList(attachment);
              // log('Attachment List di db Kosong : berhasil tambah');
            } else {
              if (value.toJson().toString() != attachment.toJson().toString()) {
                await attachmentListDao.deleteAttachmentListById(
                    attachment.documentCode, attachment.taskCode);
                await attachmentListDao.insertAttachmentList(attachment);
                // log('Attachment List di db Isi : data ke $i ada namun ada data ke update dan berhasil isi');
              } else {
                // log('Attachment List di db Isi : data ke $i ada dan isi sama');
              }
            }
          });
        }
      }
    });

    setState(() {
      isLoadingListData = false;
    });
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
                                taskListData
                                    .addAll(state.taskListResponseModel.data!);
                                questionListBloc.add(QuestionListAttempt(
                                    taskListData[countQuestion].code!));
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
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                }
                              } else {
                                if (countQuestion < taskListData.length) {
                                  questionListBloc.add(QuestionListAttempt(
                                      taskListData[countQuestion].code!));
                                } else {
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
                                  Navigator.pop(context);
                                }
                              } else {
                                if (countAttachment < taskListData.length) {
                                  attachmentListBloc.add(AttachmentListAttempt(
                                      taskListData[countAttachment].code!));
                                } else {
                                  Navigator.pop(context);
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
                        )
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
