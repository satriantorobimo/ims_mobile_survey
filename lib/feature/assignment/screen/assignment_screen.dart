import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/assignment/provider/assignment_provider.dart';
import 'package:mobile_survey/feature/assignment/widget/list_view_assignment_widget.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:provider/provider.dart';

class AssignmentScreen extends StatefulWidget {
  const AssignmentScreen({super.key});

  @override
  State<AssignmentScreen> createState() => _AssignmentScreenState();
}

class _AssignmentScreenState extends State<AssignmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _tabs = const [
    Tab(text: 'Ongoing'),
    Tab(text: 'Waiting'),
    Tab(text: 'Returned'),
    Tab(text: 'Selesai'),
  ];

  List<TaskList> ongoing = [];
  List<TaskList> waiting = [];
  List<TaskList> returned = [];
  List<TaskList> done = [];

  bool isLoading = true;

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

    await taskListDao.findAllTaskList().then((value) async {
      for (int i = 0; i < value.length; i++) {
        if (value[i]!.status == 'ASSIGN') {
          setState(() {
            ongoing.add(value[i]!);
          });
        } else if (value[i]!.status == 'DONE') {
          setState(() {
            done.add(value[i]!);
          });
        } else if (value[i]!.status == 'RETURN') {
          setState(() {
            returned.add(value[i]!);
          });
        } else if (value[i]!.status == 'WAITING') {
          setState(() {
            waiting.add(value[i]!);
          });
        }
      }
    });

    setState(() {
      isLoading = false;
      database.close();
    });
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
                      unselectedLabelColor: const Color(0xFFFECCCC),
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
                    physics: const NeverScrollableScrollPhysics(),
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
