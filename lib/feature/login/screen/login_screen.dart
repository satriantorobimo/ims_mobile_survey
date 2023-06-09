import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/login/widget/content_login_widget.dart';

import '../widget/header_login_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SingleChildScrollView(
        child: Column(
          children: const [HeaderLoginWidget(), ContentLoginWidget()],
        ),
      ),
    );
  }
}
