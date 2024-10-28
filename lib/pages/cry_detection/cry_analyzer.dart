import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterapp/pages/cry_detection/cry_predicting.dart';

class CryAnalyzer extends StatefulWidget {
  @override
  _CryAnalyzer createState() => _CryAnalyzer();
}

class _CryAnalyzer extends State<CryAnalyzer> {
  bool isRecording = true;
  int recordingTime = 0;

  @override
  void initState() {
    super.initState();
    startRecording();
  }

  void startRecording() {
    // Simulate recording time increment
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (!isRecording || recordingTime >= 5) {
        timer.cancel();
        navigateToCryPredictor();
      } else {
        setState(() {
          recordingTime++;
        });
      }
    });
  }

  void stopRecording() {
    setState(() {
      isRecording = false;
    });
    navigateToCryPredictor();
  }

  void navigateToCryPredictor() {
    // Replace this with your navigation to CryPredictor page
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CryPredictor(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Color.fromARGB(255, 255, 255, 255), // Light turquoise background
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Analyzing',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: Color(0xFFFF7000), // Custom orange color
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Timer and recording indicator
            Container(
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Analyzing ${recordingTime}s ',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 12,
                  ),
                ],
              ),
            ),
            SizedBox(height: 80),
            // Circular recording progress with stop button
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 180,
                  width: 180,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color.fromRGBO(255, 136, 0, 1)), // Custom orange color
                    strokeWidth: 18,
                    value: recordingTime / 5, // Circular progress value
                    backgroundColor: const Color.fromARGB(255, 237, 235, 235),
                  ),
                ),
                // Stop button with unique styling
                ElevatedButton(
                  onPressed: stopRecording,
                  style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(28),
                    backgroundColor:
                        Color.fromRGBO(255, 136, 0, 1), // Custom orange color
                    shadowColor: Colors.black38,
                    elevation: 10,
                  ),
                  child: Icon(Icons.stop, color: Colors.white, size: 36),
                ),
              ],
            ),
            SizedBox(height: 70),
            // Capture instruction
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black87,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                shadowColor: Colors.black38,
                elevation: 5,
              ),
              child: Text(
                'Cry captured?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
            SizedBox(height: 24),
            // Stop instruction text
            Text.rich(
              TextSpan(
                text: 'Press ', // Normal text before "stop"
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  fontFamily: 'Poppins',
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: 'stop', // Bold "stop" text
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  TextSpan(
                    text: ' to check for the result', // Normal text after "stop"
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
