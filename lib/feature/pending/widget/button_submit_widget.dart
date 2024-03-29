import 'package:flutter/material.dart';

import '../../../components/color_comp.dart';

class ButtonSubmitWidget extends StatelessWidget {
  const ButtonSubmitWidget(
      {super.key, this.ontap, required this.isConnect, required this.isEmpty});
  final Function()? ontap;
  final bool isConnect;
  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: isConnect && isEmpty ? primaryColor : Colors.grey,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
            child: Text('Sinkronisasi Data',
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.w600))),
      ),
    );
  }
}
