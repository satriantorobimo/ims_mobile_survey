import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/relogin/widget/content_login_widget.dart';
import 'package:mobile_survey/feature/relogin/widget/header_login_widget.dart';

class ReLoginScreen extends StatefulWidget {
  const ReLoginScreen({super.key});

  @override
  State<ReLoginScreen> createState() => _ReLoginScreenState();
}

class _ReLoginScreenState extends State<ReLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: const Color(0xFFF9F9F9),
        body: SingleChildScrollView(
          child: Column(
            children: const [HeaderLoginWidget(), ContentLoginWidget()],
          ),
        ),
      ),
    );
  }
}
