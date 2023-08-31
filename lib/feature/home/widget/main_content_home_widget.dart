import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';

class MainContentHomeWidget extends StatelessWidget {
  const MainContentHomeWidget(
      {super.key,
      required this.ongoing,
      required this.returned,
      required this.done});
  final int ongoing;
  final int returned;
  final int done;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 44),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF534FD6).withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/ongoing_icon.png',
                      width: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ongoing',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: secondaryColor),
                ),
                const SizedBox(height: 4),
                Text(
                  '$ongoing Survey',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            )),
        const SizedBox(height: 16),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF217DCE).withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/returned_icon.png',
                      width: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Returned',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: thirdColor),
                ),
                const SizedBox(height: 4),
                Text(
                  '$returned Survey',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            )),
        const SizedBox(height: 16),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color(0xFF0C967A).withOpacity(0.5),
            ),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Colors.white.withOpacity(0.3),
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/icon/done_icon.png',
                      width: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Done',
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: fifthColor),
                ),
                const SizedBox(height: 4),
                Text(
                  '$done Survey',
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                )
              ],
            ))
      ],
    );
  }
}
