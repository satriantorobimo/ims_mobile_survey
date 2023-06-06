import 'package:flutter/material.dart';
import '../widget/button_submit_widget.dart';
import '../widget/main_content_widget.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.circle,
              color: Color(0xFF5DEA51),
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
        child: Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 12);
              },
              scrollDirection: Axis.vertical,
              itemCount: 25,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                if (index == 25 - 1) {
                  return const ButtonSubmitWidget();
                }
                return const MainContentWidget();
              }),
        ),
      ),
    );
  }
}
