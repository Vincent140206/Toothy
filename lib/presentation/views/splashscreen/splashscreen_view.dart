import 'package:flutter/material.dart';
import '../../../../core/services/auth_services.dart';

class SplashscreenView extends StatefulWidget {
  const SplashscreenView({super.key});

  @override
  State<SplashscreenView> createState() => _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  final _authService = AuthServices();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));

      final sessionValid = await _authService.checkSession();
      if (!mounted) return;

      if (sessionValid) {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/onboarding', (route) => false);
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF09C2BD)),

          Positioned(
            left: screenWidth * 0.68,
            top: screenHeight * 1.17,
            child: Container(
              transform: Matrix4.identity()..rotateZ(-1.57),
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
              transform: Matrix4.identity()..rotateZ(1.57),
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

          Align(
            alignment: const Alignment(0, -0.5),
            child: Text(
              'Toothy \nJaga Gigi',
              textAlign: TextAlign.center,
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
            left: screenWidth * -0.1,
            top: screenHeight * 0.44,
            child: Container(
              width: screenWidth * 1.2,
              height: screenHeight * 0.56,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Splash2.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
