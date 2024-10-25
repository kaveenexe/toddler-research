import 'package:flutter/material.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_one.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_two.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_three.dart';
import 'package:flutterapp/pages/Onboarding/onboarding_four.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoaringScreen extends StatefulWidget {
  const OnBoaringScreen({super.key});

  @override
  State<OnBoaringScreen> createState() => _OnBoaringScreenState();
}

class _OnBoaringScreenState extends State<OnBoaringScreen> {
  // Page View Controller
  PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Page View
          PageView(
            controller: _controller,
            children: const [
              OnboardingOne(),
              OnboardingTwo(),
              OnboardingThree(),
              OnboardingFour(),
            ],
          ),
          // Dot Indicator
          Container(
            alignment: Alignment(0.7, 0.9),
            child: SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: const ExpandingDotsEffect(
                dotWidth: 10,
                dotHeight: 10,
                dotColor: Colors.white,
                activeDotColor: Color(0xFFFF7000),
              ),
            ),
          ),
        ],
      ),
    );
  }
}