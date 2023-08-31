import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';

class ButtonNext1Widget extends StatelessWidget {
  const ButtonNext1Widget({super.key, required this.taskList});
  final TaskList taskList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, StringRouterUtil.form2ScreenRoute,
              arguments: taskList);
        },
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
              child: Text('Berikutnya',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.w600))),
        ),
      ),
    );
  }
}
