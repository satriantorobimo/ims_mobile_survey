import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/repo/question_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_4/data/hubungan_model.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/repo/reference_repo.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_answer_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_attachment_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_reference_data_mode.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_summary_data_model.dart';
import 'package:mobile_survey/feature/pending/widget/button_submit_widget.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/network_util.dart';
import '../../assignment/bloc/update_task_bloc/bloc.dart';
import '../../form_survey_2/bloc/update_question_bloc/bloc.dart';
import '../../form_survey_3/bloc/upload_attachment_bloc/bloc.dart';
import '../../form_survey_4/bloc/reference_bloc/bloc.dart';
import '../widget/main_content_widget.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen>
    with TickerProviderStateMixin {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  AnimationController? animationController;
  List<TaskList> pending = [];
  List<PendingAnswer> answer = [];
  List<PendingAttachment> attachment = [];
  List<PendingReference> reference = [];
  late PendingSummary pendingSummary;
  bool isLoading = true, isConnect = false;

  int taskCount = 0;
  int questionCount = 0;
  int attachmentCount = 0;
  int refCount = 0;

  UpdateQuestionBloc updateQuestionBloc =
      UpdateQuestionBloc(questionListRepo: QuestionListRepo());

  UploadAttachmentBloc uploadAttachmentBloc =
      UploadAttachmentBloc(attachmentListRepo: AttachmentListRepo());

  ReferenceBloc referenceBloc = ReferenceBloc(referenceRepo: ReferenceRepo());

  UpdateTaskBloc updateTaskBloc = UpdateTaskBloc(taskListRepo: TaskListRepo());

  Future<void> _getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;
    setState(() {
      pending = [];
    });
    await taskListDao.findTaskListByStatus('PENDING').then((value) async {
      for (int i = 0; i < value.length; i++) {
        setState(() {
          pending.add(value[i]!);
        });
      }
    });

    setState(() {
      isLoading = false;
      database.close();
    });
  }

  Future<void> getAnswer(String taskCode) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingAnswerDao;
    try {
      await taskListDao.findPendingAnswerByTaskCode(taskCode).then((value) {
        setState(() {
          answer = [];
          answer.addAll(value);
        });
      });
    } catch (e) {
      log(e.toString());
    }

    database.close();
  }

  Future<void> getAttachment(String taskCode) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingAttachmentDao;
    try {
      await taskListDao.findPendingAttachmentByCode(taskCode).then((value) {
        setState(() {
          attachment = [];
          attachment.addAll(value);
        });
      });
    } catch (e) {
      log(e.toString());
    }

    database.close();
  }

  Future<void> getReference(String taskCode) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingReferenceDao;
    try {
      await taskListDao.findPendingRefrenceByCode(taskCode).then((value) {
        setState(() {
          reference = [];
          reference.addAll(value);
        });
      });
    } catch (e) {
      log(e.toString());
    }

    database.close();
  }

  Future<void> getSummary(String taskCode) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingSummaryDao;
    try {
      await taskListDao.findPendingSummaryById(taskCode).then((value) {
        setState(() {
          pendingSummary = value!;
        });
      });
    } catch (e) {
      log(e.toString());
    }

    database.close();
  }

  Future<void> processDbUpdateTaskDone(String taskCode) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;
    try {
      await taskListDao.updateTaskStatusById(taskCode, 'WAITING');
    } catch (e) {
      log(e.toString());
    }
    database.close();
  }

  void _submit() {
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
                'Proses upload',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mohon menunggu dan tidak menutup aplikasi selama upload',
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
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                    child: Text('Batalkan upload',
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

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      if (value) {
        setState(() {
          isConnect = true;
        });
      } else {
        setState(() {
          isConnect = false;
        });
      }
    });
    _getData();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      setState(() {
        isLoading = true;
        pending = [];
        _getData();
      });
      if (value) {
        setState(() {
          isConnect = true;
        });
      } else {
        setState(() {
          isConnect = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  void submitData() async {
    questionCount = 0;
    attachmentCount = 0;
    refCount = 0;
    await getAnswer(pending[taskCount].code);
    await getAttachment(pending[taskCount].code);
    await getReference(pending[taskCount].code);
    await getSummary(pending[taskCount].code);
    updateQuestionBloc.add(UpdateQuestionAttempt(AnswerResultsModel(
        pAnswer: answer[questionCount].pAnswer,
        pAnswerChoiceId: answer[questionCount].pAnswerChoiceId,
        pCode: answer[questionCount].pCode)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.circle,
              color: isConnect ? const Color(0xFF5DEA51) : Colors.red,
            ),
          )
        ],
        title: const Text(
          'Sync Data',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
            ),
          ),
          child: Stack(
            children: [
              isLoading
                  ? Container()
                  : pending.isEmpty
                      ? const Center(
                          child: Text(
                            'Tidak Ada Data',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF575551)),
                          ),
                        )
                      : RefreshIndicator(
                          onRefresh: _pullRefresh,
                          child: ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const SizedBox(height: 12);
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: pending.length,
                              padding: const EdgeInsets.all(16),
                              itemBuilder: (context, index) {
                                return MainContentWidget(
                                    taskList: pending[index]);
                              }),
                        ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: MultiBlocListener(
                      listeners: [
                        BlocListener(
                          bloc: updateQuestionBloc,
                          listener: (_, UpdateQuestionState state) async {
                            if (state is UpdateQuestionLoading) {}
                            if (state is UpdateQuestionLoaded) {
                              log('Success update question $questionCount');
                              questionCount++;
                              if (questionCount < answer.length) {
                                updateQuestionBloc.add(UpdateQuestionAttempt(
                                    AnswerResultsModel(
                                        pAnswer: answer[questionCount].pAnswer,
                                        pAnswerChoiceId: answer[questionCount]
                                            .pAnswerChoiceId,
                                        pCode: answer[questionCount].pCode)));
                              } else {
                                log('Start upload $attachmentCount');
                                uploadAttachmentBloc.add(
                                    UploadAttachmentAttempt(
                                        UploadAttachmentModel(
                                            pBase64: attachment[attachmentCount]
                                                .pBase64,
                                            pChild: attachment[attachmentCount]
                                                .pChild,
                                            pFileName:
                                                attachment[attachmentCount]
                                                    .pFileName,
                                            pFilePaths:
                                                attachment[attachmentCount]
                                                    .pFilePaths,
                                            pHeader: attachment[attachmentCount]
                                                .pHeader,
                                            pId:
                                                attachment[attachmentCount].pId,
                                            pModule: attachment[attachmentCount]
                                                .pModule)));
                              }
                            }
                            if (state is UpdateQuestionError) {
                              Navigator.pop(context);
                            }
                            if (state is UpdateQuestionException) {
                              if (state.error == 'expired') {
                                // // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: uploadAttachmentBloc,
                          listener: (_, UploadAttachmentState state) async {
                            if (state is UploadAttachmentLoading) {}
                            if (state is UploadAttachmentLoaded) {
                              log('Success upload $attachmentCount');
                              attachmentCount++;
                              if (attachmentCount < attachment.length) {
                                uploadAttachmentBloc.add(
                                    UploadAttachmentAttempt(
                                        UploadAttachmentModel(
                                            pBase64: attachment[attachmentCount]
                                                .pBase64,
                                            pChild: attachment[attachmentCount]
                                                .pChild,
                                            pFileName:
                                                attachment[attachmentCount]
                                                    .pFileName,
                                            pFilePaths:
                                                attachment[attachmentCount]
                                                    .pFilePaths,
                                            pHeader: attachment[attachmentCount]
                                                .pHeader,
                                            pId:
                                                attachment[attachmentCount].pId,
                                            pModule: attachment[attachmentCount]
                                                .pModule)));
                              } else {
                                if (pending[taskCount].type == 'APPRAISAL') {
                                  log('Start update task');
                                  updateTaskBloc.add(UpdateTaskAttempt(
                                      pending[taskCount].code,
                                      pending[taskCount].type,
                                      pendingSummary.remark,
                                      pendingSummary.value ?? 0));
                                } else {
                                  log('Start insert ref $refCount');
                                  referenceBloc.add(InsertReferenceAttempt(
                                      HubunganModel(
                                          name: reference[refCount].name,
                                          phoneArea:
                                              reference[refCount].phoneArea,
                                          phoneNumber:
                                              reference[refCount].phoneNumber,
                                          remark: reference[refCount].remark,
                                          taskCode:
                                              reference[refCount].taskCode,
                                          value: reference[refCount].value)));
                                }
                              }
                            }
                            if (state is UploadAttachmentError) {
                              Navigator.pop(context);
                            }
                            if (state is UploadAttachmentException) {
                              if (state.error == 'expired') {
                                // // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: referenceBloc,
                          listener: (_, ReferenceState state) async {
                            if (state is ReferenceLoading) {}
                            if (state is ReferenceLoaded) {
                              log('Success insert ref $refCount');
                              refCount++;
                              if (refCount < reference.length) {
                                referenceBloc.add(InsertReferenceAttempt(
                                    HubunganModel(
                                        name: reference[refCount].name,
                                        phoneArea:
                                            reference[refCount].phoneArea,
                                        phoneNumber:
                                            reference[refCount].phoneNumber,
                                        remark: reference[refCount].remark,
                                        taskCode: reference[refCount].taskCode,
                                        value: reference[refCount].value)));
                              } else {
                                log('Start update task');
                                updateTaskBloc.add(UpdateTaskAttempt(
                                    pending[taskCount].code,
                                    pending[taskCount].type,
                                    pendingSummary.remark,
                                    pendingSummary.value ?? 0));
                              }
                            }
                            if (state is ReferenceError) {
                              Navigator.pop(context);
                            }
                            if (state is ReferenceException) {
                              if (state.error == 'expired') {
                                // // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // _sessionExpired();
                              }
                            }
                          },
                        ),
                        BlocListener(
                          bloc: updateTaskBloc,
                          listener: (_, UpdateTaskState state) async {
                            if (state is UpdateTaskLoading) {}
                            if (state is UpdateTaskLoaded) {
                              processDbUpdateTaskDone(pending[taskCount].code);
                              taskCount++;
                              if (taskCount < pending.length) {
                                log('Masih ada task insert');
                                submitData();
                              } else {
                                log('Selesai');

                                _getData();
                                Navigator.pop(context);
                              }
                            }
                            if (state is UpdateTaskError) {
                              Navigator.pop(context);
                            }
                            if (state is UpdateTaskException) {
                              if (state.error == 'expired') {
                                // // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                // _sessionExpired();
                              }
                            }
                          },
                        ),
                      ],
                      child: ButtonSubmitWidget(
                        isConnect: isConnect,
                        isEmpty: pending.isNotEmpty,
                        ontap: isConnect && pending.isNotEmpty
                            ? () {
                                NetworkInfo(internetConnectionChecker)
                                    .isConnected
                                    .then((value) {
                                  if (value) {
                                    setState(() {
                                      isConnect = true;
                                    });
                                    _submit();
                                    submitData();
                                  } else {
                                    setState(() {
                                      isConnect = false;
                                    });
                                  }
                                });
                              }
                            : null,
                      ),
                    ),
                  ))
            ],
          )),
    );
  }
}
