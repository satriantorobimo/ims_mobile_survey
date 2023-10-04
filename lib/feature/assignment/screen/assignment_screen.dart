import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/assignment/provider/assignment_provider.dart';
import 'package:mobile_survey/feature/assignment/widget/list_view_assignment_widget.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:provider/provider.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key, required this.tabNumber});
  final int tabNumber;

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const [
    Tab(text: 'Assign'),
    Tab(text: 'Waiting'),
    Tab(text: 'Return'),
    Tab(text: 'Done'),
  ];

  List<TaskList> ongoing = [];
  List<TaskList> waiting = [];
  List<TaskList> returned = [];
  List<TaskList> done = [];

  bool isLoading = true;

  String filter = '';

  final _filter = const ['Survey', 'Appraisal'];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);

    _sortingData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  Future<void> _sortingData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;

    List<TaskList> ongoingTemp = [];
    List<TaskList> waitingTemp = [];
    List<TaskList> returnedTemp = [];
    List<TaskList> doneTemp = [];

    await taskListDao.findAllTaskList().then((value) async {
      for (int i = 0; i < value.length; i++) {
        if (value[i]!.status == 'ASSIGN') {
          ongoingTemp.add(value[i]!);
        } else if (value[i]!.status == 'DONE') {
          doneTemp.add(value[i]!);
        } else if (value[i]!.status == 'RETURN') {
          returnedTemp.add(value[i]!);
        } else if (value[i]!.status == 'WAITING') {
          waitingTemp.add(value[i]!);
        }

        if (i == value.length - 1) {
          setState(() {
            ongoing = ongoingTemp.map((ongoing) => ongoing).toList()
              ..sort((a, b) =>
                  DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

            done = doneTemp.map((done) => done).toList()
              ..sort((a, b) =>
                  DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));

            returned = returnedTemp.map((returned) => returned).toList()
              ..sort((a, b) =>
                  DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
            waiting = waitingTemp.map((waiting) => waiting).toList()
              ..sort((a, b) =>
                  DateTime.parse(a.date).compareTo(DateTime.parse(b.date)));
          });
        }
      }
    });

    setState(() {
      _tabController.index = widget.tabNumber;
      isLoading = false;
      database.close();
    });
  }

  void _filterAction(int index) {
    var assignmentProvider =
        Provider.of<AssignmentProvider>(context, listen: false);
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, stfSetState) {
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
                const Text(
                  'Assignment Filter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF575551)),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 50.0,
                  child: RadioGroup<String>.builder(
                    direction: Axis.horizontal,
                    groupValue: assignmentProvider.filter,
                    horizontalAlignment: MainAxisAlignment.spaceAround,
                    onChanged: (values) {
                      stfSetState(() {
                        assignmentProvider.setFilter(values!);
                      });
                    },
                    activeColor: primaryColor,
                    items: _filter,
                    textStyle: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF2D2A26),
                    ),
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  ),
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
              const SizedBox(height: 16),
              InkWell(
                onTap: () {
                  assignmentProvider.setFilter('');
                  isLoading = true;
                  ongoing = [];
                  waiting = [];
                  returned = [];
                  done = [];
                  _sortingData();
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 45,
                  decoration: BoxDecoration(
                    color: fifthColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Center(
                      child: Text('Clear Filter',
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.w600))),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: const Text(
            'Assignment',
            style: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
          ),
          actions: [
            InkWell(
              onTap: () {
                _filterAction(_tabController.index);
              },
              child: const Padding(
                padding: EdgeInsets.only(right: 16.0, top: 16.0),
                child: Text(
                  'Filter',
                  style: TextStyle(
                      fontSize: 14,
                      color: primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
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
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Container(
                    height: kToolbarHeight - 8.0,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TabBar(
                      labelStyle: const TextStyle(fontSize: 12),
                      controller: _tabController,
                      indicator: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: primaryColor),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.black,
                      tabs: _tabs,
                      onTap: (value) {
                        var assignmentProvider =
                            Provider.of<AssignmentProvider>(context,
                                listen: false);
                        assignmentProvider.setIndex(value);
                        if (value == 0) {
                          assignmentProvider.setLength(3);
                        } else if (value == 1) {
                          assignmentProvider.setLength(2);
                        } else if (value == 2) {
                          assignmentProvider.setLength(5);
                        } else {
                          assignmentProvider.setLength(1);
                        }
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      isLoading
                          ? Container()
                          : ListViewAssignmentWidget(taskList: ongoing),
                      ListViewAssignmentWidget(taskList: waiting),
                      ListViewAssignmentWidget(taskList: returned),
                      ListViewAssignmentWidget(taskList: done),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
