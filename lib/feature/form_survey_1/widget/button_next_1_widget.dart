import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart'
    as task;
import '../../../components/color_comp.dart';
import '../../../utility/string_router_util.dart';
import '../../assignment/data/task_list_response_model.dart';

class ButtonNext1Widget extends StatelessWidget {
  const ButtonNext1Widget(
      {super.key, required this.taskList, required this.date});
  final task.Data taskList;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24, left: 24, right: 24),
      child: InkWell(
        onTap: () {
          DateTime tempDate = DateFormat('dd/MM/yyyy').parse(date);
          var inputDate = DateTime.parse(tempDate.toString());
          var outputFormat = DateFormat('yyyy-MM-dd');
          var outputDate = outputFormat.format(inputDate);
          Navigator.pushNamed(context, StringRouterUtil.form2ScreenRoute,
              arguments: Data(
                  code: taskList.code!,
                  date: outputDate,
                  status: taskList.status!,
                  remark: taskList.remark,
                  result: taskList.result,
                  picCode: taskList.picCode!,
                  picName: taskList.picName!,
                  branchName: taskList.branchName!,
                  agreementNo: taskList.agreementNo!,
                  clientName: taskList.clientName!,
                  mobileNo: taskList.mobileNo!,
                  location: taskList.location!,
                  latitude: taskList.latitude!,
                  longitude: taskList.longitude!,
                  type: taskList.type!,
                  appraisalAmount: taskList.appraisalAmount,
                  reviewRemark: taskList.reviewRemark,
                  modDate: taskList.modDate!));
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
