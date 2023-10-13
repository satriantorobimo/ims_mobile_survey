import 'package:flutter/material.dart';
import 'package:mobile_survey/components/color_comp.dart';

import '../../assignment/data/task_list_response_model.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget({super.key, required this.taskList});
  final Data taskList;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey.withOpacity(0.5),
          width: 1.0,
        ),
        color: Colors.transparent,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            taskList.clientName!,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF575551)),
          ),
          const SizedBox(height: 8),
          Text(
            taskList.type!,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Color(0xFF575551)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                taskList.agreementNo!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF575551)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFECCCC),
                ),
                padding: const EdgeInsets.all(5),
                child: const Center(
                  child: Text(
                    'PENDING',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
