import 'dart:io';

import 'package:flutter/material.dart';

class PreviewImageAssetScreen extends StatefulWidget {
  final String imagePath;
  const PreviewImageAssetScreen({super.key, required this.imagePath});

  @override
  State<PreviewImageAssetScreen> createState() =>
      _PreviewImageAssetScreenState();
}

class _PreviewImageAssetScreenState extends State<PreviewImageAssetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                mainContent(widget.imagePath),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: double.infinity,
                    height: 80,
                    child: Center(
                      child: Text(
                        'BACK',
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainContent(String value) {
    return Center(
      child: Image.file(
        File(value),
        fit: BoxFit.fill,
      ),
    );
  }
}
