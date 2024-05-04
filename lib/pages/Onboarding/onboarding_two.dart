import 'package:flutter/material.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({super.key});

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
                  "assets/OnboardingTwo.png",
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
                  "Decode your baby's needs effortlessly!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF654D4D))),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Text(
                "Advanced audio analysis and personalized notifications help you understand and respond to your little one's cues like never before",
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
