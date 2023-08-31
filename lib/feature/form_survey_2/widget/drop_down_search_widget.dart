import 'package:flutter/material.dart';

class DropDownSearchWidget extends StatelessWidget {
  const DropDownSearchWidget({
    super.key,
    required this.title,
    required this.hint,
    required this.onTap,
    required this.value,
  });

  final Function()? onTap;
  final String title;
  final String hint;
  final String? value;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF575551),
                  fontWeight: FontWeight.w600),
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: onTap,
            child: Container(
              width: MediaQuery.of(context).size.width * 0.78,
              height: 47,
              decoration: BoxDecoration(
                color: Colors.transparent,
                border:
                    Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
                borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              ),
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? hint,
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF575551)),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
