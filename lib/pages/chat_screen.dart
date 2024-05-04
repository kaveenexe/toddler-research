import "package:flutter/material.dart";
import "package:flutterapp/components/ChatUI/ChatBubble_screen.dart";
import "package:flutterapp/components/ChatUI/ChatInputField_screen.dart";
import "package:flutterapp/components/ChatUI/SendButton_screen.dart";

class ChatAssistant extends StatefulWidget {
  const ChatAssistant({super.key});

  @override
  State<ChatAssistant> createState() => _ChatAssistantState();
}

class _ChatAssistantState extends State<ChatAssistant> {
  final TextEditingController _textController = TextEditingController();
  List<String> _messages = [];

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _messages.add(text);
    });
  }

  @override
  Widget _buildChat() {
    return ListView.builder(
      itemCount: _messages.length,
      itemBuilder: (BuildContext context, int index) {
        return ChatBubble(text: _messages[index], isMe: true,);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // screen size
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              // Handle back button press here
            },
          ),
          title: const Text('Chat Assistant'), // Set the app bar title here
        ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildChat(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1, vertical: screenHeight * 0.01),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: ChatInputField(
                      textController: _textController,
                      onSubmit: _handleSubmitted,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.02),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
