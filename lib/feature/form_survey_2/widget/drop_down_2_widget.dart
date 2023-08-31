import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDown2Widget extends StatelessWidget {
  const DropDown2Widget({
    super.key,
    required this.onChange,
    required this.dropdownItems,
    required this.title,
    required this.hint,
    required this.value,
  });

  final Function(String?) onChange;
  final List<String> dropdownItems;
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
          CustomDropdownButton2(
            hint: hint,
            dropdownItems: dropdownItems,
            buttonWidth: double.infinity,
            buttonHeight: 47,
            dropdownWidth: MediaQuery.of(context).size.width * 0.78,
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
            ),
            iconSize: 20,
            value: value,
            buttonDecoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            onChanged: onChange,
          ),
        ],
      ),
    );
  }
}
