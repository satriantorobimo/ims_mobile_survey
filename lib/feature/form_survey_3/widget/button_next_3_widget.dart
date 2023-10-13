import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart'
    as task;
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/utility/database_helper.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';

class ButtonNext3Widget extends StatefulWidget {
  const ButtonNext3Widget(
      {super.key,
      required this.data,
      required this.results,
      required this.taskList});
  final List<Data> data;
  final List<AnswerResultsModel> results;
  final task.Data taskList;

  @override
  State<ButtonNext3Widget> createState() => _ButtonNext3WidgetState();
}

class _ButtonNext3WidgetState extends State<ButtonNext3Widget> {
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
                'Attachment anda belum lengkap',
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
              onTap: () async {
                if (widget.taskList.status == 'RETURN' ||
                    widget.taskList.status == 'WAITING' ||
                    widget.taskList.status == 'DONE') {
                  List<UploadAttachmentModel> uploadData = [];
                  for (int i = 0; i < widget.data.length; i++) {
                    if (widget.data[i].filePath == "" &&
                        widget.data[i].isRequired == '1') {
                      _notComplete();
                      break;
                    } else {
                      if (widget.data[i].newData != null) {
                        File imagefile = File(widget.data[i].filePath!);
                        Uint8List imagebytes = await imagefile.readAsBytes();
                        String base64string = base64.encode(imagebytes);
                        uploadData.add(UploadAttachmentModel(
                            pBase64: base64string,
                            pId: widget.data[i].id,
                            pModule: "MOB_SVY",
                            pHeader: "TASK_DOCUMENT",
                            pChild: widget.data[i].taskCode,
                            pFilePaths: widget.data[i].id,
                            pFileName: widget.data[i].fileName,
                            imagePath: widget.data[i].filePath!));
                      }
                    }

                    if (i == widget.data.length - 1) {
                      // ignore: use_build_context_synchronously
                      Navigator.pushNamed(
                          context,
                          widget.taskList.type == 'SURVEY'
                              ? StringRouterUtil.form5ScreenRoute
                              : StringRouterUtil.form4ScreenRoute,
                          arguments: ArgsSubmitDataModel(
                              answerResults: widget.results,
                              taskList: widget.taskList,
                              uploadAttachment: uploadData,
                              refrence: []));
                    }
                  }
                } else {
                  if (widget.data.isEmpty) {
                    _notComplete();
                  } else {
                    List<UploadAttachmentModel> uploadData = [];
                    for (int i = 0; i < widget.data.length; i++) {
                      if (widget.data[i].filePath == "" &&
                          widget.data[i].isRequired == '1') {
                        _notComplete();
                        break;
                      } else {
                        if (widget.data[i].newData != null) {
                          File imagefile = File(widget.data[i].filePath!);
                          Uint8List imagebytes = await imagefile.readAsBytes();
                          String base64string = base64.encode(imagebytes);
                          uploadData.add(UploadAttachmentModel(
                              pBase64: base64string,
                              pId: widget.data[i].id,
                              pModule: "MOB_SVY",
                              pHeader: "TASK_DOCUMENT",
                              pChild: widget.data[i].taskCode,
                              pFilePaths: widget.data[i].id,
                              pFileName: widget.data[i].fileName,
                              imagePath: widget.data[i].filePath));
                        }
                      }

                      if (i == widget.data.length - 1) {
                        // ignore: use_build_context_synchronously
                        await DatabaseHelper.updateAttachment(uploadData);

                        Navigator.pushNamed(
                            context,
                            widget.taskList.type == 'SURVEY'
                                ? StringRouterUtil.form5ScreenRoute
                                : StringRouterUtil.form4ScreenRoute,
                            arguments: ArgsSubmitDataModel(
                                answerResults: widget.results,
                                taskList: widget.taskList,
                                uploadAttachment: uploadData,
                                refrence: []));
                      }
                    }
                  }
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
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
