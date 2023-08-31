// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/feature/assignment/bloc/update_task_bloc/bloc.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_2/bloc/update_question_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/domain/repo/question_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_3/bloc/upload_attachment_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_3/domain/repo/attachment_list_repo.dart';
import 'package:mobile_survey/feature/form_survey_4/bloc/reference_bloc/bloc.dart';
import 'package:mobile_survey/feature/form_survey_4/domain/repo/reference_repo.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_answer_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_attachment_data_model.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_reference_data_mode.dart';
import 'package:mobile_survey/feature/form_survey_5/data/pending_summary_data_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/network_util.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';

class FormSurvey5Screen extends StatefulWidget {
  const FormSurvey5Screen({super.key, required this.argsSubmitDataModel});
  final ArgsSubmitDataModel argsSubmitDataModel;
  @override
  State<FormSurvey5Screen> createState() => _FormSurvey5ScreenState();
}

class _FormSurvey5ScreenState extends State<FormSurvey5Screen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  final TextEditingController _notesCtrl = TextEditingController();
  final TextEditingController _sesuaiCtrl = TextEditingController();
  final TextEditingController _valueCtrl = TextEditingController();

  int questionCount = 0;
  int attachmentCount = 0;
  int refCount = 0;

  UpdateQuestionBloc updateQuestionBloc =
      UpdateQuestionBloc(questionListRepo: QuestionListRepo());

  UploadAttachmentBloc uploadAttachmentBloc =
      UploadAttachmentBloc(attachmentListRepo: AttachmentListRepo());

  ReferenceBloc referenceBloc = ReferenceBloc(referenceRepo: ReferenceRepo());

  UpdateTaskBloc updateTaskBloc = UpdateTaskBloc(taskListRepo: TaskListRepo());

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
    super.initState();
  }

  Future<void> processDbUpdateQuestion() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;
    try {
      await taskListDao.updateTaskStatusById(
          widget.argsSubmitDataModel.taskList.code, 'PENDING');
      await taskListDao
          .findTaskListById(widget.argsSubmitDataModel.taskList.code)
          .then((value) {
        log('Task List : ${value!.code}');
        log('Task List : ${value.status}');
      });
    } catch (e) {
      log(e.toString());
    }
    database.close();
  }

  Future<void> processDbAnswer() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingAnswerDao;
    try {
      for (int i = 0;
          i < widget.argsSubmitDataModel.answerResults.length;
          i++) {
        final pendingAnswer = PendingAnswer(
            pCode: widget.argsSubmitDataModel.answerResults[i].pCode!,
            pAnswer: widget.argsSubmitDataModel.answerResults[i].pAnswer,
            pAnswerChoiceId:
                widget.argsSubmitDataModel.answerResults[i].pAnswerChoiceId);
        await taskListDao.insertPendingAnswer(pendingAnswer);
        await taskListDao
            .findPendingAnswerById(pendingAnswer.pCode)
            .then((value) {
          log('Answer Pending : ${value!.pCode}');
          log('Answer Pending : ${value.pAnswer}');
          log('Answer Pending : ${value.pAnswerChoiceId}');
        });
      }
    } catch (e) {
      log(e.toString());
    }
    database.close();
  }

  Future<void> processDbAttachment() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingAttachmentDao;
    try {
      for (int i = 0;
          i < widget.argsSubmitDataModel.uploadAttachment.length;
          i++) {
        final pendingAttachment = PendingAttachment(
            pModule: widget.argsSubmitDataModel.uploadAttachment[i].pModule,
            pHeader: widget.argsSubmitDataModel.uploadAttachment[i].pHeader,
            pChild: widget.argsSubmitDataModel.uploadAttachment[i].pChild,
            pId: widget.argsSubmitDataModel.uploadAttachment[i].pId,
            pFilePaths:
                widget.argsSubmitDataModel.uploadAttachment[i].pFilePaths,
            pFileName: widget.argsSubmitDataModel.uploadAttachment[i].pFileName,
            pBase64: widget.argsSubmitDataModel.uploadAttachment[i].pBase64);
        await taskListDao.insertPendingAttachment(pendingAttachment);
        await taskListDao
            .findPendingAttachmentByCode(pendingAttachment.pChild!)
            .then((value) {
          log('Attachment Pending : ${value.length}');
        });
      }
    } catch (e) {
      log(e.toString());
    }
    database.close();
  }

  Future<void> processDbReference() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingReferenceDao;
    try {
      for (int i = 0; i < widget.argsSubmitDataModel.refrence.length; i++) {
        final pendingReference = PendingReference(
            taskCode: widget.argsSubmitDataModel.refrence[i].taskCode!,
            name: widget.argsSubmitDataModel.refrence[i].name!,
            phoneArea: widget.argsSubmitDataModel.refrence[i].phoneArea!,
            phoneNumber: widget.argsSubmitDataModel.refrence[i].phoneNumber!,
            remark: widget.argsSubmitDataModel.refrence[i].remark!,
            value: widget.argsSubmitDataModel.refrence[i].value!);
        await taskListDao.insertPendingRefrence(pendingReference);
        await taskListDao
            .findPendingRefrenceByCode(pendingReference.taskCode)
            .then((value) {
          log('Reference Pending : ${value.length}');
        });
      }
    } catch (e) {
      log(e.toString());
    }
    database.close();
  }

  Future<void> processDbSummary() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.pendingSummaryDao;
    try {
      final pendingSummary = PendingSummary(
          taskCode: widget.argsSubmitDataModel.taskList.code,
          remark: _notesCtrl.text,
          notes: _sesuaiCtrl.text,
          value:
              _valueCtrl.text.isEmpty ? null : double.parse(_valueCtrl.text));
      await taskListDao.insertPendingSummary(pendingSummary);
      await taskListDao
          .findPendingSummaryByCode(pendingSummary.taskCode)
          .then((value) {
        log('Summary Pending : ${value.length}');
      });
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

  void _submitDraft() {
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
                'Proses simpan data',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              const SizedBox(height: 16),
              const Text(
                'Mohon menunggu dan tidak menutup aplikasi selama simpan data',
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

  void _goHome() {
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
              Center(
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF4CAB7D),
                  size: 80,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Laporan berhasil diupload',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 16),
              Text(
                'Laporan survey akan masuk ke status menunggu approval / waiting.',
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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  StringRouterUtil.tabScreenRoute,
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                    child: Text('Lihat Assignment',
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

  void _warningOffline() {
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
              Center(
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: Color.fromARGB(255, 236, 233, 26),
                  size: 80,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Tidak ada jaringan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 16),
              Text(
                'Apakah anda ingin simpan sebagai Draft?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF575551)),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      _submitDraft();
                      await processDbUpdateQuestion();
                      await processDbAnswer();
                      await processDbAttachment();
                      await processDbReference();
                      await processDbSummary();
                      Navigator.pop(context);
                      _goHomeDraft();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 45,
                      decoration: BoxDecoration(
                        color: thirdColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                          child: Text('Simpan',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 45,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                          child: Text('Tidak',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _goHomeDraft() {
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
              Center(
                child: Icon(
                  Icons.check_circle,
                  color: Color(0xFF4CAB7D),
                  size: 80,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Laporan berhasil disimpan',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 16),
              Text(
                'Laporan survey akan masuk ke status pending.',
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
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  StringRouterUtil.tabScreenRoute,
                  (route) => false,
                );
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                    child: Text('Lihat Assignment',
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Form Survey',
          style: TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16, top: 20),
            child: Text(
              '5 dari 5',
              style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF575551),
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
          ),
        ),
        child: Stack(
          children: [
            MultiBlocListener(
              listeners: [
                BlocListener(
                  bloc: updateQuestionBloc,
                  listener: (_, UpdateQuestionState state) async {
                    if (state is UpdateQuestionLoading) {}
                    if (state is UpdateQuestionLoaded) {
                      questionCount++;
                      if (questionCount <
                          widget.argsSubmitDataModel.answerResults.length) {
                        updateQuestionBloc.add(UpdateQuestionAttempt(widget
                            .argsSubmitDataModel.answerResults[questionCount]));
                      } else {
                        uploadAttachmentBloc.add(UploadAttachmentAttempt(widget
                            .argsSubmitDataModel
                            .uploadAttachment[attachmentCount]));
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
                      attachmentCount++;
                      if (attachmentCount <
                          widget.argsSubmitDataModel.uploadAttachment.length) {
                        uploadAttachmentBloc.add(UploadAttachmentAttempt(widget
                            .argsSubmitDataModel
                            .uploadAttachment[attachmentCount]));
                      } else {
                        if (widget.argsSubmitDataModel.taskList.type ==
                            'APPRAISAL') {
                          updateTaskBloc.add(UpdateTaskAttempt(
                              widget.argsSubmitDataModel.taskList.code,
                              widget.argsSubmitDataModel.taskList.type,
                              _notesCtrl.text,
                              double.parse(_valueCtrl.text)));
                        } else {
                          referenceBloc.add(InsertReferenceAttempt(
                              widget.argsSubmitDataModel.refrence[refCount]));
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
                      refCount++;
                      if (refCount <
                          widget.argsSubmitDataModel.refrence.length) {
                        referenceBloc.add(InsertReferenceAttempt(
                            widget.argsSubmitDataModel.refrence[refCount]));
                      } else {
                        updateTaskBloc.add(UpdateTaskAttempt(
                            widget.argsSubmitDataModel.taskList.code,
                            widget.argsSubmitDataModel.taskList.type,
                            _notesCtrl.text,
                            double.parse(_valueCtrl.text)));
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
                      _goHome();
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
              child: mainContent(),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                    color: const Color(0xFFf9f9f9),
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: 45,
                          child: OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              // ignore: sort_child_properties_last
                              child: const Text(
                                'Sebelumnya',
                                style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600),
                              ),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0))),
                                side:
                                    MaterialStateProperty.all(const BorderSide(
                                  color: primaryColor,
                                )),
                              )),
                        ),
                        InkWell(
                          onTap: () async {
                            NetworkInfo(internetConnectionChecker)
                                .isConnected
                                .then((value) {
                              if (value) {
                                _submit();
                                updateQuestionBloc.add(UpdateQuestionAttempt(
                                    widget.argsSubmitDataModel
                                        .answerResults[questionCount]));
                              } else {
                                _warningOffline();
                              }
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            child: const Center(
                                child: Text('Submit',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600))),
                          ),
                        ),
                      ],
                    )))
          ],
        ),
      ),
    );
  }

  Widget mainContent() {
    return SingleChildScrollView(
      child: Container(
          padding:
              const EdgeInsets.only(bottom: 80, top: 16, left: 16, right: 16),
          child: Column(
            children: [
              txtArea(),
              const SizedBox(height: 16),
              widget.argsSubmitDataModel.taskList.type == 'APPRAISAL'
                  ? txtBoxNilaiAkhir()
                  : txtBox()
            ],
          )),
    );
  }

  Widget txtBoxNilaiAkhir() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        color: Colors.transparent,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: 'Nilai akhir survey'),
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: TextFormField(
                controller: _valueCtrl,
                autofocus: false,
                enabled: true,
                readOnly: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                onEditingComplete: () {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget txtBox() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        color: Colors.transparent,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: 'Apakah survey sudah sesuai?'),
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: TextFormField(
                controller: _sesuaiCtrl,
                autofocus: false,
                enabled: true,
                readOnly: false,
                textInputAction: TextInputAction.done,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                onEditingComplete: () {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget txtArea() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        color: Colors.transparent,
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Text(
                'Remark',
                style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF575551),
                    fontWeight: FontWeight.w600),
              ),
              Text(
                ' *',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.red,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: TextFormField(
                controller: _notesCtrl,
                enabled: true,
                readOnly: false,
                autofocus: false,
                minLines: 8,
                maxLines: 10,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(14),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}