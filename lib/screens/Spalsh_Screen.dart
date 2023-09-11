// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, deprecated_member_use, file_names

import 'dart:async';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:imagerecognizer_app/config/app_colors.dart';
import 'package:imagerecognizer_app/screens/Dashboard_screen.dart';
import 'package:google_fonts/google_fonts.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Dashboard())));
  }


  @override
  Widget build(BuildContext context) {
    var deviceData = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            color: Colors.blue,
            'assets/svgs/spalsh_screen.svg',
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: deviceData.width * 0.9,
              child: Text(
                'Convert your phone into a text scanner using this app',
                overflow: TextOverflow.clip,
                textAlign: TextAlign.center,
                maxLines: 2,
                style: GoogleFonts.inter(
                    fontSize: 14,
                    color:AppColors.textcolor,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
