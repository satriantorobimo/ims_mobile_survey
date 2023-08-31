import 'package:flutter/material.dart';

class FormInfo1Widget extends StatelessWidget {
  const FormInfo1Widget(
      {super.key,
      required this.widthTitle,
      required this.widthContent,
      required this.heightContent,
      required this.title,
      required this.content});

  final double widthTitle;
  final double widthContent;
  final double heightContent;
  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widthTitle,
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
            height: heightContent,
            padding: const EdgeInsets.all(8),
            width: widthContent,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(content,
                  style: TextStyle(
                      fontSize: 14,
                      color: const Color(0xFF2D2A26).withOpacity(0.5),
                      fontWeight: FontWeight.w400)),
            ),
          ),
        ],
      ),
    );
  }
}
