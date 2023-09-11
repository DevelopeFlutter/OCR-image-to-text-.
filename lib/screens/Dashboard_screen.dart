// ignore_for_file: depend_on_referenced_packages, must_be_immutable, override_on_non_overriding_member, file_names, unused_import
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:imagerecognizer_app/config/app_colors.dart';
import 'package:imagerecognizer_app/services/camera_service.dart';
import 'package:imagerecognizer_app/services/image_picker_service.dart';
import 'package:imagerecognizer_app/widgets/reuseable_widegts.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final GlobalKey<_DashboardState> myWidgetKey = GlobalKey<_DashboardState>();

  @override
  
 
  @override
  void initState(){
    initCamera();
    super.initState();

  }
 
  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(top: deviceData.height / 8),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    )),
              ),
              Column(
                children: [
                  SizedBox(
                    height: deviceData.height / 50,
                  ),
                  Text(
                    'OCR SCANNER',
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: deviceData.height / 50,
                  ),
                  SvgPicture.asset(
                    'assets/svgs/dashbimg.svg',
                    // height: deviceData.height / 4,
                    width: deviceData.width * 0.86,
                  ),
                  Text(
                    'Converts Printed texts into editable texts',
                    style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.textcolor,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomContainer(
                        onpress: (){
                          selectImage(ImageSource.gallery,myWidgetKey);
                        },
                          height: 140,
                          bottomRight: 20.0,
                          topRight: 20.0,
                          width: 140,
                          img: 'assets/svgs/icon_gallery.svg',
                          bottomleft: 20.0,
                          firstcolor: AppColors.gallerycontainercolor2,
                          secondcolor: AppColors.gallerycontainercolor,
                          space: 10,
                          topleft: 20.0,
                          name: 'Gallery'),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomContainer(
                        onpress: (){
                          camera?.initialize().then((value) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) =>
                                  ImageScanner(camera: camera!)),
                            );

                          } );
                                // Center(child: CircularProgressIndicator());
                          } ,

                          height: 140,
                          bottomRight: 20.0,
                          topRight: 20.0,
                          width: 140,
                          img: 'assets/svgs/scaner.svg',
                          bottomleft: 20.0,
                          firstcolor: AppColors.scannercontainercolor2,
                          secondcolor:AppColors. scannercontainercolor,
                          space: 10,
                          topleft: 20.0,
                          name: 'Scanner'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomContainer(
                    onpress: (){
                      selectImage(ImageSource.camera,myWidgetKey);
                    },
                      height: deviceData.height/6.1,
                      bottomRight: 20.0,
                      topRight: 20.0,
                      width: deviceData.width*0.80,
                      img: 'assets/svgs/icon_camera.svg',
                      bottomleft: 20.0,
                      firstcolor:AppColors. cameracontainercolor2,
                      secondcolor: AppColors.cameracontainercolor,
                      space: 10,
                      topleft: 20.0,
                      name: 'Camera'

                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomContainer(
                      height: deviceData.height/6.1,
                      bottomRight: 20.0,
                      topRight: 20.0,
                      width: deviceData.width*0.80,
                      img: 'assets/svgs/save.svg',
                      bottomleft: 20.0,
                      firstcolor:AppColors. savecontainercolor2,
                      secondcolor:AppColors. savecontainercolor,
                      space: 10,
                      topleft: 20.0,
                      name: 'Saved',
                    onpress: (){

                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}


 