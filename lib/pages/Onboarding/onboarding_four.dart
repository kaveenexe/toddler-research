import 'package:flutter/material.dart';

class OnboardingFour extends StatelessWidget {
  const OnboardingFour({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 251, 230, 212),
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  "assets/OnboardingFour.png",
                  width: screenWidth,
                  height: screenHeight / 2,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 17, right: 17),
              child: const Text(
                  "Stay ahead of potential mishaps!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF654D4D))),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Text(
                "Instantly notify you when your toddler approaches danger zones, ensuring peace of mind wherever you are",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF654D4D)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
