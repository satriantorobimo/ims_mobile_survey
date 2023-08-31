import 'package:flutter/material.dart';
import 'package:mobile_survey/utility/string_router_util.dart';

class HeaderHomeWidget extends StatelessWidget {
  const HeaderHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            'assets/logo.png',
            width: 158,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, StringRouterUtil.inboxScreenRoute);
              },
              child: Image.asset(
                'assets/icon/inbox_icon.png',
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
