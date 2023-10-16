import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_comp.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/assignment/bloc/task_list_bloc/bloc.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';
import 'package:mobile_survey/feature/assignment/domain/repo/task_list_repo.dart';
import 'package:mobile_survey/feature/home/widget/header_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/main_content_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/user_info_home_widget.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/utility/database_helper.dart';
import 'package:mobile_survey/utility/network_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

class HomeOnlineScreen extends StatefulWidget {
  const HomeOnlineScreen({super.key});

  @override
  State<HomeOnlineScreen> createState() => _HomeOnlineScreenState();
}

class _HomeOnlineScreenState extends State<HomeOnlineScreen>
    with TickerProviderStateMixin {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  AnimationController? animationController;
  TaskListBloc taskListBloc = TaskListBloc(taskListRepo: TaskListRepo());
  List<Data> taskListData = [];
  late User userData;
  bool isLoading = true,
      isLoadingListData = true,
      isExpired = false,
      isFirstTime = true;
  int ongoing = 0;
  int returned = 0;
  int done = 0;
  int countQuestion = 0, countAttachment = 0, countReference = 0;
  @override
  void initState() {
    taskListBloc.add(const TaskListAttempt());

    getUserData();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      isFirstTime = false;
      isLoading = true;
      isLoadingListData = true;
      ongoing = 0;
      returned = 0;
      done = 0;
      taskListData = [];
    });
    taskListBloc.add(const TaskListAttempt());
    getUserData();
  }

  Future<void> getUserData() async {
    final data = await DatabaseHelper.getUserData(1);

    setState(() {
      userData = User(
          ucode: data[0]['ucode'],
          id: data[0]['id'],
          name: data[0]['name'],
          systemDate: data[0]['system_date'],
          branchCode: data[0]['branch_code'],
          branchName: data[0]['branch_name'],
          idpp: data[0]['idpp'],
          companyCode: data[0]['company_code'],
          companyName: data[0]['company_name'],
          deviceId: data[0]['device_id']);
      isLoading = false;
    });
  }

  Future<void> _sortingData() async {
    for (int i = 0; i < taskListData.length; i++) {
      if (taskListData[i].status == 'ASSIGN') {
        setState(() {
          ongoing++;
        });
      } else if (taskListData[i].status == 'DONE') {
        setState(() {
          done++;
        });
      } else if (taskListData[i].status == 'RETURN') {
        setState(() {
          returned++;
        });
      }
    }
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
                    .then((value) => _pullRefresh());
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
      body: RefreshIndicator(
        onRefresh: _pullRefresh,
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Colors.white, Color(0xFFf9f9f9)],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const HeaderHomeWidget(),
                  const SizedBox(height: 32),
                  isLoading
                      ? const LoadingComp(
                          height: 80,
                          padding: 58,
                        )
                      : UserInfoHomeWidget(user: userData),
                  MultiBlocListener(
                      listeners: [
                        BlocListener(
                          bloc: taskListBloc,
                          listener: (_, TaskListState state) async {
                            if (state is TaskListLoading) {
                              setState(() {
                                isLoadingListData = true;
                              });
                              _loadingData(context);
                            }
                            if (state is TaskListLoaded) {
                              taskListData
                                  .addAll(state.taskListResponseModel.data!);
                              await _sortingData();
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is TaskListError) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            }
                            if (state is TaskListException) {
                              setState(() {
                                isLoadingListData = false;
                              });
                              if (state.error == 'expired') {
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                                _sessionExpired();
                              }
                            }
                          },
                        )
                      ],
                      child: isLoadingListData
                          ? const LoadingGridComp(
                              height: 110,
                              length: 3,
                            )
                          : isExpired
                              ? Container()
                              : MainContentHomeWidget(
                                  done: done,
                                  ongoing: ongoing,
                                  returned: returned,
                                )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget errorSystem() {
    return Padding(
      padding: const EdgeInsets.only(top: 100.0),
      child: Column(children: [
        const Icon(
          Icons.warning_amber_outlined,
          size: 60,
          color: fourthColor,
        ),
        const Text(
          'Terjadi Kesalahan System',
          style: TextStyle(
              fontSize: 22, color: Colors.black, fontWeight: FontWeight.w700),
        ),
        const Text(
          'Silahkan coba beberapa saat lagi',
          style: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        InkWell(
          onTap: () {
            taskListBloc.add(const TaskListAttempt());
          },
          child: Container(
            width: 100,
            height: 45,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Center(
                child: Text('Coba Lagi',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w600))),
          ),
        ),
      ]),
    );
  }
}
