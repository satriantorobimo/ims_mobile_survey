import 'package:flutter/material.dart';

import '../../../components/color_comp.dart';

class ButtonSubmitWidget extends StatelessWidget {
  const ButtonSubmitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text('Kirim Ulang',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}
