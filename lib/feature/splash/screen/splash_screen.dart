import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/general_util.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    GeneralUtil.getDeviceId().then((value) => log('Device Id $value'));
    GeneralUtil.getIpAddress().then((value) => log('IP $value'));
    _goToLogin();
    super.initState();
  }

  void _goToLogin() {
    SharedPrefUtil.getSharedString('token').then((value) {
      if (value != null) {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, StringRouterUtil.tabScreenRoute, (route) => false);
        });
      } else {
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushNamedAndRemoveUntil(
              context, StringRouterUtil.loginScreenRoute, (route) => false);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(),
          Center(
              child: Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).size.width * 0.65,
          )),
          const Align(
            alignment: Alignment.center,
            child: Text(
              'Version 1.0.0+22',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          )
        ],
      ),
    );
  }
}
