import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_data_model.dart';
import 'package:mobile_survey/feature/form_survey_1/screen/form_survey_1_screen.dart';
import 'package:mobile_survey/feature/form_survey_2/data/args_submit_data_model.dart';
import 'package:mobile_survey/feature/form_survey_2/data/question_list_response_model.dart';
import 'package:mobile_survey/feature/form_survey_2/widget/search_dropdown_widget.dart';
import 'package:mobile_survey/feature/form_survey_3/data/args_preview_attachment_model.dart';
import 'package:mobile_survey/feature/form_survey_3/screen/preview_image_asset.dart';
import 'package:mobile_survey/feature/form_survey_3/screen/preview_image_network.dart';
import 'package:mobile_survey/feature/form_survey_3/screen/preview_pdf_network.dart';
import 'package:mobile_survey/feature/form_survey_3/screen/take_picture_screen.dart';
import 'package:mobile_survey/feature/form_survey_5/screen/form_survey_5_screen.dart';
import 'package:mobile_survey/feature/inbox/screen/inbox_screen.dart';
import 'package:mobile_survey/feature/login/screen/login_screen.dart';
import 'package:mobile_survey/feature/relogin/screen/relogin_screen.dart';
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

      case StringRouterUtil.reloginScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const ReLoginScreen(),
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
        final TaskList taskList = settings.arguments as TaskList;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => FormSurvey1Screen(taskList: taskList),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form2ScreenRoute:
        final TaskList taskList = settings.arguments as TaskList;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => FormSurvey2Screen(taskList: taskList),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form3ScreenRoute:
        final ArgsSubmitDataModel argsSubmitDataModel =
            settings.arguments as ArgsSubmitDataModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                FormSurvey3Screen(argsSubmitDataModel: argsSubmitDataModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.formTakePicScreenRoute:
        final CameraDescription camera =
            settings.arguments as CameraDescription;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => TakePicture(camera: camera),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.previewImageAssetScreenRoute:
        final String imagePath = settings.arguments as String;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                PreviewImageAssetScreen(imagePath: imagePath),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.previewImageNetworkScreenRoute:
        final ArgsPreviewAttachmentModel argsPreviewAttachmentModel =
            settings.arguments as ArgsPreviewAttachmentModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                PreviewImageNetworkScreen(argsPreviewAttachmentModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.previewPdfNetworkScreenRoute:
        final ArgsPreviewAttachmentModel argsPreviewAttachmentModel =
            settings.arguments as ArgsPreviewAttachmentModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                PreviewPdfNetworkScreen(argsPreviewAttachmentModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form4ScreenRoute:
        final ArgsSubmitDataModel argsSubmitDataModel =
            settings.arguments as ArgsSubmitDataModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                FormSurvey4Screen(argsSubmitDataModel: argsSubmitDataModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.form5ScreenRoute:
        final ArgsSubmitDataModel argsSubmitDataModel =
            settings.arguments as ArgsSubmitDataModel;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                FormSurvey5Screen(argsSubmitDataModel: argsSubmitDataModel),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.searchDropdownScreenRoute:
        final List<AnswerChoice> answerChoice =
            settings.arguments as List<AnswerChoice>;
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) =>
                SearchDropDownWidget(answerChoice: answerChoice),
            settings: RouteSettings(name: settings.name),
            transitionsBuilder: (_, Animation<double> a, __, Widget c) =>
                FadeTransition(opacity: a, child: c));

      case StringRouterUtil.inboxScreenRoute:
        return PageRouteBuilder<dynamic>(
            pageBuilder: (_, __, ___) => const InboxScreen(),
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
