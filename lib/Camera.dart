// ignore_for_file: must_be_immutable, depend_on_referenced_packages, non_constant_identifier_names
import 'dart:io';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ImageScanner extends StatefulWidget {
  ImageScanner({Key? key, required this.camera}) : super(key: key);
  CameraController camera;
  @override
  State<ImageScanner> createState() => _ImageScannerState();
}

class _ImageScannerState extends State<ImageScanner> {
  @override
  bool flash = false;
  void toggleFlash() {
    flash = !flash;
  }

  void dispose() {
    widget.camera.dispose();
    super.dispose();
  }

  @override
  void initState() {
    takePicture().then((value) {
      takePicture();
    });
    super.initState();
  }
  Future<void> _onTap(TapUpDetails details) async {
    if(widget.camera.value.isInitialized) {
      showFocusCircle = true;
      x = details.localPosition.dx;
      y = details.localPosition.dy;

      double fullWidth = MediaQuery.of(context).size.width;
      double cameraHeight = fullWidth * widget.camera.value.aspectRatio;

      double xp = x / fullWidth;
      double yp = y / cameraHeight;

      Offset point = Offset(xp,yp);
      print("point : $point");

      // Manually focus
      await widget.camera.setFocusPoint(point);
      setState(() {
        Future.delayed(const Duration(seconds: 2)).whenComplete(() {
          setState(() {
            showFocusCircle = false;
          });
        });
      });
    }
  }


  final textRecognizer = TextRecognizer();
  String? recognizedText = '';
  bool showFocusCircle = false;
  double x = 0;
  double y = 0;
  XFile? Ximage; //for captured image
  Future<void> takePicture() async {
    if (widget.camera.value.isInitialized) {
      flash
          ? widget.camera.setFlashMode(FlashMode.always)
          : widget.camera.setFlashMode(FlashMode.off);
      Ximage = (await widget.camera.takePicture());
      File file = File(Ximage!.path);

      final inputImage = InputImage.fromFile(file);
      await textRecognizer.processImage(inputImage).then((value) {
        takePicture();
        setState(() {
          recognizedText = value.text;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GestureDetector(
      onTapUp: _onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: CameraPreview(widget.camera),
          ),
          if(showFocusCircle) Positioned(
            top: y-20,
            left: x-20,
            child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white,width: 1.5)
              ),
            )),

          Text(
            recognizedText!,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextButton(
                  onPressed: () {
                    toggleFlash();
                  },
                  child: const Text('Flash')),
            ),
          ),
        ],
      ),
    ));
  }
}

