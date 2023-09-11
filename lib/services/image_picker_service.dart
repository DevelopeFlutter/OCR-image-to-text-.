// ignore_for_file: depend_on_referenced_packages, unused_import, invalid_use_of_protected_member

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagerecognizer_app/screens/Dashboard_screen.dart';
  File? imageFile;
  final textRecognizer = TextRecognizer();
  String? recognizedText='';
void selectImage(ImageSource source,GlobalKey key) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      final inputImage = InputImage.fromFile(imageFile!);
      await textRecognizer.processImage(inputImage).then((value) {
        key.currentState?.setState(() {
                    recognizedText = value.text;

        });(() {
        });
      });
    }
  }
