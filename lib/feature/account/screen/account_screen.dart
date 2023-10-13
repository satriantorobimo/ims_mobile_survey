import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/components/color_comp.dart';
import 'package:mobile_survey/components/loading_comp.dart';
import 'package:mobile_survey/feature/account/bloc/logout_bloc/bloc.dart';
import 'package:mobile_survey/feature/account/domain/repo/logout_repo.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/utility/database_helper.dart';
import 'package:mobile_survey/utility/firebase_notification_service.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import '../widget/button_keluar_widget.dart';
import '../widget/main_content_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  late User userData;
  bool isLoading = true;
  LogoutBloc logoutBloc = LogoutBloc(logoutRepo: LogoutRepo());
  String? version = '';
  String? buildNumber = '';

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    getVersion();
    getUserData();
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  Future<void> getVersion() async {
    version = await SharedPrefUtil.getSharedString('version');
    buildNumber = await SharedPrefUtil.getSharedString('buildnumber');
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

  void _warningLogout() {
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
              Center(
                child: Icon(
                  Icons.warning_amber_outlined,
                  color: Color.fromARGB(255, 236, 233, 26),
                  size: 80,
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Logout',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 16),
              Text(
                'Apakah anda ingin Logout sekarang?',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF575551)),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () async {
                      Navigator.pop(context);
                      logoutBloc.add(const LogoutAttempt());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 45,
                      decoration: BoxDecoration(
                        color: thirdColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                          child: Text('Ya',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.35,
                      height: 45,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: const Center(
                          child: Text('Tidak',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600))),
                    ),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _showModals(String message) {
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
            children: [
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
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
                    child: Text('Tutup',
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

  void _errorSystem() {
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
                'Terjadi kesalahan sistem',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Mohon coba beberapa saat lagi',
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
                    child: Text('Tutup',
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

  void _loginAttempt(BuildContext context) {
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
                logoutBloc.close();
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
                MainContentWidget(
                    title: 'Version', content: 'v$version+$buildNumber'),
                const SizedBox(
                  height: 32,
                ),
                BlocListener(
                    bloc: logoutBloc,
                    listener: (_, LogoutState state) {
                      if (state is LogoutLoading) {
                        _loginAttempt(context);
                      }
                      if (state is LogoutLoaded) {
                        SharedPrefUtil.deleteSharedPref('token')
                            .then((value) async {
                          //delete user
                          await DatabaseHelper.deleteUser(1);
                          final FirebaseNotificationService
                              firebaseNotificationService =
                              FirebaseNotificationService();
                          final String? username =
                              await SharedPrefUtil.getSharedString('username');
                          await firebaseNotificationService
                              .fcmUnSubscribe(username!);
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(
                              context,
                              StringRouterUtil.loginScreenRoute,
                              (route) => false);
                        });
                      }
                      if (state is LogoutError) {
                        Navigator.pop(context);
                        _showModals(state.error!);
                      }
                      if (state is LogoutException) {
                        Navigator.pop(context);
                        _errorSystem();
                      }
                    },
                    child: BlocBuilder(
                        bloc: logoutBloc,
                        builder: (_, LogoutState state) {
                          return ButtonKeluarWidget(onPressed: () {
                            _warningLogout();
                          });
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
