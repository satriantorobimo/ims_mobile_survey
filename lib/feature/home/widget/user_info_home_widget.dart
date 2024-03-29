import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/login/data/user_data_model.dart';

class UserInfoHomeWidget extends StatelessWidget {
  final User user;
  const UserInfoHomeWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Home',
            style: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w700),
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.09),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome back,',
                    style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.name,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Container()
            ],
          ),
        ),
      ],
    );
  }
}
