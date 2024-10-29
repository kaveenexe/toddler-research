import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutterapp/pages/cry_detection/cry_recorder.dart';
import 'package:flutterapp/pages/bottom_navigation.dart';
import 'package:http/http.dart' as http;

const Color customOrange = Color(0xFFFF7000);
const Color customGrey = Color(0xFFB4B4B4);

class CryPredictor extends StatefulWidget {
  const CryPredictor({Key? key}) : super(key: key);

  @override
  _CryPredictorState createState() => _CryPredictorState();
}

class _CryPredictorState extends State<CryPredictor> {
  String _prediction = '';

  @override
  void initState() {
    super.initState();
    _fetchPrediction();
  }

  Future<void> _fetchPrediction() async {
    try {
      final response =
          await http.get(Uri.parse('https://e2f7-212-104-231-182.ngrok-free.app/get-prediction'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _prediction = data['predicted_class'] ?? 'No prediction available';
        });
      } else {
        setState(() {
          _prediction = 'Failed to get prediction';
        });
      }
    } catch (e) {
      setState(() {
        _prediction = 'Error: $e';
      });
    }
  }

  List<String> _getRecommendations(String cryType) {
    switch (cryType) {
      case 'Hungry':
        return [
          'Feed the baby',
          'Check if it’s time for a meal',
          'Offer a pacifier'
        ];
      case 'Belly Pain':
        return [
          'Try gentle tummy rubs',
          'Check for signs of gas',
          'Burp the baby'
        ];
      case 'Tired':
        return [
          'Rock the baby to sleep',
          'Create a quiet environment',
          'Check the baby’s sleep schedule'
        ];
      case 'Discomfort':
        return [
          'Check for any irritants',
          'Adjust the baby’s clothing',
          'Ensure the baby is comfortable'
        ];
      case 'Burping':
        return [
          'Burp the baby after feeding',
          'Try different burping positions',
          'Check for signs of discomfort'
        ];
      default:
        return ['No recommendations available'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Prediction',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: customOrange,
        elevation: 1,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Colors.white),
            onPressed: () {
              // Handle notifications
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFFFFFFFF),
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Image Container
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 196, 195, 195)
                          .withOpacity(0.3),
                      spreadRadius: 4,
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/baby.png',
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              // Prediction Container
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor:
                                  const Color.fromARGB(255, 233, 232, 232),
                              child: Image.asset(
                                'assets/cry_dark.jpg',
                                width: 45,
                                height: 45,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 14),
                            Text(
                              _prediction,
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Poppins',
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 15),
                          decoration: BoxDecoration(
                            color: customOrange,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: const Text(
                            'Most Likely',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 1),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Recommendations',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'We think these will help calm your baby! Try working through the following recommendations',
                    style: TextStyle(
                      color: Color.fromARGB(255, 16, 16, 16),
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              // Recommendations Section
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    ..._getRecommendations(_prediction)
                        .map((rec) => _buildRecommendationItem(rec))
                        .toList(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Cancel button to navigate to CryRecorder
                  Padding(
                    padding:
                        const EdgeInsets.all(20), // Adjust padding as needed
                    child: SizedBox(
                      width: 160,
                      height: 50,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(), // Replace with your CryRecorder page
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(
                            color: customOrange,
                            width: 2.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          'GO TO HOME',
                          style: TextStyle(
                            color: customOrange,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Mic button to navigate to CryRecorder
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 20), // Adjust the right margin as needed
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CryRecorder(), // Replace with your CryRecorder page
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: customOrange,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(20),
                      ),
                      child:
                          const Icon(Icons.mic, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 0.0), // Padding around the recommendation box
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Internal padding
        margin: const EdgeInsets.symmetric(vertical: 3), // Margin between boxes
        decoration: BoxDecoration(
          color: const Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Tick icon
            const Icon(
              Icons.check,
              color: Color.fromARGB(255, 227, 96, 9),
              size: 24,
            ),
            const SizedBox(width: 15),
            // Text of the recommendation
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
