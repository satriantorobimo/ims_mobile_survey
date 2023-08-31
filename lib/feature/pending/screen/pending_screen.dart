import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/network_util.dart';
import '../widget/main_content_widget.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  List<TaskList> pending = [];
  bool isLoading = true, isConnect = false;
  Future<void> _getData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final taskListDao = database.taskListDao;

    await taskListDao.findTaskListByStatus('PENDING').then((value) async {
      for (int i = 0; i < value.length; i++) {
        setState(() {
          pending.add(value[i]!);
        });
      }
    });

    setState(() {
      isLoading = false;
      database.close();
    });
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  Future<void> _pullRefresh() async {
    NetworkInfo(internetConnectionChecker).isConnected.then((value) {
      setState(() {
        isLoading = true;
        pending = [];
        _getData();
      });
      if (value) {
        setState(() {
          isConnect = true;
        });
      } else {
        setState(() {
          isConnect = false;
        });
      }
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.circle,
              color: isConnect ? const Color(0xFF5DEA51) : Colors.red,
            ),
          )
        ],
        title: const Text(
          'Pending',
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
        child: isLoading
            ? Container()
            : RefreshIndicator(
                onRefresh: _pullRefresh,
                child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 12);
                    },
                    scrollDirection: Axis.vertical,
                    itemCount: pending.length,
                    padding: const EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      return MainContentWidget(taskList: pending[index]);
                    }),
              ),
      ),
    );
  }
}
