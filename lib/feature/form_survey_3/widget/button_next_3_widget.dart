import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/attachment_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';

class ButtonNext3Widget extends StatelessWidget {
  const ButtonNext3Widget(
      {super.key,
      required this.data,
      required this.results,
      required this.taskList});
  final List<Data> data;
  final List<AnswerResultsModel> results;
  final TaskList taskList;
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
                List<UploadAttachmentModel> uploadData = [];
                for (int i = 0; i < data.length; i++) {
                  if (data[i].newData != null) {
                    File imagefile = File(data[i].filePath!);
                    Uint8List imagebytes = await imagefile.readAsBytes();
                    String base64string = base64.encode(imagebytes);
                    uploadData.add(UploadAttachmentModel(
                        pBase64: base64string,
                        pId: data[i].id,
                        pModule: "MOB_SVY",
                        pHeader: "TASK_DOCUMENT",
                        pChild: data[i].taskCode,
                        pFilePaths: data[i].id,
                        pFileName: data[i].fileName));
                  }
                  if (i == data.length - 1) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushNamed(
                        context,
                        taskList.type == 'APPRAISAL'
                            ? StringRouterUtil.form5ScreenRoute
                            : StringRouterUtil.form4ScreenRoute,
                        arguments: ArgsSubmitDataModel(
                            answerResults: results,
                            taskList: taskList,
                            uploadAttachment: uploadData,
                            refrence: []));
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
