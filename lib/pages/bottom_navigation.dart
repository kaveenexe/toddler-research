import 'package:flutter/material.dart';
import 'package:flutterapp/pages/cry_detection/cry_recorder.dart';
import 'package:flutterapp/pages/home_screen.dart';
import 'package:flutterapp/pages/livefeed.dart';
import 'chat_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // List of pages to navigate (including the home page)
  final List<Widget> _pages = [
    HomePage(), // Updated Home page design
    ChatAssistant(),
    CryRecorder(),
    Livefeed()
  ];

  // Function to handle tab change
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Updated body content
      body: _pages[_selectedIndex],

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // Update the selected index
        onTap: _onItemTapped, // Handle tap events
        type: BottomNavigationBarType.fixed, // Ensure all items are visible
        selectedItemColor: Color(0xFFff7000), // Set selected item color
        unselectedItemColor: Colors.grey, // Set unselected item color
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home), // Icon for Home tab
            label: 'Home',           // Label for Home tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant), // Icon for Todly
            label: 'Todly',          // Label for Todly tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mic), // Icon for Cry Recorder tab
            label: 'Crying',          // Label for Cry Recorder tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.emoji_emotions), // Icon for Emotions tab
            label: 'Emotions',          // Label for Emotions tab
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dangerous), // Icon for Danger tab
            label: 'Danger',           // Label for Danger tab
          ),
        ],
      ),
    );
  }
}