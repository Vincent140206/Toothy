import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'onboarding_screen_template.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<Map<String, String>> _onboardingData = [
    {
      "title": "Cek Gigi \nJadi Mudah",
      "image": "assets/images/Splash1.png",
    },
    {
      "title": "Toothy Menjaga \nKesehatan Gigimu",
      "image": "assets/images/Splash1.png",
    },
    {
      "title": "Mulai Bersama \nToothy",
      "image": "assets/images/Splash2.png",
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                _currentPage = value;
              });
            },
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return OnBoardingScreen(
                title: _onboardingData[index]['title']!,
                imagePath: _onboardingData[index]['image']!,
              );
            },
          ),
          Positioned(
            left: screenWidth * 0.73,
            top: screenHeight * 0.79,
            child: Container(
              width: screenWidth * 0.18,
              height: screenWidth * 0.18,
              decoration: const ShapeDecoration(
                color: Color(0xFF92D5DA),
                shape: OvalBorder(),
              ),
              child: IconButton(
                onPressed: () {
                  if (_currentPage < _onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Navigator.pushReplacementNamed(context, '/login');
                  }
                },
                icon: SvgPicture.asset('assets/icons/arrow_right.svg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}