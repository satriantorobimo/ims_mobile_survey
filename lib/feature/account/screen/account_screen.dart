import 'package:flutter/material.dart';
import '../widget/button_keluar_widget.dart';
import '../widget/main_content_widget.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
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
              children: const [
                MainContentWidget(
                    title: 'Nama User', content: 'Rahmat Darmawan'),
                SizedBox(
                  height: 24,
                ),
                MainContentWidget(
                    title: 'Email', content: 'rahmat.darmawan@mail.com'),
                SizedBox(
                  height: 24,
                ),
                MainContentWidget(
                    title: 'Device ID',
                    content: 'hsfw34g8397hfigfiw77342g3t89fie'),
                SizedBox(
                  height: 24,
                ),
                MainContentWidget(title: 'Version', content: 'v1.0.0+01'),
                SizedBox(
                  height: 32,
                ),
                ButtonKeluarWidget()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
