import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';
import 'package:mobile_survey/feature/assignment/provider/assignment_provider.dart';
import 'package:mobile_survey/feature/assignment/widget/list_view_assignment_widget.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import 'package:provider/provider.dart';

import '../bloc/task_list_bloc/bloc.dart';

class AssignmentOnlineScreen extends StatefulWidget {
  const AssignmentOnlineScreen({super.key, required this.tabNumber});
  final int tabNumber;

  @override
  State<AssignmentOnlineScreen> createState() => _AssignmentOnlineScreenState();
}

class _AssignmentOnlineScreenState extends State<AssignmentOnlineScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;
  AnimationController? animationController;
  TaskListBloc taskListBloc = TaskListBloc(taskListRepo: TaskListRepo());
  final _tabs = const [
    Tab(text: 'Assign'),
    Tab(text: 'Waiting'),
    Tab(text: 'Return'),
    Tab(text: 'Done'),
  ];

  List<Data> ongoing = [];
  List<Data> waiting = [];
  List<Data> returned = [];
  List<Data> done = [];
  List<Data> taskListData = [];
  bool isLoading = true;

  String filter = '';

  final _filter = const ['Survey', 'Appraisal'];

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    taskListBloc.add(const TaskListAttempt());
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _sortingData() async {
    List<Data> ongoingTemp = [];
    List<Data> waitingTemp = [];
    List<Data> returnedTemp = [];
    List<Data> doneTemp = [];
    for (int i = 0; i < taskListData.length; i++) {
      if (taskListData[i].status == 'ASSIGN') {
        ongoingTemp.add(taskListData[i]);
      } else if (taskListData[i].status == 'DONE') {
        doneTemp.add(taskListData[i]);
      } else if (taskListData[i].status == 'RETURN') {
        returnedTemp.add(taskListData[i]);
      } else if (taskListData[i].status == 'WAITING') {
        waitingTemp.add(taskListData[i]);
      }

      if (i == taskListData.length - 1) {
        setState(() {
          ongoing = ongoingTemp.map((ongoing) => ongoing).toList()
            ..sort((a, b) => DateTime.parse(b.modDate!)
                .compareTo(DateTime.parse(a.modDate!)));

          done = doneTemp.map((done) => done).toList()
            ..sort((a, b) => DateTime.parse(b.modDate!)
                .compareTo(DateTime.parse(a.modDate!)));

          returned = returnedTemp.map((returned) => returned).toList()
            ..sort((a, b) => DateTime.parse(b.modDate!)
                .compareTo(DateTime.parse(a.modDate!)));
          waiting = waitingTemp.map((waiting) => waiting).toList()
            ..sort((a, b) => DateTime.parse(b.modDate!)
                .compareTo(DateTime.parse(a.modDate!)));
        });
      }
    }

    setState(() {
      log('$ongoing');
      _tabController.index = widget.tabNumber;
      isLoading = false;
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
                'Silahkan Login ulang',
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
                        context, StringRouterUtil.reloginScreenRoute)
                    .then((value) {
                  taskListBloc.add(const TaskListAttempt());
                });
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

  void _loadingData(BuildContext context) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: false,
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
                'Sedang mengambil data',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              const SizedBox(height: 8),
              const Text(
                'Mohon menunggu sebentar',
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
                    child: Text('Batalkan',
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
                MultiBlocListener(
                    listeners: [
                      BlocListener(
                        bloc: taskListBloc,
                        listener: (_, TaskListState state) async {
                          if (state is TaskListLoading) {
                            _loadingData(context);
                          }
                          if (state is TaskListLoaded) {
                            taskListData
                                .addAll(state.taskListResponseModel.data!);
                            await _sortingData();

                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                          if (state is TaskListError) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                          if (state is TaskListException) {
                            if (state.error == 'expired') {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              _sessionExpired();
                            }
                          }
                        },
                      )
                    ],
                    child: Expanded(
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
                    ))
              ],
            ),
          ),
        ));
  }
}
