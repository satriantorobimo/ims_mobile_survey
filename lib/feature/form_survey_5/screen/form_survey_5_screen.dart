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
import 'package:mobile_survey/feature/form_survey_4/provider/form_survey_4_provider.dart';
import 'package:mobile_survey/utility/database_helper.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/network_util.dart';
import 'package:provider/provider.dart';

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
    if (widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
        widget.argsSubmitDataModel.taskList.status == 'RETURN' ||
        widget.argsSubmitDataModel.taskList.status == 'DONE') {
      if (widget.argsSubmitDataModel.taskList.type == 'SURVEY') {
        if (widget.argsSubmitDataModel.taskList.remark != null ||
            widget.argsSubmitDataModel.taskList.result != null ||
            widget.argsSubmitDataModel.taskList.remark != '' ||
            widget.argsSubmitDataModel.taskList.result != '') {
          setState(() {
            _notesCtrl.text = widget.argsSubmitDataModel.taskList.remark!;
            _sesuaiCtrl.text = widget.argsSubmitDataModel.taskList.result!;
          });
        }
      } else {
        if (widget.argsSubmitDataModel.taskList.remark != null ||
            widget.argsSubmitDataModel.taskList.appraisalAmount != null ||
            widget.argsSubmitDataModel.taskList.remark != '' ||
            widget.argsSubmitDataModel.taskList.appraisalAmount != 0.0) {
          setState(() {
            _notesCtrl.text = widget.argsSubmitDataModel.taskList.remark!;
            _valueCtrl.text =
                widget.argsSubmitDataModel.taskList.appraisalAmount!.toString();
          });
        }
      }
    }
    super.initState();
  }

  void _notComplete() {
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
                'Jawaban anda belum lengkap',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Silahkan periksa kembali',
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

  Future<void> processDbUpdateTaskPending() async {
    await DatabaseHelper.updateQuestion(
        widget.argsSubmitDataModel.answerResults);
    await DatabaseHelper.updateAttachment(
        widget.argsSubmitDataModel.uploadAttachment);
    await DatabaseHelper.updateRefrence(widget.argsSubmitDataModel.refrence);
    await DatabaseHelper.updateTask(
        date: widget.argsSubmitDataModel.taskList.date!,
        taskCode: widget.argsSubmitDataModel.taskList.code!,
        remark: _notesCtrl.text,
        notes: _sesuaiCtrl.text,
        value: _valueCtrl.text.isEmpty ? 0.0 : double.parse(_valueCtrl.text),
        status: 'PENDING');
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
                    child: Text('Batalkan simpan',
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
              onTap: () async {
                Provider.of<FormSurvey4Provider>(context, listen: false)
                    .clearHubungan();
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
                      await processDbUpdateTaskPending();
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
                Provider.of<FormSurvey4Provider>(context, listen: false)
                    .clearHubungan();
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
                'Silahkan Login ulang atau simpan data',
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
                    context, StringRouterUtil.reloginScreenRoute);
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
            const SizedBox(height: 8),
            InkWell(
              onTap: () async {
                Navigator.pop(context);
                _submitDraft();
                await processDbUpdateTaskPending();
                _goHomeDraft();
              },
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                    child: Text('Simpan',
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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Form Survey ${widget.argsSubmitDataModel.taskList.type!.toLowerCase().capitalizeOnlyFirstLater()}',
          style: const TextStyle(
              fontSize: 16, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, top: 20),
            child: Text(
              widget.argsSubmitDataModel.taskList.type == 'SURVEY'
                  ? '4 dari 4'
                  : '5 dari 5',
              style: const TextStyle(
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
                    if (state is UpdateQuestionLoading) {
                      log('Update Question $questionCount / ${widget.argsSubmitDataModel.answerResults.length}  Start');
                    }
                    if (state is UpdateQuestionLoaded) {
                      log('Update Question $questionCount / ${widget.argsSubmitDataModel.answerResults.length}  Done');
                      questionCount++;
                      if (questionCount <
                          widget.argsSubmitDataModel.answerResults.length) {
                        updateQuestionBloc.add(UpdateQuestionAttempt(widget
                            .argsSubmitDataModel.answerResults[questionCount]));
                      } else {
                        await DatabaseHelper.updateQuestion(
                            widget.argsSubmitDataModel.answerResults);
                        if (widget
                            .argsSubmitDataModel.uploadAttachment.isNotEmpty) {
                          uploadAttachmentBloc.add(UploadAttachmentAttempt(
                              widget.argsSubmitDataModel
                                  .uploadAttachment[attachmentCount]));
                        } else if (widget
                            .argsSubmitDataModel.refrence.isNotEmpty) {
                          referenceBloc.add(InsertReferenceAttempt(
                              widget.argsSubmitDataModel.refrence[refCount]));
                        } else {
                          updateTaskBloc.add(UpdateTaskAttempt(
                              widget.argsSubmitDataModel.taskList.code!,
                              widget.argsSubmitDataModel.taskList.type!,
                              _notesCtrl.text,
                              _valueCtrl.text == ""
                                  ? 0
                                  : double.parse(_valueCtrl.text),
                              _sesuaiCtrl.text,
                              widget.argsSubmitDataModel.taskList.date!));
                        }
                      }
                    }
                    if (state is UpdateQuestionError) {
                      Navigator.pop(context);
                    }
                    if (state is UpdateQuestionException) {
                      if (state.error == 'expired') {
                        // // ignore: use_build_context_synchronously
                        Navigator.pop(context);
                        _sessionExpired();
                      }
                    }
                  },
                ),
                BlocListener(
                  bloc: uploadAttachmentBloc,
                  listener: (_, UploadAttachmentState state) async {
                    if (state is UploadAttachmentLoading) {
                      log('Insert Attachment $attachmentCount / ${widget.argsSubmitDataModel.uploadAttachment.length}  Start');
                    }
                    if (state is UploadAttachmentLoaded) {
                      log('Insert Attachment $attachmentCount / ${widget.argsSubmitDataModel.uploadAttachment.length}  Done');
                      attachmentCount++;
                      if (attachmentCount <
                          widget.argsSubmitDataModel.uploadAttachment.length) {
                        uploadAttachmentBloc.add(UploadAttachmentAttempt(widget
                            .argsSubmitDataModel
                            .uploadAttachment[attachmentCount]));
                      } else {
                        await DatabaseHelper.updateAttachment(
                            widget.argsSubmitDataModel.uploadAttachment);
                        if (widget.argsSubmitDataModel.taskList.type ==
                            'SURVEY') {
                          updateTaskBloc.add(UpdateTaskAttempt(
                              widget.argsSubmitDataModel.taskList.code!,
                              widget.argsSubmitDataModel.taskList.type!,
                              _notesCtrl.text,
                              _valueCtrl.text.isEmpty
                                  ? 0.0
                                  : double.parse(_valueCtrl.text),
                              _sesuaiCtrl.text,
                              widget.argsSubmitDataModel.taskList.date!));
                        } else {
                          if (widget.argsSubmitDataModel.refrence.isNotEmpty) {
                            referenceBloc.add(InsertReferenceAttempt(
                                widget.argsSubmitDataModel.refrence[refCount]));
                          } else {
                            updateTaskBloc.add(UpdateTaskAttempt(
                                widget.argsSubmitDataModel.taskList.code!,
                                widget.argsSubmitDataModel.taskList.type!,
                                _notesCtrl.text,
                                _valueCtrl.text.isEmpty
                                    ? 0.0
                                    : double.parse(_valueCtrl.text),
                                _sesuaiCtrl.text,
                                widget.argsSubmitDataModel.taskList.date!));
                          }
                        }
                      }
                    }
                    if (state is UploadAttachmentError) {
                      Navigator.pop(context);
                    }
                    if (state is UploadAttachmentException) {
                      // if (state.error == 'expired') {
                      //   // // ignore: use_build_context_synchronously
                      //   Navigator.pop(context);
                      //   // _sessionExpired();
                      // }
                      Navigator.pop(context);
                    }
                  },
                ),
                BlocListener(
                  bloc: referenceBloc,
                  listener: (_, ReferenceState state) async {
                    if (state is ReferenceLoading) {
                      log('Insert Ref $refCount / ${widget.argsSubmitDataModel.refrence.length}  Start');
                    }
                    if (state is ReferenceLoaded) {
                      log('Insert Ref $refCount / ${widget.argsSubmitDataModel.refrence.length}  Done');
                      refCount++;
                      if (refCount <
                          widget.argsSubmitDataModel.refrence.length) {
                        referenceBloc.add(InsertReferenceAttempt(
                            widget.argsSubmitDataModel.refrence[refCount]));
                      } else {
                        await DatabaseHelper.updateRefrence(
                            widget.argsSubmitDataModel.refrence);
                        updateTaskBloc.add(UpdateTaskAttempt(
                            widget.argsSubmitDataModel.taskList.code!,
                            widget.argsSubmitDataModel.taskList.type!,
                            _notesCtrl.text,
                            _valueCtrl.text.isEmpty
                                ? 0.0
                                : double.parse(_valueCtrl.text),
                            _sesuaiCtrl.text,
                            widget.argsSubmitDataModel.taskList.date!));
                      }
                    }
                    if (state is ReferenceError) {
                      Navigator.pop(context);
                    }
                    if (state is ReferenceException) {
                      // if (state.error == 'expired') {
                      //   // // ignore: use_build_context_synchronously
                      //   Navigator.pop(context);
                      //   // _sessionExpired();
                      // }
                      Navigator.pop(context);
                    }
                  },
                ),
                BlocListener(
                  bloc: updateTaskBloc,
                  listener: (_, UpdateTaskState state) async {
                    if (state is UpdateTaskLoading) {
                      log('Update Task Start');
                    }
                    if (state is UpdateTaskLoaded) {
                      log('Update Task Done');

                      await DatabaseHelper.updateTask(
                          date: widget.argsSubmitDataModel.taskList.date!,
                          taskCode: widget.argsSubmitDataModel.taskList.code!,
                          remark: _notesCtrl.text,
                          notes: _sesuaiCtrl.text,
                          value: _valueCtrl.text.isEmpty
                              ? 0.0
                              : double.parse(_valueCtrl.text),
                          status: 'WAITING');
                      _goHome();
                    }
                    if (state is UpdateTaskError) {
                      Navigator.pop(context);
                    }
                    if (state is UpdateTaskException) {
                      // if (state.error == 'expired') {
                      //   // // ignore: use_build_context_synchronously
                      //   Navigator.pop(context);
                      //   // _sessionExpired();
                      // }
                      Navigator.pop(context);
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
                          onTap: widget.argsSubmitDataModel.taskList.status ==
                                      'WAITING' ||
                                  widget.argsSubmitDataModel.taskList.status ==
                                      'DONE'
                              ? null
                              : () async {
                                  if (widget
                                          .argsSubmitDataModel.taskList.type ==
                                      'SURVEY') {
                                    if (_notesCtrl.text.isEmpty ||
                                        _notesCtrl.text == '' &&
                                            _sesuaiCtrl.text.isEmpty ||
                                        _sesuaiCtrl.text == '') {
                                      _notComplete();
                                    } else {
                                      NetworkInfo(internetConnectionChecker)
                                          .isConnected
                                          .then((value) {
                                        if (value) {
                                          _submit();
                                          if (widget.argsSubmitDataModel
                                              .answerResults.isNotEmpty) {
                                            updateQuestionBloc.add(
                                                UpdateQuestionAttempt(widget
                                                        .argsSubmitDataModel
                                                        .answerResults[
                                                    questionCount]));
                                          } else if (widget.argsSubmitDataModel
                                              .uploadAttachment.isNotEmpty) {
                                            uploadAttachmentBloc.add(
                                                UploadAttachmentAttempt(widget
                                                        .argsSubmitDataModel
                                                        .uploadAttachment[
                                                    attachmentCount]));
                                          } else if (widget.argsSubmitDataModel
                                              .refrence.isNotEmpty) {
                                            referenceBloc.add(
                                                InsertReferenceAttempt(widget
                                                    .argsSubmitDataModel
                                                    .refrence[refCount]));
                                          } else {
                                            updateTaskBloc.add(
                                                UpdateTaskAttempt(
                                                    widget.argsSubmitDataModel
                                                        .taskList.code!,
                                                    widget.argsSubmitDataModel
                                                        .taskList.type!,
                                                    _notesCtrl.text,
                                                    _valueCtrl.text == ""
                                                        ? 0
                                                        : double.parse(
                                                            _valueCtrl.text),
                                                    _sesuaiCtrl.text,
                                                    widget.argsSubmitDataModel
                                                        .taskList.date!));
                                          }
                                        } else {
                                          _warningOffline();
                                        }
                                      });
                                    }
                                  } else {
                                    if (_notesCtrl.text.isEmpty ||
                                        _notesCtrl.text == '' &&
                                            _valueCtrl.text.isEmpty ||
                                        _valueCtrl.text == '') {
                                      _notComplete();
                                    } else {
                                      NetworkInfo(internetConnectionChecker)
                                          .isConnected
                                          .then((value) {
                                        if (value) {
                                          _submit();
                                          if (widget.argsSubmitDataModel
                                              .answerResults.isNotEmpty) {
                                            updateQuestionBloc.add(
                                                UpdateQuestionAttempt(widget
                                                        .argsSubmitDataModel
                                                        .answerResults[
                                                    questionCount]));
                                          } else if (widget.argsSubmitDataModel
                                              .uploadAttachment.isNotEmpty) {
                                            uploadAttachmentBloc.add(
                                                UploadAttachmentAttempt(widget
                                                        .argsSubmitDataModel
                                                        .uploadAttachment[
                                                    attachmentCount]));
                                          } else if (widget.argsSubmitDataModel
                                              .refrence.isNotEmpty) {
                                            referenceBloc.add(
                                                InsertReferenceAttempt(widget
                                                    .argsSubmitDataModel
                                                    .refrence[refCount]));
                                          } else {
                                            updateTaskBloc.add(
                                                UpdateTaskAttempt(
                                                    widget.argsSubmitDataModel
                                                        .taskList.code!,
                                                    widget.argsSubmitDataModel
                                                        .taskList.type!,
                                                    _notesCtrl.text,
                                                    _valueCtrl.text == ""
                                                        ? 0
                                                        : double.parse(
                                                            _valueCtrl.text),
                                                    _sesuaiCtrl.text,
                                                    widget.argsSubmitDataModel
                                                        .taskList.date!));
                                          }
                                        } else {
                                          _warningOffline();
                                        }
                                      });
                                    }
                                  }
                                },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            height: 45,
                            decoration: BoxDecoration(
                              color:
                                  widget.argsSubmitDataModel.taskList.status ==
                                              'WAITING' ||
                                          widget.argsSubmitDataModel.taskList
                                                  .status ==
                                              'DONE'
                                      ? Colors.grey
                                      : primaryColor,
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
          height: MediaQuery.of(context).size.height * 0.9,
          margin:
              EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.2),
          padding:
              const EdgeInsets.only(bottom: 50, top: 16, left: 16, right: 16),
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
                enabled:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? false
                        : true,
                readOnly:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? true
                        : false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    fontSize: 15.0,
                    color: widget.argsSubmitDataModel.taskList.status ==
                                'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? Colors.grey
                        : Colors.black),
                onEditingComplete: () {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: widget.argsSubmitDataModel.taskList.status ==
                              'WAITING' ||
                          widget.argsSubmitDataModel.taskList.status == 'DONE'
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white,
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
                enabled:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? false
                        : true,
                readOnly:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? true
                        : false,
                textInputAction: TextInputAction.done,
                style: TextStyle(
                    fontSize: 15.0,
                    color: widget.argsSubmitDataModel.taskList.status ==
                                'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? Colors.grey
                        : Colors.black),
                onEditingComplete: () {},
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: widget.argsSubmitDataModel.taskList.status ==
                              'WAITING' ||
                          widget.argsSubmitDataModel.taskList.status == 'DONE'
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white,
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
                enabled:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? false
                        : true,
                readOnly:
                    widget.argsSubmitDataModel.taskList.status == 'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? true
                        : false,
                autofocus: false,
                minLines: 8,
                maxLines: 20,
                maxLength: 4000,
                keyboardType: TextInputType.multiline,
                onChanged: (value) {},
                style: TextStyle(
                    fontSize: 15.0,
                    color: widget.argsSubmitDataModel.taskList.status ==
                                'WAITING' ||
                            widget.argsSubmitDataModel.taskList.status == 'DONE'
                        ? Colors.grey
                        : Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: widget.argsSubmitDataModel.taskList.status ==
                              'WAITING' ||
                          widget.argsSubmitDataModel.taskList.status == 'DONE'
                      ? Colors.grey.withOpacity(0.05)
                      : Colors.white,
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
