import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/login/widget/button_submit_login_widget.dart';
import 'package:mobile_survey/feature/login/widget/email_login_widget.dart';
import 'package:mobile_survey/feature/login/widget/password_login_widget.dart';

import '../../../components/color_comp.dart';
import '../../../utility/string_content_util.dart';

class ContentLoginWidget extends StatelessWidget {
  const ContentLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.65,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Column(
          children: const [
            Align(
              alignment: Alignment.center,
              child: Text(
                StringContentUtil.loginTitle,
                style: TextStyle(
                    color: primaryColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 32),
            EmailLoginWidget(),
            PasswordLoginWidget(),
            ButtonSubmitLoginWidget()
          ],
        ),
      ),
    );
  }
}
