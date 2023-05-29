import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/string_content_util.dart';
import 'package:provider/provider.dart';

import '../provider/login_provider.dart';

class PasswordLoginWidget extends StatefulWidget {
  const PasswordLoginWidget({
    super.key,
  });

  @override
  State<PasswordLoginWidget> createState() => _PasswordLoginWidgetState();
}

class _PasswordLoginWidgetState extends State<PasswordLoginWidget> {
  final TextEditingController _controller = TextEditingController();
  bool _isShow = false;
  @override
  Widget build(BuildContext context) {
    final LoginProvider loginProdiver = Provider.of<LoginProvider>(context);
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            StringContentUtil.passTitleText,
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: const Alignment(0, 0),
          children: <Widget>[
            Container(
              height: 58,
              decoration: BoxDecoration(
                border:
                    Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Center(
                child: TextField(
                  controller: _controller,
                  obscureText: _isShow,
                  onChanged: (val) {
                    loginProdiver.setPassword(val);
                  },
                  autofocus: false,
                  style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: StringContentUtil.passHintText,
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.grey.withOpacity(0.05)),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    if (_isShow) {
                      _isShow = false;
                    } else {
                      _isShow = true;
                    }
                  });
                },
                child: Icon(_isShow
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined),
              ),
            )
          ],
        ),
        const SizedBox(height: 45),
      ],
    );
  }
}
