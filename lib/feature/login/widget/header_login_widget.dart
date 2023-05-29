import 'package:flutter/material.dart';

class HeaderLoginWidget extends StatelessWidget {
  const HeaderLoginWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      child: Center(
          child: Image.asset(
        'assets/logo.png',
        width: MediaQuery.of(context).size.width * 0.7,
      )),
    );
  }
}
