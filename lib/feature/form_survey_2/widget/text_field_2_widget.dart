import 'package:flutter/material.dart';

class TextField2Widget extends StatefulWidget {
  const TextField2Widget({super.key});

  @override
  State<TextField2Widget> createState() => _TextField2WidgetState();
}

class _TextField2WidgetState extends State<TextField2Widget> {
  final TextEditingController _textCtrl = TextEditingController();
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
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: MediaQuery.of(context).size.width * 0.78,
              child: const Text.rich(
                TextSpan(
                  style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF575551),
                      fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: 'Nama Ibu Kandung'),
                    TextSpan(
                        text: ' *',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.red,
                        )),
                  ],
                ),
              )),
          const SizedBox(height: 16),
          Container(
            height: 45,
            decoration: BoxDecoration(
              border:
                  Border.all(width: 1.0, color: Colors.grey.withOpacity(0.5)),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Center(
              child: TextFormField(
                controller: _textCtrl,
                autofocus: false,
                style: const TextStyle(fontSize: 15.0, color: Colors.black),
                onChanged: ((value) {}),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.only(left: 14.0),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  disabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.grey.withOpacity(0.05)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
