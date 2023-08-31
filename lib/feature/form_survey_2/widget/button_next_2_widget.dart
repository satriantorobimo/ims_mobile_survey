import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/answer_result_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_3/data/upload_attachment_model.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import '../../../components/color_comp.dart';

class ButtonNext2Widget extends StatelessWidget {
  const ButtonNext2Widget(
      {super.key, required this.results, required this.taskList});
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
              onTap: results.isEmpty
                  ? null
                  : () {
                      Navigator.pushNamed(
                          context, StringRouterUtil.form3ScreenRoute,
                          arguments: ArgsSubmitDataModel(
                              answerResults: results,
                              taskList: taskList,
                              uploadAttachment: [],
                              refrence: []));
                    },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 45,
                decoration: BoxDecoration(
                  color:
                      results.isEmpty ? const Color(0xFFD7D7D7) : primaryColor,
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
