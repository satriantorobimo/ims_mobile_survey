import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/inbox/bloc/inbox_bloc/bloc.dart';
import 'package:mobile_survey/feature/inbox/domain/repo/inbox_repo.dart';
import 'package:mobile_survey/utility/database_helper.dart';
import 'package:mobile_survey/utility/network_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import '../widget/main_content_widget.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen>
    with TickerProviderStateMixin {
  InboxBloc inboxBloc = InboxBloc(inboxRepo: InboxRepo());
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  AnimationController? animationController;
  late Data taskData;
  @override
  void initState() {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      if (value) {
        inboxBloc.add(const InboxAttempt());
      } else {
        log('No Connection');
      }
    });
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
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      if (value) {
        inboxBloc.add(const InboxAttempt());
      } else {}
    });
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
            bottom: 16,
            left: 16,
            right: 16,
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
            ],
          ),
        );
      },
    );
  }

  Future<void> _getData(String code) async {
    final data = await DatabaseHelper.getSingleTask(code);
    setState(() {
      taskData = Data(
          code: data[0]['code'],
          date: data[0]['date'],
          status: data[0]['status'],
          remark: data[0]['remark'],
          result: data[0]['result'],
          picCode: data[0]['pic_code'],
          picName: data[0]['pic_name'],
          branchName: data[0]['branch_name'],
          agreementNo: data[0]['agreement_no'],
          clientName: data[0]['client_name'],
          mobileNo: data[0]['mobile_no'],
          location: data[0]['location'],
          latitude: data[0]['latitude'],
          longitude: data[0]['longitude'],
          type: data[0]['type'],
          appraisalAmount: data[0]['appraisal_amount'],
          reviewRemark: data[0]['review_remark'],
          modDate: data[0]['mod_date']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Inbox',
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
        child: BlocListener(
            bloc: inboxBloc,
            listener: (_, InboxState state) {
              if (state is InboxLoading) {}
              if (state is InboxLoaded) {}
              if (state is InboxError) {}
              if (state is InboxException) {
                if (state.error == 'expired') {
                  _sessionExpired();
                }
              }
            },
            child: BlocBuilder(
                bloc: inboxBloc,
                builder: (_, InboxState state) {
                  if (state is InboxLoading) {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: LoadingGridComp(height: 100, length: 10),
                    );
                  }

                  if (state is InboxLoaded) {
                    return RefreshIndicator(
                      onRefresh: _pullRefresh,
                      child: state.inboxResponseModel.data!.isEmpty
                          ? const Center(
                              child: Text(
                                'Tidak Ada Data',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF575551)),
                              ),
                            )
                          : ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider();
                              },
                              scrollDirection: Axis.vertical,
                              itemCount: state.inboxResponseModel.data!.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () {
                                    _loadingData(context);
                                    _getData(state.inboxResponseModel
                                            .data![index].taskCode!)
                                        .then((value) {
                                      Navigator.pop(context);
                                      Navigator.pushNamed(context,
                                          StringRouterUtil.form1ScreenRoute,
                                          arguments: taskData);
                                    });
                                  },
                                  child: MainContentWidget(
                                      data: state
                                          .inboxResponseModel.data![index]),
                                );
                              }),
                    );
                  }
                  if (state is InboxError) {
                    return Container();
                  }
                  if (state is InboxException) {
                    return Container();
                  }
                  return Container();
                })),
      ),
    );
  }
}
