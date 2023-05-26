import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_survey/feature/login/screen/login_screen.dart';

import 'components/color_comp.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Survey',
      theme: ThemeData(
          primaryColor: primaryColor,
          textTheme:
              GoogleFonts.notoSansTextTheme(Theme.of(context).textTheme)),
      home: const LoginScreen(),
    );
  }
}
