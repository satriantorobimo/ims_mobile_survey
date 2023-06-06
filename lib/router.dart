import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/form_survey_1/screen/form_survey_1_screen.dart';
import 'package:mobile_survey/feature/login/screen/login_screen.dart';
import 'package:mobile_survey/feature/splash/screen/splash_screen.dart';
import 'package:mobile_survey/feature/tab/screen/tab_bar.dart';

import 'package:mobile_survey/utility/string_router_util.dart';

import 'feature/form_survey_2/screen/form_survey_2_screen.dart';
import 'feature/form_survey_3/screen/form_survey_3_screen.dart';
import 'feature/form_survey_4/screen/form_survey_4_screen.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case StringRouterUtil.splashScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const SplashScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
      case StringRouterUtil.loginScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const LoginScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.tabScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const TabBarScreen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form1ScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const FormSurvey1Screen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form2ScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const FormSurvey2Screen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form3ScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const FormSurvey3Screen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form4ScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const FormSurvey4Screen(),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));
      default:
        return MaterialPageRoute<dynamic>(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
