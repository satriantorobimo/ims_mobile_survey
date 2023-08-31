import 'package:flutter/material.dart';
import 'package:mobile_survey/components/loading_comp.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/utility/database_util.dart';
import '../widget/button_keluar_widget.dart';
import '../widget/main_content_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  late User userData;
  bool isLoading = true;
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final personDao = database.userDao;
    final user = await personDao.findUserById(0);
    setState(() {
      userData = user!;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Account',
          style: TextStyle(
              fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
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
                isLoading
                    ? const LoadingComp(
                        height: 60,
                        padding: 0,
                      )
                    : MainContentWidget(
                        title: 'Nama User', content: userData.name),
                const SizedBox(
                  height: 24,
                ),
                isLoading
                    ? const LoadingComp(
                        height: 60,
                        padding: 0,
                      )
                    : MainContentWidget(
                        title: 'Company', content: userData.companyName),
                const SizedBox(
                  height: 24,
                ),
                isLoading
                    ? const LoadingComp(
                        height: 60,
                        padding: 0,
                      )
                    : MainContentWidget(
                        title: 'Branch', content: userData.branchName),
                const SizedBox(
                  height: 24,
                ),
                isLoading
                    ? const LoadingComp(
                        height: 60,
                        padding: 0,
                      )
                    : MainContentWidget(
                        title: 'Device ID', content: userData.deviceId),
                const SizedBox(
                  height: 24,
                ),
                const MainContentWidget(title: 'Version', content: 'v1.0.0+01'),
                const SizedBox(
                  height: 32,
                ),
                const ButtonKeluarWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
