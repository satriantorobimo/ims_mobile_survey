import 'package:flutter/material.dart';

import '../../../components/color_comp.dart';

class ButtonKeluarWidget extends StatelessWidget {
  const ButtonKeluarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 45,
      child: OutlinedButton(
          onPressed: () {},
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
