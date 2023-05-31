import 'package:flutter/material.dart';

class MainContentWidget extends StatelessWidget {
  const MainContentWidget(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Container(
                height: 45,
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  border: Border.all(
                      width: 1.0, color: Colors.grey.withOpacity(0.5)),
                  borderRadius: const BorderRadius.all(Radius.circular(6.0)),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(content,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF2D2A26),
                          fontWeight: FontWeight.w400)),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
