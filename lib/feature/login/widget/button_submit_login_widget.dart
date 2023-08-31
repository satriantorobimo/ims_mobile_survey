import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_survey/feature/login/bloc/login_bloc/bloc.dart';
import 'package:mobile_survey/feature/login/data/login_request_model.dart';
import 'package:mobile_survey/feature/login/data/login_response_model.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';
import 'package:mobile_survey/feature/login/domain/repo/login_repo.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import 'package:provider/provider.dart';
import '../../../components/color_comp.dart';
import '../../../utility/string_content_util.dart';
import '../provider/login_provider.dart';

class ButtonSubmitLoginWidget extends StatefulWidget {
  const ButtonSubmitLoginWidget({
    super.key,
  });

  @override
  State<ButtonSubmitLoginWidget> createState() =>
      _ButtonSubmitLoginWidgetState();
}

class _ButtonSubmitLoginWidgetState extends State<ButtonSubmitLoginWidget>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  LoginBloc loginBloc = LoginBloc(loginRepo: LoginRepo());

  @override
  void dispose() {
    animationController!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    super.initState();
  }

  void _userNotRegister() {
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
                'Device belum terdaftar',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Mohon hubungi atasan anda',
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

  void _userPassNotFilled() {
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
                'Username/password tidak boleh kosong',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF575551)),
              ),
              SizedBox(height: 8),
              Text(
                'Mohon periksa ulang dan coba lagi',
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

  Future<void> _processDb(Datalist datalist) async {
    final database =
        await $FloorAppDatabase.databaseBuilder('mobile_survey.db').build();
    final personDao = database.userDao;
    final user = User(
        branchCode: datalist.branchCode ?? '',
        branchName: datalist.branchName ?? '',
        companyCode: datalist.companyCode ?? '',
        companyName: datalist.companyName ?? '',
        deviceId: datalist.deviceId ?? '',
        id: 0,
        idpp: datalist.idpp ?? '',
        name: datalist.name ?? '',
        systemDate: datalist.systemDate ?? '',
        ucode: datalist.ucode ?? '');
    await personDao.findUserById(0).then((value) async {
      if (value == null) {
        await personDao.insertUser(user);
      } else {
        await personDao.deleteUserById(0);
        await personDao.insertUser(user);
      }
    });

    database.close();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
        bloc: loginBloc,
        listener: (_, LoginState state) {
          if (state is LoginLoading) {
            _loginAttempt(context);
          }
          if (state is LoginLoaded) {
            Navigator.pop(context);
            if (state.loginResponseModel.datalist != null) {
              try {
                _processDb(state.loginResponseModel.datalist![0]).then((value) {
                  final LoginProvider loginProdiver =
                      Provider.of<LoginProvider>(context, listen: false);
                  SharedPrefUtil.saveSharedString(
                      'username', loginProdiver.username);
                  SharedPrefUtil.saveSharedString(
                      'token', state.loginResponseModel.token!);
                  Navigator.pushNamedAndRemoveUntil(context,
                      StringRouterUtil.tabScreenRoute, (route) => false);
                });
              } catch (e) {
                log(e.toString());
                _errorSystem();
              }
            } else {
              _userNotRegister();
            }
          }
          if (state is LoginError) {
            Navigator.pop(context);
            _showModals(state.error!);
          }
          if (state is LoginException) {
            Navigator.pop(context);
            _errorSystem();
          }
        },
        child: BlocBuilder(
            bloc: loginBloc,
            builder: (_, LoginState state) {
              return mainContent(context);
            }));
  }

  Widget mainContent(BuildContext context) {
    return InkWell(
      onTap: () {
        final LoginProvider loginProdiver =
            Provider.of<LoginProvider>(context, listen: false);

        if (loginProdiver.username.isEmpty || loginProdiver.password.isEmpty) {
          _userPassNotFilled();
        } else {
          loginBloc.add(LoginAttempt(
              loginRequestModel: LoginRequestModel(
                  loginProdiver.username, loginProdiver.password, 'abc123')));
        }
      },
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text(StringContentUtil.loginButtonTitle,
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}
