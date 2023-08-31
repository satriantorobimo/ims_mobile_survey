import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_survey/feature/inbox/data/inbox_response_model.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget({super.key, required this.data});

  final Data? data;

  @override
  Widget build(BuildContext context) {
    DateTime tempDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(data!.creDate!);

    var inputDate = DateTime.parse(tempDate.toString());
    var outputFormat = DateFormat('dd MMMM yyyy HH:mm:ss');
    var outputDate = outputFormat.format(inputDate);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data!.title!,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF575551)),
          ),
          const SizedBox(height: 8),
          Text(
            data!.message!,
            style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xFF575551)),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                outputDate,
                style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF575551)),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFFECCCC),
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text(
                    data!.picName!,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFFE64354)),
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
