import 'package:flutter/material.dart';

import '../../../components/color_comp.dart';

class ButtonNext4Widget extends StatelessWidget {
  const ButtonNext4Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xFFf9f9f9),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.45,
              height: 45,
              child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // ignore: sort_child_properties_last
                  child: const Text(
                    'Sebelumnya',
                    style: TextStyle(
                        color: primaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0))),
                    side: MaterialStateProperty.all(const BorderSide(
                      color: primaryColor,
                    )),
                  )),
            ),
            InkWell(
              onTap: () {
                // Navigator.pushNamed(context, StringRouterUtil.form4ScreenRoute);
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.45,
                height: 45,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: const Center(
                    child: Text('Berikutnya',
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.w600))),
              ),
            ),
          ],
        ));
  }
}
