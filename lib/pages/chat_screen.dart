import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutterapp/components/ChatUI/ChatBubble_screen.dart';
import 'package:flutterapp/components/ChatUI/ChatInputField_screen.dart';

class ChatAssistant extends StatefulWidget {
  const ChatAssistant({super.key});

  @override
  State<ChatAssistant> createState() => _ChatAssistantState();
}

class _ChatAssistantState extends State<ChatAssistant> {
  final TextEditingController _textController = TextEditingController();
  List<Map<String, dynamic>> _messages = []; // List to store messages with sender info
  bool _showTopAndMiddle = true; // State variable to control visibility
  bool _isLoading = false; // State variable to control loading indicator

  // Function to handle user-submitted input
  void _handleSubmitted(String text) async {
    _textController.clear();
    setState(() {
      _messages.add({"text": text, "isMe": true}); // Add user's message to chat
      _showTopAndMiddle = false; // Hide top and middle sections when a message is submitted
      _isLoading = true; // Show loading indicator
    });

    // Send the question to the backend and await a response
    String response = await _sendQuestionToBackend(text);

    setState(() {
      _isLoading = false; // Hide loading indicator
      _messages.add({"text": response, "isMe": false}); // Add bot's response to chat
    });
  }

  // Function to send question to backend
  Future<String> _sendQuestionToBackend(String question) async {
    final url = Uri.parse('http://34.28.36.165:5000//process'); // Update with your Flask backend URL
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": question, "source_lang": "si", "target_lang": "en"}), // Sending JSON body
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        return jsonResponse['answer'] ?? 'No response from backend.';
      } else {
        return 'Error: ${response.statusCode}';
      }
    } catch (e) {
      return 'Failed to connect to the backend: $e';
    }
  }

  Widget _buildChat() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(), // Disable inner scroll for SingleChildScrollView
      shrinkWrap: true, // Wrap content inside ListView
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(
          text: _messages[index]['text'],
          isMe: _messages[index]['isMe'],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //     icon: Icon(Icons.arrow_back),
      //     onPressed: () {
      //       // Handle back button press here
      //     },
      //   ),
      //   title: const Text('Todly Assistant'),
      // ),
      body: Container(
        color: Colors.white, // Set background color to white
        child: Column(
          children: [
            // Content section with scrolling
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      // Show Top and Middle sections conditionally
                      if (_showTopAndMiddle) ...[
                        // Top Section: Robot Image and Text
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/robot1.png', // robot image
                                height: screenHeight / 2.7,
                              ),
                              Text(
                                'ආයුබෝවන්!',
                                style: GoogleFonts.gemunuLibre(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'ඔබේ කුඩා දරුවා පිලිබදව ඇති ප්‍රශ්න මට යොමු කරන්න!',
                                style: TextStyle(fontSize: 15),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.05),

                        // Middle Section: Horizontally Scrollable Prompts
                        Container(
                          height: 80,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildPromptButton('මගේ දරුවා අඩන්නේ ඇයි?'),
                              _buildPromptButton('දරුවාට කන්න හොද අහාර මොනවාද?'),
                              _buildPromptButton('දරුවාට දින චර්යාවක් අවශ්‍යද?'),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // Chat section
                      _buildChat(),

                      // Show loading indicator if loading
                      if (_isLoading)
                        const Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
                            children: [
                              Text(
                                'විසඳුම සොයමින්...',
                                style: TextStyle(fontSize: 16), // Customize the text style
                              ),
                              SizedBox(width: 10), // Add some spacing between text and loader
                              SpinKitDancingSquare( // Using SpinKitDancingSquare loader
                                color: Color(0xFFff7000), // Customize color to orange
                                size: 50.0,
                              ),
                            ],
                          ),
                        ),

                    ],
                  ),
                ),
              ),
            ),

            // Bottom Section: Input Field and Send Button
            ChatInputField(
              textController: _textController,
              onSubmit: _handleSubmitted,
            ),
            const Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text('*Todly වැරදි පිලිතුරු දිමට පුළුවන්. කරුණාකර ප්‍රතිචාර දෙවරක් පරීක්ෂා කරන්න.',
                style: TextStyle(
                  fontSize: 8
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Function to create prompt buttons
  Widget _buildPromptButton(String text) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFF7000), // Orange color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () {
          _handleSubmitted(text); // Handle prompt button click
        },
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}