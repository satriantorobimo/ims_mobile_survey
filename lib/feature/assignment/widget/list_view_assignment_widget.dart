import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/assignment/widget/card_widget.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider/assignment_provider.dart';

class ListViewAssignmentWidget extends StatefulWidget {
  const ListViewAssignmentWidget({super.key, required this.taskList});
  final List<TaskList> taskList;

  @override
  State<ListViewAssignmentWidget> createState() =>
      _ListViewAssignmentWidgetState();
}

class _ListViewAssignmentWidgetState extends State<ListViewAssignmentWidget> {
  void _showDetail(TaskList taskList) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 80,
                    height: 5,
                    decoration: const BoxDecoration(
                        color: Color(0xFFBBB9B5),
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Assignment Detail',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2D2A26)),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Customer',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            taskList.clientName,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF575551)),
                          ),
                          Text(
                            taskList.type,
                            style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFF575551)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Agreement No:',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        taskList.agreementNo,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF575551)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Phone Number',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showActionHubungi(taskList.mobileNo);
                      },
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          taskList.mobileNo,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1872FA)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: const Text(
                        'Location Category',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF575551)),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        taskList.location,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF575551)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                        context, StringRouterUtil.form1ScreenRoute,
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
                        child: Text('Lakukan Survey',
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.white,
                                fontWeight: FontWeight.w600))),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        });
  }

  Future<void> _launchUrl(String urlValue) async {
    Uri url = Uri.parse(urlValue);

    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchUrlBrowser(String urlValue) async {
    Uri url = Uri.parse(urlValue);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  void _showActionHubungi(String phone) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        builder: (context) {
          return Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: 80,
                        height: 5,
                        decoration: const BoxDecoration(
                            color: Color(0xFFBBB9B5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Hubungi via',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF2D2A26)),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            _launchUrl('tel://$phone');
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icon/phone.png', width: 64),
                                const SizedBox(height: 16),
                                const Text(
                                  'Panggilan (phone)',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF575551)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _launchUrlBrowser(
                                'https://api.whatsapp.com/send/?phone=$phone');
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.35,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset('assets/icon/wa.png', width: 64),
                                const SizedBox(height: 16),
                                const Text(
                                  'Text (WhatsApp)',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Color(0xFF575551)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
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
                            child: Text('Tutup',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600))),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ]));
        });
  }

  @override
  Widget build(BuildContext context) {
    var assignmentProvider =
        Provider.of<AssignmentProvider>(context, listen: true);
    List<TaskList> task = [];

    if (assignmentProvider.filter == 'Survey') {
      task.addAll(widget.taskList);
      task.removeWhere((element) => element.type == 'APPRAISAL');
    } else if (assignmentProvider.filter == 'Appraisal') {
      task.addAll(widget.taskList);
      task.removeWhere((element) => element.type == 'SURVEY');
    } else {
      task.addAll(widget.taskList);
    }
    return Padding(
        padding: const EdgeInsets.only(top: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (task.isEmpty) ...[
                const Center(
                  child: Text(
                    'Tidak Ada Data',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF575551)),
                  ),
                )
              ] else ...[
                ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: task.length,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 24),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          _showDetail(task[index]);
                        },
                        child: assignmentProvider.index == 0
                            ? CardWidget(
                                color: secondaryColor,
                                colorBg: secondaryColor.withOpacity(0.4),
                                label: task[index].status,
                                name: task[index].clientName,
                                taskList: task[index],
                              )
                            : assignmentProvider.index == 1
                                ? CardWidget(
                                    color: primaryColor,
                                    colorBg: const Color(0xFFFECCCC),
                                    label: task[index].status,
                                    name: task[index].clientName,
                                    taskList: task[index],
                                  )
                                : assignmentProvider.index == 2
                                    ? CardWidget(
                                        color: thirdColor,
                                        colorBg: thirdColor.withOpacity(0.4),
                                        label: task[index].status,
                                        name: task[index].clientName,
                                        taskList: task[index],
                                      )
                                    : CardWidget(
                                        color: fifthColor,
                                        colorBg: fifthColor.withOpacity(0.4),
                                        label: task[index].status,
                                        name: task[index].clientName,
                                        taskList: task[index],
                                      ),
                      );
                    }),
              ]
            ],
          ),
        ));
  }
}
