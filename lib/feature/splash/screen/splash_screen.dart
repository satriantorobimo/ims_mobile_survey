import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import '../../../utility/string_content_util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _goToLogin();
    super.initState();
  }

  void _goToLogin() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamedAndRemoveUntil(
          context, StringRouterUtil.loginScreenRoute, (route) => false);
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
