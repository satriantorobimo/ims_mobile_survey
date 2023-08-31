import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_grid_comp.dart';
import 'package:mobile_survey/feature/inbox/bloc/inbox_bloc/bloc.dart';
import 'package:mobile_survey/feature/inbox/domain/repo/inbox_repo.dart';
import 'package:mobile_survey/utility/connection_provider.dart';
import 'package:mobile_survey/utility/network_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import '../widget/main_content_widget.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  InboxBloc inboxBloc = InboxBloc(inboxRepo: InboxRepo());
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();

  @override
  void initState() {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      if (value) {
        inboxBloc.add(const InboxAttempt());
      } else {
        log('No Connection');
      }
    });

    super.initState();
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
                      child: ListView.separated(
                          shrinkWrap: true,
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                          scrollDirection: Axis.vertical,
                          itemCount: state.inboxResponseModel.data!.length,
                          itemBuilder: (context, index) {
                            return MainContentWidget(
                                data: state.inboxResponseModel.data![index]);
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
