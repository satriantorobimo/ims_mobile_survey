import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_survey/feature/assignment/provider/assignment_provider.dart';
import 'package:mobile_survey/feature/form_survey_2/provider/form_2_provider.dart';
import 'package:mobile_survey/feature/login/provider/login_provider.dart';
import 'package:mobile_survey/feature/tab/provider/tab_provider.dart';
import 'package:mobile_survey/router.dart';
import 'package:mobile_survey/utility/connection_provider.dart';
import 'package:mobile_survey/utility/firebase_notification_service.dart';
import 'package:mobile_survey/utility/string_router_util.dart';
import 'package:provider/provider.dart';

import 'components/color_comp.dart';
import 'feature/form_survey_4/provider/form_survey_4_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseNotificationService _firebaseNotificationService =
      FirebaseNotificationService();

  @override
  void initState() {
    handleStartUpNotification();

    super.initState();
  }

  Future<dynamic> handleStartUpNotification() async {
    await _firebaseNotificationService.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => ConnectionProvider()),
        ChangeNotifierProvider(create: (_) => TabProvider()),
        ChangeNotifierProvider(create: (_) => AssignmentProvider()),
        ChangeNotifierProvider(create: (_) => Form2Provider()),
        ChangeNotifierProvider(create: (_) => FormSurvey4Provider())
      ],
      child: MaterialApp(
        title: 'Mobile Survey',
        theme: ThemeData(
            primaryColor: primaryColor,
            textTheme:
                GoogleFonts.nunitoSansTextTheme(Theme.of(context).textTheme)),
        onGenerateRoute: Routers.generateRoute,
        initialRoute: StringRouterUtil.splashScreenRoute,
      ),
    );
  }
}
