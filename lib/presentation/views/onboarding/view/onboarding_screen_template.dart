import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  final String imagePath;
  final String title;

  const OnBoardingScreen({
    super.key,
    required this.imagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        Container(
          color: const Color(0xFF09C2BD),
        ),
        Positioned(
          left: screenWidth * 0.68,
          top: screenHeight * 1.17,
          child: Container(
            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(-1.57),
            width: screenWidth * 1.18,
            height: screenHeight * 0.13,
            decoration: ShapeDecoration(
              color: const Color(0x33B8FFFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: screenWidth * 0.40,
          top: screenHeight * -0.26,
          child: Container(
            transform: Matrix4.identity()..translate(0.0, 0.0)..rotateZ(1.57),
            width: screenWidth * 1.32,
            height: screenHeight * 0.13,
            decoration: ShapeDecoration(
              color: const Color(0x33B8FFFC),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: screenWidth * -0.36,
          top: screenHeight * 0.58,
          child: Container(
            width: screenWidth * 0.73,
            height: screenHeight * 0.35,
            decoration: const ShapeDecoration(
              color: Color(0x33B8FFFC),
              shape: OvalBorder(),
            ),
          ),
        ),
        Positioned(
          left: screenWidth * 0.63,
          top: screenHeight * 0.04,
          child: Container(
            width: screenWidth * 0.73,
            height: screenHeight * 0.35,
            decoration: const ShapeDecoration(
              color: Color(0x33B8FFFC),
              shape: OvalBorder(),
            ),
          ),
        ),
        Positioned(
          top: screenHeight * 0.4,
          left: screenWidth * 0.12,
          right: screenWidth * 0.12,
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.white,
              fontSize: screenWidth * 0.1,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              height: 1.20,
            ),
          ),
        ),
        Positioned(
          left: screenWidth * -0.08,
          top: screenHeight * 0.58,
          child: Image.asset(
            imagePath,
            width: screenWidth,
            height: screenWidth,
            fit: BoxFit.contain,
          ),
        ),
      ],
    );
  }
}
