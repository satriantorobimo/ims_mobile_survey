import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({super.key, required this.camera});
  final CameraDescription camera;

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late String imagePath = '';
  late Future<void> _initializeControllerFuture;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: imagePath != ''
          ? Container(
              width: mediaSize.width,
              height: mediaSize.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(imagePath)),
                  fit: BoxFit.fitHeight,
                ),
              ),
            )
          : isLoading
              ? const Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator()))
              : Center(
                  child: Transform.scale(
                      scale: 1 /
                          (_controller.value.aspectRatio *
                              mediaSize.aspectRatio),
                      alignment: Alignment.center,
                      child: CameraPreview(_controller)),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if (imagePath != '') {
            Navigator.pop(context, imagePath);
          } else {
            try {
              await _initializeControllerFuture;

              final image = await _controller.takePicture();

              if (!mounted) return;
              log(image.path);
              setState(() {
                imagePath = image.path;
              });
            } catch (e) {
              log(e.toString());
            }
          }
        },
        child: imagePath != ''
            ? const Icon(Icons.check)
            : const Icon(Icons.camera_alt),
      ),
    );
  }
}
