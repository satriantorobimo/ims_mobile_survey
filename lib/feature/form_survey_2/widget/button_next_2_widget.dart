import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import '../../../components/color_comp.dart';

class ButtonNext2Widget extends StatefulWidget {
  const ButtonNext2Widget(
      {super.key,
      required this.results,
      required this.taskList,
      required this.lengthQuestion});
  final int lengthQuestion;
  final List<AnswerResultsModel> results;
  final TaskList taskList;

  @override
  State<ButtonNext2Widget> createState() => _ButtonNext2WidgetState();
}

class _ButtonNext2WidgetState extends State<ButtonNext2Widget> {
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

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0))),
                    side: MaterialStateProperty.all(const BorderSide(
                      color: primaryColor,
                    )),
                  )),
            ),
            InkWell(
              onTap: widget.taskList.status == 'RETURN' ||
                      widget.taskList.status == 'WAITING' ||
                      widget.taskList.status == 'DONE'
                  ? () {
                      if (widget.results.isNotEmpty) {
                        for (int i = 0; i < widget.results.length; i++) {
                          if (widget.results[i].pAnswer == '') {
                            _notComplete();
                            break;
                          }
                          if (i == widget.results.length - 1) {
                            Navigator.pushNamed(
                                context, StringRouterUtil.form3ScreenRoute,
                                arguments: ArgsSubmitDataModel(
                                    answerResults: widget.results,
                                    taskList: widget.taskList,
                                    uploadAttachment: [],
                                    refrence: []));
                          }
                        }
                      } else {
                        Navigator.pushNamed(
                            context, StringRouterUtil.form3ScreenRoute,
                            arguments: ArgsSubmitDataModel(
                                answerResults: widget.results,
                                taskList: widget.taskList,
                                uploadAttachment: [],
                                refrence: []));
                      }
                    }
                  : widget.results.isEmpty
                      ? null
                      : () {
                          if (widget.results.length < widget.lengthQuestion) {
                            _notComplete();
                          } else {
                            for (int i = 0; i < widget.results.length; i++) {
                              if (widget.results[i].pAnswer == '') {
                                _notComplete();
                                break;
                              }
                              if (i == widget.results.length - 1) {
                                Navigator.pushNamed(
                                    context, StringRouterUtil.form3ScreenRoute,
                                    arguments: ArgsSubmitDataModel(
                                        answerResults: widget.results,
                                        taskList: widget.taskList,
                                        uploadAttachment: [],
                                        refrence: []));
                              }
                            }
                          }
                        },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 45,
                decoration: BoxDecoration(
                  color: widget.taskList.status == 'RETURN' ||
                          widget.taskList.status == 'WAITING' ||
                          widget.taskList.status == 'DONE'
                      ? primaryColor
                      : widget.results.isEmpty
                          ? const Color(0xFFD7D7D7)
                          : primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                    child: Text('Berikutnya',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ));
  }
}
