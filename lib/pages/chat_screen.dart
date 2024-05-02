import "package:flutter/material.dart";
import "package:flutterapp/components/ChatBubble_screen.dart";
import "package:flutterapp/components/ChatInputField_screen.dart";
import "package:flutterapp/components/SendButton_screen.dart";

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
        return ChatBubble(text: _messages[index]);
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
        title: Text('Chat'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: _buildChat(),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.01),
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
    );
  }
}
