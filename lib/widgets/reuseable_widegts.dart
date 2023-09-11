// ignore_for_file: depend_on_referenced_packages, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatefulWidget {
  dynamic topleft;
  dynamic topRight;
  dynamic bottomleft;
  dynamic bottomRight;
  double? height;
  double? width;
  double? space;
  var img;
  Color firstcolor;
  Color secondcolor;
  var name;
 VoidCallback ? onpress;
  CustomContainer(

      {
        this.onpress,
        required this.height,
      required this.bottomRight,
      required this.topRight,
      required this.width,
      required this.img,
      required this.bottomleft,
      required this.firstcolor,
      required this.secondcolor,
      required this.space,
      required this.topleft,
      required this.name,
      Key? key})
      : super(key: key);

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
   @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.height,
        width: widget.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(widget.topleft),
            topRight: Radius.circular(widget.topRight),
            bottomLeft: Radius.circular(widget.bottomleft),
            bottomRight: Radius.circular(widget.bottomRight),
          ),
          gradient: LinearGradient(
            colors: [widget.firstcolor, widget.secondcolor],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap:widget.onpress ,
              child: SvgPicture.asset(
                widget.img,
                height: 50,
                width: 50,
              ),
            ),
            SizedBox(
              height: widget.space,
            ),
            Text(
              widget.name,
              style: GoogleFonts.inter(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            )
          ],
        ));
  }
}
