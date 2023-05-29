import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/login/provider/login_provider.dart';
import 'package:provider/provider.dart';

import '../../../utility/string_content_util.dart';

class EmailLoginWidget extends StatefulWidget {
  const EmailLoginWidget({
    super.key,
  });

  @override
  State<EmailLoginWidget> createState() => _EmailLoginWidgetState();
}

class _EmailLoginWidgetState extends State<EmailLoginWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProdiver = Provider.of<LoginProvider>(context);
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringContentUtil.emailTitleText,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          height: 58,
          decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Center(
            child: TextFormField(
              controller: _controller,
              onChanged: (val) {
                loginProdiver.setEmail(val);
              },
              autofocus: false,
              style: const TextStyle(fontSize: 15.0, color: Colors.black),
              decoration: InputDecoration(
                hintText: StringContentUtil.emailHintText,
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.05)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.05)),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
