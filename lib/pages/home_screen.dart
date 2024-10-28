import 'package:flutter/material.dart';
import 'package:flutterapp/pages/chat_screen.dart';
import 'package:flutterapp/pages/cry_detection/cry_recorder.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFff7000).withOpacity(0.8), // Theme color with gradient effect
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title and welcome message
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  'Welcome to Todly!',
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black.withOpacity(0.3),
                        offset: Offset(3, 3),
                      ),
                    ],
                  ),
                ),
              ),

              // Image or illustration for the homepage
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/toddler_home.png'), // Replace with your image
                      fit: BoxFit.contain,
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 20,
                        offset: Offset(0, 3), // Shadow position
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Subtitle or descriptive text
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Monitor your toddler\'s activities effortlessly. Start cry detection or chat with Todly for assistance.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFFff7000),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),

              Spacer(), // Pushes buttons to the bottom

              // Start Cry Detection Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CryRecorder()),
                    );
                  },
                  icon: Icon(Icons.mic, size: 24, color: Colors.white), // Set icon color to white
                  label: Text(
                    'Start Cry Detection',
                    style: TextStyle(color: Colors.white), // Set text color to white
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFff7000), // Theme color
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 8,
                    textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    // Set foreground color for both icon and text
                    foregroundColor: Colors.white,
                  ),
                ),
              ),

              // Todly Chat Assistant Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatAssistant()),
                    );
                  },
                  icon: Icon(Icons.assistant, size: 24, color: Color(0xFFff7000)),
                  label: Text(
                    'Chat with Todly',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFFff7000),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Color(0xFFff7000), width: 2),
                    padding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20), // Spacing at the bottom
            ],
          ),
        ),
      ),
    );
  }
}