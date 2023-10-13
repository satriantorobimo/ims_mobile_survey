import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import 'package:package_info_plus/package_info_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';
  String _buildNumber = '';
  bool isLoading = true;
  @override
  void initState() {
    _getAppVersion();

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

  void _getAppVersion() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final buildNumber = packageInfo.buildNumber;

    SharedPrefUtil.saveSharedString('version', version);
    SharedPrefUtil.saveSharedString('buildnumber', buildNumber);

    setState(() {
      _version = version;
      _buildNumber = buildNumber;
      isLoading = false;
    });

    _goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: isLoading
          ? Container()
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                Center(
                    child: Image.asset(
                  'assets/logo.png',
                  width: MediaQuery.of(context).size.width * 0.65,
                )),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Version $_version+$_buildNumber',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                )
              ],
            ),
    );
  }
}
