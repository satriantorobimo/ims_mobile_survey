import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/database_util.dart';
import 'package:mobile_survey/utility/firebase_notification_service.dart';
import 'package:mobile_survey/utility/shared_pref_util.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

import '../../../components/color_comp.dart';

class ButtonKeluarWidget extends StatelessWidget {
  const ButtonKeluarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
          onPressed: () async {
            SharedPrefUtil.deleteSharedPref('token').then((value) async {
              final database = await $FloorAppDatabase
                  .databaseBuilder('mobile_survey.db')
                  .build();
              final personDao = database.userDao;
              personDao.deleteUserById(0);
              final FirebaseNotificationService firebaseNotificationService =
                  FirebaseNotificationService();
              final String? username =
                  await SharedPrefUtil.getSharedString('username');
              await firebaseNotificationService.fcmUnSubscribe(username!);
              // ignore: use_build_context_synchronously
              Navigator.pushNamedAndRemoveUntil(
                  context, StringRouterUtil.loginScreenRoute, (route) => false);
            });
          },
          // ignore: sort_child_properties_last
          child: const Text(
            'Keluar',
            style: TextStyle(
                color: sixthColor, fontSize: 14, fontWeight: FontWeight.w700),
          ),
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
            side: MaterialStateProperty.all(const BorderSide(
              color: sixthColor,
            )),
          )),
    );
  }
}
