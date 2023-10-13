import 'package:flutter/material.dart';
import 'package:mobile_survey/feature/assignment/data/task_list_response_model.dart';

class CardWidget extends StatelessWidget {
  const CardWidget(
      {super.key,
      required this.color,
      required this.colorBg,
      required this.name,
      required this.label,
      required this.taskList});

  final Color color;
  final Color colorBg;
  final String name;
  final String label;
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
            name,
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
                taskList.mobileNo!,
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF575551)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorBg,
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    label,
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: color),
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
