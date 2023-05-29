import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/home/widget/header_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/main_content_home_widget.dart';
import 'package:mobile_survey/feature/home/widget/user_info_home_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: const [
                HeaderHomeWidget(),
                SizedBox(height: 32),
                UserInfoHomeWidget(),
                SizedBox(height: 24),
                MainContentHomeWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
