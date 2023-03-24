// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:imagerecognizer_app/Camera.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const OCRPage(),
    );
  }
}

class OCRPage extends StatefulWidget {
  const OCRPage({super.key});

  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {
  void BottomSheet(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    showModalBottomSheet(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) => SizedBox(
              height: mediaQuery.height / 5,
              child: Column(
                children: [
                  SizedBox(
                    height: mediaQuery.height / 70,
                  ),
                  const Text('Choose an action'),
                  SizedBox(
                    height: mediaQuery.height / 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                selectImage(ImageSource.gallery);
                              },
                              child: SvgPicture.asset(
                                'assets/svgs/gellery.svg',
                              ),
                            ),
                            const Text('Gallery')
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                  cameraWidget();
                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/Scanner.svg',
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                              const Text('Scanner')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                 selectImage(ImageSource.camera);

                                },
                                child: SvgPicture.asset(
                                  'assets/svgs/camera.svg',

                                ),
                              ),
                              const Text('Camera')
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ));
  }

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      final inputImage = InputImage.fromFile(imageFile!);
      await textRecognizer.processImage(inputImage).then((value) {
        setState(() {
          recognizedText = value.text;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }

  CameraController? _camera;
  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
        (camera) => camera.lensDirection == CameraLensDirection.back);
    _camera = CameraController(front, ResolutionPreset.ultraHigh);
    await _camera!.initialize();
  }

  void cameraWidget() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ImageScanner(camera: _camera!)),
    );
  }

  var _text = "TEXT";
  File? imageFile;
  final textRecognizer = TextRecognizer();
  String? recognizedText='';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white70,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('OCR In Flutter'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _text,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _initCamera();
                  BottomSheet(context);
                },
                child: const Text(
                  'Scanning',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            Text('$recognizedText'),

          ],
        ),
      ),
    );
  }
}
